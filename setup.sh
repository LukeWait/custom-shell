#!/bin/bash

RC='\e[0m'
RED='\e[31m'
YELLOW='\e[33m'
GREEN='\e[32m'

# Checks if a command exists in the system.
command_exists() {
    command -v $1 >/dev/null 2>&1
}

# Checks the environment for required tools and permissions.
checkEnv() {
    ## Check for requirements.
    REQUIREMENTS='curl groups sudo'
    if ! command_exists ${REQUIREMENTS}; then
        echo -e "${RED}To run me, you need: ${REQUIREMENTS}${RC}"
        exit 1
    fi

    ## Check package handler.
    PACKAGEMANAGER='apt yum dnf pacman zypper'
    for pgm in ${PACKAGEMANAGER}; do
        if command_exists ${pgm}; then
            PACKAGER=${pgm}
            echo -e "Using ${pgm}"
        fi
    done

    if [ -z "${PACKAGER}" ]; then
        echo -e "${RED}Can't find a supported package manager"
        exit 1
    fi

    ## Check if the current directory is writable.
    GITPATH="$(dirname "$(realpath "$0")")"
    if [[ ! -w ${GITPATH} ]]; then
        echo -e "${RED}Can't write to ${GITPATH}${RC}"
        exit 1
    fi

    ## Check superuser group
    SUPERUSERGROUP='wheel sudo root'
    for sug in ${SUPERUSERGROUP}; do
        if groups | grep ${sug}; then
            SUGROUP=${sug}
            echo -e "Super user group ${SUGROUP}"
        fi
    done

    ## Check if member of the sudo group.
    if ! groups | grep ${SUGROUP} >/dev/null; then
        echo -e "${RED}You need to be a member of the sudo group to run me!"
        exit 1
    fi
}

# Installs required dependencies based on the detected package manager.
installDepend() {
    ## Check for dependencies.
    DEPENDENCIES='bash bash-completion tar tree multitail tldr trash-cli fzf btop bat thefuck'
    echo -e "${YELLOW}Installing dependencies...${RC}"

    case $PACKAGER in
        pacman)
            if ! command_exists yay && ! command_exists paru; then
                echo "Installing yay as AUR helper..."
                sudo pacman --noconfirm -S base-devel
                cd /opt && sudo git clone https://aur.archlinux.org/yay-git.git && sudo chown -R ${USER}:${USER} ./yay-git
                cd yay-git && makepkg --noconfirm -si
            else
                echo "AUR helper already installed"
            fi
            if command_exists yay; then
                AUR_HELPER="yay"
            elif command_exists paru; then
                AUR_HELPER="paru"
            else
                echo "No AUR helper found. Please install yay or paru."
                exit 1
            fi
            ${AUR_HELPER} --noconfirm -S ${DEPENDENCIES}
            sudo pacman -Syu
            sudo pacman -S thefuck
            ;;
        apt)
            mkdir -p ~/.local/share
            mkdir -p ~/.config
            
            sudo apt install -yq nala
            sudo nala install ${DEPENDENCIES}
            sudo nala update

            # Install python/pip
            sudo nala install python3-dev python3-pip python3-setuptools

            # Update tldr pages
            tldr -u

            # Fetch the latest fastfetch release URL for linux-amd64 deb file
            FASTFETCH_URL=$(curl -s https://api.github.com/repos/fastfetch-cli/fastfetch/releases/latest | grep "browser_download_url.*linux-amd64.deb" | cut -d '"' -f 4)
            # Download the latest fastfetch deb file
            curl -sL $FASTFETCH_URL -o /tmp/fastfetch_latest_amd64.deb
            # Install the downloaded deb file using nala
            sudo nala install /tmp/fastfetch_latest_amd64.deb
            ;;
        zypper)
            sudo zypper install -y ${DEPENDENCIES}
            sudo zypper refresh
            ;;
        dnf)
            sudo dnf install -y ${DEPENDENCIES}
            sudo dnf check-update
            ;;
        yum)
            sudo yum install -y ${DEPENDENCIES}
            ;;
        *)
            echo "No supported package manager found. Please install packages manually."
            exit 1
            ;;
    esac
}

# Installs Starship prompt if not already installed.
installStarship() {
    if command_exists starship; then
        echo "Starship already installed"
        return
    fi

    if ! curl -sS https://starship.rs/install.sh | sh; then
        echo -e "${RED}Something went wrong during starship install!${RC}"
        exit 1
    fi

    ## Add nerd fonts for compatability with Starship icons only if supported.
    if ! tty -s; then
        mkdir -p ~/.local/share/fonts

        # Add the FiraCode Nerd Font to the fonts directory.
        wget -O ~/.local/share/fonts/FiraCode.zip https://github.com/ryanoasis/nerd-fonts/releases/download/v2.3.3/FiraCode.zip
        unzip ~/.local/share/fonts/FiraCode.zip -d ~/.local/share/fonts
        rm ~/.local/share/fonts/FiraCode.zip

        fc-cache -fv
    fi
}

# Installs Zoxide if not already installed.
installZoxide() {
    if command_exists zoxide; then
        echo "Zoxide already installed"
        return
    fi

    if ! curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh; then
        echo -e "${RED}Something went wrong during zoxide install!${RC}"
        exit 1
    fi
}

# Links the config files to the user's home directory based on detected shell.
linkConfig() {
    ## Get the correct user home directory.
    USER_HOME=$(getent passwd "${SUDO_USER:-$USER}" | cut -d: -f6)

    ## Determine which shell is in use and check if a configuration file already exists
    SHELL_TYPE=$(basename "$SHELL")
    case $SHELL_TYPE in
        bash)
            SHELL_CONFIG=".bashrc"
            ;;
        zsh)
            SHELL_CONFIG=".zshrc"
            ;;
        *)
            echo -e "${RED}Unsupported shell: $SHELL_TYPE${RC}"
            exit 1
            ;;
    esac

    ## Determine the starship configuration file based on terminal type
    if tty -s; then
        STARSHIP_CONFIG="starship_tty.toml"
    else
        STARSHIP_CONFIG="starship.toml"
    fi

    ## Check if the old configuration file exists and move it if necessary
    OLD_CONFIG="${USER_HOME}/${SHELL_CONFIG}"
    if [[ -e "${OLD_CONFIG}" ]]; then
        echo -e "${YELLOW}Moving old ${SHELL_CONFIG} to ${USER_HOME}/${SHELL_CONFIG}.bak${RC}"
        if ! mv "${OLD_CONFIG}" "${USER_HOME}/${SHELL_CONFIG}.bak"; then
            echo -e "${RED}Can't move the old ${SHELL_CONFIG}!${RC}"
            exit 1
        fi
    fi

    ## Link the new configuration files
    echo -e "${YELLOW}Linking new configuration files...${RC}"
    ln -svf "${GITPATH}/${SHELL_CONFIG}" "${USER_HOME}/${SHELL_CONFIG}"
    ln -svf "${GITPATH}/${STARSHIP_CONFIG}" "${USER_HOME}/.config/starship.toml"
    echo -e "${GREEN}Done!\nrestart your shell to see the changes.${RC}"                 
}

checkEnv
installDepend
installStarship
installZoxide
linkConfig
