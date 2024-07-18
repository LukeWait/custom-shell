#!/bin/bash
iatest=$(expr index "$-" i)

#######################################################
# SYSTEM CONFIG
#######################################################
if [ -f /usr/bin/fastfetch ]; then
	fastfetch
fi

# Source global definitions
if [ -f /etc/bashrc ]; then
	 . /etc/bashrc
fi

#######################################################
# EXPORTS
#######################################################
# Disable the bell
if [[ $iatest -gt 0 ]]; then bind "set bell-style visible"; fi

# Expand the history size
export HISTFILESIZE=10000
export HISTSIZE=500

# Don't put duplicate lines in the history and do not add lines that start with a space
export HISTCONTROL=erasedups:ignoredups:ignorespace

# Check the window size after each command and, if necessary, update the values of LINES and COLUMNS
shopt -s checkwinsize

# Causes bash to append to history instead of overwriting it so if you start a new terminal, you have old session history
shopt -s histappend
PROMPT_COMMAND='history -a'

# Allow ctrl-S for history navigation (with ctrl-R)
[[ $- == *i* ]] && stty -ixon

# Ignore case on auto-completion
# Note: bind used instead of sticking these in .inputrc
if [[ $iatest -gt 0 ]]; then bind "set completion-ignore-case on"; fi

# Show auto-completion list automatically, without double tab
if [[ $iatest -gt 0 ]]; then bind "set show-all-if-ambiguous On"; fi

# Set the default editor
export EDITOR=nano
export VISUAL=nano

# Replace batcat with cat on Fedora as batcat is not available as a RPM in any form
if command -v lsb_release >/dev/null; then
	DISTRIBUTION=$(lsb_release -si)

	if [ "$DISTRIBUTION" = "Fedora" ] || [ "$DISTRIBUTION" = "Arch" ]; then
		alias cat='bat'
	else
		alias cat='batcat'
	fi
fi

# To have colors for ls and all grep commands such as grep, egrep and zgrep
export CLICOLOR=1
export LS_COLORS='no=00:fi=00:di=00;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:*.xml=00;31:'
#export GREP_OPTIONS='--color=auto' #deprecated
alias grep="/usr/bin/grep $GREP_OPTIONS"
unset GREP_OPTIONS

# Color for manpages in less makes manpages a little easier to read
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

#######################################################
# ALIASES
#######################################################
# To temporarily bypass an alias, precede the command with a '\'

# Alert alias for long running commands.  Use like so: 'sleep 10; alert'
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(command history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Edit this .bashrc file
alias ebrc='sudo nano ~/.bashrc'

# Alias to show the date
alias da='date "+%Y-%m-%d %A %T %Z"'

# Aliases to modified commands
alias cp='cp -i'
alias mv='mv -i'
alias rm='trash -v'
alias mkdir='mkdir -p'
alias ps='ps auxf'
alias ping='ping -c 10'
alias less='less -R'
alias multitail='multitail --no-repeat -c'
alias freshclam='sudo freshclam'
alias apt='sudo apt'
alias apt-get='sudo apt-get'

# Change directory aliases
alias home='cd ~'
alias cd..='cd ..'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias bd='cd "$OLDPWD"'
alias web='cd /var/www/html'

# Remove a directory and all files
alias rmd='/bin/rm  --recursive --force --verbose '

# Aliases for multiple directory listing commands
alias la='ls -Alh' # show hidden files
alias ls='ls -aFh --color=always' # add colors and file type extensions
alias lx='ls -lXBh' # sort by extension
alias lk='ls -lSrh' # sort by size
alias lc='ls -lcrh' # sort by change time
alias lu='ls -lurh' # sort by access time
alias lr='ls -lRh' # recursive ls
alias lt='ls -ltrh' # sort by date
alias lm='ls -alh |more' # pipe through 'more'
alias lw='ls -xAh' # wide listing format
alias ll='ls -Fls' # long listing format
alias labc='ls -lap' #alphabetical sort
alias lf="ls -l | egrep -v '^d'" # files only
alias ldir="ls -l | egrep '^d'" # directories only

# Alias chmod commands
alias mx='chmod a+x'
alias 000='chmod -R 000'
alias 644='chmod -R 644'
alias 666='chmod -R 666'
alias 755='chmod -R 755'
alias 777='chmod -R 777'

# Search command line history
alias h="command history | grep "

# Search running processes
alias p="ps aux | grep "
alias topcpu="/bin/ps -eo pcpu,pid,user,args | sort -k 1 -r | head -10"

# Search files in the current folder
alias f="find . | grep "

# Count all files (recursively) in the current folder
alias countfiles="for t in files links directories; do echo \`find . -type \${t:0:1} | wc -l\` \$t; done 2> /dev/null"

# Show open ports
alias openports='netstat -nape --inet'

# Aliases for safe and forced reboots
alias rebootsafe='sudo shutdown -r now'
alias rebootforce='sudo shutdown -r -n now'

# Aliases to show disk space and space used in a folder
alias diskspace="du -S | sort -n -r |more"
alias folders='du -h --max-depth=1'
alias folderssort='find . -maxdepth 1 -type d -print0 | xargs -0 du -sk | sort -rn'
alias tree='tree -CAhF --dirsfirst'
alias treed='tree -CAFd'
alias mountedinfo='df -hT'

# Aliases for archives
alias mktar='tar -cvf'
alias mkbz2='tar -cvjf'
alias mkgz='tar -cvzf'
alias untar='tar -xvf'
alias unbz2='tar -xvjf'
alias ungz='tar -xvzf'

# Show all logs in /var/log
alias logs="sudo find /var/log -type f -exec file {} \; | grep 'text' | cut -d' ' -f1 | sed -e's/:$//g' | grep -v '[0-9]$' | xargs tail -f"

# SHA1
alias sha1='openssl sha1'

# When you want to paste clipboard content into an application that doesn't support the standard paste command
alias clickpaste='sleep 3; xdotool type "$(xclip -o -selection clipboard)"'

# KITTY - alias to be able to use kitty features when connecting to remote servers(e.g use tmux on remote server)
alias kssh="kitty +kitten ssh"

#######################################################
# FUNCTIONS
#######################################################
# Checks if a command exists in the system
command_exists() {
    command -v $1 >/dev/null 2>&1
}

# Extracts any archive(s) (if unp isn't installed)
extract() {
	for archive in "$@"; do
		if [ -f "$archive" ]; then
			case $archive in
			*.tar.bz2) tar xvjf $archive ;;
			*.tar.gz) tar xvzf $archive ;;
			*.bz2) bunzip2 $archive ;;
			*.rar) rar x $archive ;;
			*.gz) gunzip $archive ;;
			*.tar) tar xvf $archive ;;
			*.tbz2) tar xvjf $archive ;;
			*.tgz) tar xvzf $archive ;;
			*.zip) unzip $archive ;;
			*.Z) uncompress $archive ;;
			*.7z) 7z x $archive ;;
			*) echo "don't know how to extract '$archive'..." ;;
			esac
		else
			echo "'$archive' is not a valid file!"
		fi
	done
}

# Searches for text in all files in the current folder
ftext () {
	# -i case-insensitivem, -I ignore binary files, -H causes filename to be printed, -r recursive search, -n causes line number to be printed
	# optional: -F treat search term as a literal, not a regular expression
	# optional: -l only print filenames and not the matching lines ex. grep -irl "$1" *
	grep -iIHrn --color=always "$1" . | less -r
}

# Copy file with a progress bar
cpp () {
	set -e
	strace -q -ewrite cp -- "${1}" "${2}" 2>&1 \
	| awk '{
	count += $NF
	if (count % 10 == 0) {
		percent = count / total_size * 100
		printf "%3d%% [", percent
		for (i=0;i<=percent;i++)
			printf "="
			printf ">"
			for (i=percent;i<100;i++)
				printf " "
				printf "]\r"
			}
		}
	END { print "" }' total_size="$(stat -c '%s' "${1}")" count=0
}

# Copy and go to the directory
cpg () {
	if [ -d "$2" ];then
		cp "$1" "$2" && cd "$2"
	else
		cp "$1" "$2"
	fi
}

# Move and go to the directory
mvg () {
	if [ -d "$2" ];then
		mv "$1" "$2" && cd "$2"
	else
		mv "$1" "$2"
	fi
}

# Create and go to the directory
mkdirg () {
	mkdir -p "$1"
	cd "$1"
}

# Alias cd to zoxide and automatically do ls
cd () {
        if [ -n "$1" ]; then
                z "$@" && command ls -Fh --color=always
        else
                z ~ && command ls -Fh --color=always
        fi
}

# Show the current distribution
distribution () {
	local dtype="unknown"

	if [ -r /etc/os-release ]; then
		source /etc/os-release
		case $ID in
			fedora|rhel|centos)
				dtype="redhat"
				;;
			sles|opensuse*)
				dtype="suse"
				;;
			ubuntu|debian)
				dtype="debian"
				;;
			gentoo)
				dtype="gentoo"
				;;
			arch)
				dtype="arch"
				;;
			slackware)
				dtype="slackware"
				;;
			*)
				;;
		esac
	fi

	echo $dtype
}

# Show the current version of the operating system
ver() {
	local dtype
	dtype=$(distribution)

	case $dtype in
		"redhat")
			if [ -s /etc/redhat-release ]; then
				cat /etc/redhat-release
			else
				cat /etc/issue
			fi
			uname -a
			;;
		"suse")
			cat /etc/SuSE-release
			;;
		"debian")
			lsb_release -a
			;;
		"gentoo")
			cat /etc/gentoo-release
			;;
		"arch")
			cat /etc/os-release
			;;
		"slackware")
			cat /etc/slackware-version
			;;
		*)
			if [ -s /etc/issue ]; then
				cat /etc/issue
			else
				echo "Error: Unknown distribution"
				exit 1
			fi
			;;
	esac
}

# Install the needed support files for this .bashrc file
install_bashrc_support() {
    DEPENDENCIES='multitail tree zoxide trash-cli fzf'
    PYTHONSTUFF='python3-dev python3-pip python3-setuptools' # Required for tldr/thefuck

    # Make sure these directories exist or some packages may not function/install correctly
    mkdir -p ~/.local/share
    mkdir -p ~/.config

    local dtype
    dtype=$(distribution)

    case $dtype in
        "redhat")
            sudo yum check-update
            sudo yum install -y ${DEPENDENCIES} ${PYTHONSTUFF} fastfetch
            ;;
        "suse")
            sudo zypper refresh
            sudo zypper install -y ${DEPENDENCIES} ${PYTHONSTUFF} fastfetch
            ;;
        "debian")
            sudo apt update -yq
            sudo apt install -yq ${DEPENDENCIES} ${PYTHONSTUFF}

            # Download the latest fastfetch deb file and install
            FASTFETCH_URL=$(curl -s https://api.github.com/repos/fastfetch-cli/fastfetch/releases/latest | grep "browser_download_url.*linux-amd64.deb" | cut -d '"' -f 4)
            curl -sL $FASTFETCH_URL -o /tmp/fastfetch_latest_amd64.deb
            sudo apt-get install -yq /tmp/fastfetch_latest_amd64.deb
            ;;
        "arch")
            sudo pacman -Syu
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
                return 1
            fi
            ${AUR_HELPER} --noconfirm -S ${DEPENDENCIES} ${PYTHONSTUFF} fastfetch
            ;;
        "slackware")
            echo "No install support for Slackware"
            ;;
        *)
            echo "Unknown distribution"
            ;;
    esac

    # Update tldr pages
    y | tldr -u

	# Install Starship prompt if not already installed
    if ! command_exists starship; then
        echo "Installing Starship..."
        if ! curl -sS https://starship.rs/install.sh | sh; then
            echo -e "${RED}Something went wrong during Starship install!${RC}"
            exit 1
        fi

        # Add nerd fonts for compatibility with Starship icons only if supported by terminal
        if [[ "$TERM" =~ "256color" ]]; then
            mkdir -p ~/.local/share/fonts

            # Add the FiraCode Nerd Font to the fonts directory
            wget -O ~/.local/share/fonts/FiraCode.zip https://github.com/ryanoasis/nerd-fonts/releases/download/v2.3.3/FiraCode.zip
            unzip ~/.local/share/fonts/FiraCode.zip -d ~/.local/share/fonts
            rm ~/.local/share/fonts/FiraCode.zip

            fc-cache -fv
        fi
    else
        echo "Starship is already installed"
    fi

    # Install Zoxide if not already installed
    if ! command_exists zoxide; then
        echo "Installing Zoxide..."
        if ! curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh; then
            echo -e "${RED}Something went wrong during Zoxide install!${RC}"
            exit 1
        fi
    else
        echo "Zoxide is already installed"
    fi

    # Install ble.sh if not already installed
    if ! command_exists ble; then
        echo "Installing ble.sh..."
        git clone --recursive --depth 1 --shallow-submodules https://github.com/akinomyoga/ble.sh.git /tmp/ble.sh
        if command_exists make; then
            make -C /tmp/ble.sh install PREFIX=~/.local
        else
            gmake -C /tmp/ble.sh install PREFIX=~/.local
        fi
        rm -rf /tmp/ble.sh
    else
        echo "ble.sh is already installed"
    fi
}

# Private and public IP address lookup
alias whatismyip="whatsmyip"
function whatsmyip () {
	if [ -e /sbin/ip ]; then
		echo -n "Internal IP: "
		/sbin/ip addr show wlan0 | grep "inet " | awk -F: '{print $1}' | awk '{print $2}'
	else
		echo -n "Internal IP: "
		/sbin/ifconfig wlan0 | grep "inet " | awk -F: '{print $1} |' | awk '{print $2}'
	fi

	echo -n "External IP: "
	curl -s ifconfig.me
}

# View Apache logs
apachelog() {
	if [ -f /etc/httpd/conf/httpd.conf ]; then
		cd /var/log/httpd && ls -xAh && multitail --no-repeat -c -s 2 /var/log/httpd/*_log
	else
		cd /var/log/apache2 && ls -xAh && multitail --no-repeat -c -s 2 /var/log/apache2/*.log
	fi
}

# Edit the Apache configuration file
apacheconfig() {
	if [ -f /etc/httpd/conf/httpd.conf ]; then
		sudo nano /etc/httpd/conf/httpd.conf
	elif [ -f /etc/apache2/apache2.conf ]; then
		sudo nano /etc/apache2/apache2.conf
	else
		echo "Error: Apache config file could not be found."
		echo "Searching for possible locations:"
		sudo updatedb && locate httpd.conf && locate apache2.conf
	fi
}

# Edit the PHP configuration file
phpconfig() {
	if [ -f /etc/php.ini ]; then
		sudo nano /etc/php.ini
	elif [ -f /etc/php/php.ini ]; then
		sudo nano /etc/php/php.ini
	elif [ -f /etc/php5/php.ini ]; then
		sudo nano /etc/php5/php.ini
	elif [ -f /usr/bin/php5/bin/php.ini ]; then
		sudo nano /usr/bin/php5/bin/php.ini
	elif [ -f /etc/php5/apache2/php.ini ]; then
		sudo nano /etc/php5/apache2/php.ini
	else
		echo "Error: php.ini file could not be found."
		echo "Searching for possible locations:"
		sudo updatedb && locate php.ini
	fi
}

# Edit the MySQL configuration file
mysqlconfig() {
	if [ -f /etc/my.cnf ]; then
		sudo nano /etc/my.cnf
	elif [ -f /etc/mysql/my.cnf ]; then
		sudo nano /etc/mysql/my.cnf
	elif [ -f /usr/local/etc/my.cnf ]; then
		sudo nano /usr/local/etc/my.cnf
	elif [ -f /usr/bin/mysql/my.cnf ]; then
		sudo nano /usr/bin/mysql/my.cnf
	elif [ -f ~/my.cnf ]; then
		sudo nano ~/my.cnf
	elif [ -f ~/.my.cnf ]; then
		sudo nano ~/.my.cnf
	else
		echo "Error: my.cnf file could not be found."
		echo "Searching for possible locations:"
		sudo updatedb && locate my.cnf
	fi
}

# Trim leading and trailing spaces
trim () {
	local var=$*
	var="${var#"${var%%[![:space:]]*}"}"
	var="${var%"${var##*[![:space:]]}"}"
	echo -n "$var"
}

# Easy GitHub commits
gcom() {
	git add .
	git commit -m "$1"
}

lazyg() {
	git add .
	git commit -m "$1"
	git push
}

#######################################################
# INITIALIZATION
#######################################################
# Start zoxide interactive search (fzf) with 'Ctrl + f'
bind '"\C-f":"zi\n"'

# Modifies the PATH environment variable to include additional directories where executable binaries are located
export PATH=$PATH:"$HOME/.local/bin:$HOME/.cargo/bin:/var/lib/flatpak/exports/bin:/.local/share/flatpak/exports/bin"

# Use that sweet auto-complete and suggestions
source ~/.local/share/blesh/ble.sh

# Skips starship initilization if the session is a remote connection (avoids basic terminal connections looking scuffed)
if [[ -z "$SSH_CONNECTION" && -z "$TELNET_CONNECTION" && -z "$RDP_CONNECTION" && -z "$SERIAL_CONSOLE_CONNECTION" && -z "$CONTAINER_SHELL_CONNECTION" ]]; then
    eval "$(starship init bash)"
fi
eval "$(thefuck --alias)"
eval "$(zoxide init bash)"
