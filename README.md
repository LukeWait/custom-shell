# Custom Shell for Linux
## Description
Enhances Linux environments with the Starship customizable prompt, personalized aliases for lazy people, and essential packages. The packages chosen have been selected to enhance navigation and provide a user-friendly experience that, for the most part, are integrated seamlessly into everyday use through the use of alias and functions. Details on the packages are outlined in the [Usage](#usage) section.

The default configuration features a two-line prompt format as follows:
   ```sh
   username@host | ip | dir |
   git | py venv | languages | docker >
   ```
Note: There are several alternative presets included which will drastically alter the prompt appearance. Manually editing the file is also quite simple, so customize it with what works for you.

### Example Starship Prompt Appearance
<p align="center">
  <img src="https://github.com/LukeWait/custom-shell/raw/main/screenshots/starship-home.png" alt="App Screenshot" width="700">
</p>

<p align="center">
  <img src="https://github.com/LukeWait/custom-shell/raw/main/screenshots/starship-git-venv.png" alt="App Screenshot" width="700">
</p>

### Example Starship Prompt Appearance for Basic Terminal (CLI environment)
<p align="center">
  <img src="https://github.com/LukeWait/custom-shell/raw/main/screenshots/starship-cli-home.png" alt="App Screenshot" width="700">
</p>

<p align="center">
  <img src="https://github.com/LukeWait/custom-shell/raw/main/screenshots/starship-cli-git-venv.png" alt="App Screenshot" width="700">
</p>

## Table of Contents
- [Installation](#installation)
- [Usage](#usage)
- [Development](#development)
- [Testing](#testing)
- [License](#license)
- [Acknowledgments](#acknowledgments)
- [Source Code](#source-code)
- [Dependencies](#dependencies)

## Installation
### Linux
1. Clone the repository:
    ```sh
    git clone https://github.com/LukeWait/custom-shell.git
    cd custom-shell
    ```

2. Make executable if necessary and run the setup script:
    ```sh
    chmod -x setup.sh
    ./setup.sh
    ``` 

3. The script will automatically proceed with installations until it gets to Starship. Accept the Starship installation query and then restart terminal or run:
   ```sh
   source ~/.bashrc # or ~/.zshrc depending on which shell your using
   ```

4. Change the default font for your terminal to a Nerd Font by checking the available settings. The FiraCode Nerd Font has been installed as part of setup.sh at:
   ```sh
   ~/.local/share/fonts/FiraCode
   ```
   Note: Basic terminals/cli environments will not support Nerd Fonts and as such, won't be installed by setup.sh.
   Install more Nerd Fonts by visiting https://www.nerdfonts.com/ and extracting the download into the above directory.
 
### Windows
The `setup.sh` file will not work with Windows however you can take advantage of the Starship custom prompt styles.
1. Install Starship with winget (https://learn.microsoft.com/en-us/windows/package-manager/winget/):
   ```sh
   winget install --id Starship.Starship
   ```

2. Create a starship.toml file somewhere (clone the repo and choose a preset).

3. Install a Nerd Font by visiting https://www.nerdfonts.com/ and adding the extracted download files to Control Panel\Fonts.

4. Install Clink which includes auto completion and other features present in Linux distros (required to utilize Starship with Command Prompt). More information at: https://chrisant996.github.io/clink/clink.html
   ```sh
   winget install clink
   ```

5. Create configuration files for Command Prompt and PowerShell to initialize Starship and provide path to starship.toml file:
   - Command Prompt - Create file at %LocalAppData%\clink\starship.lua with properties:
   ```lua
   load(io.popen('starship init cmd'):read("*a"))()
   os.setenv('STARSHIP_CONFIG', 'C:\\<path\\to>\\starship.toml')
   ```
   - Powershell - Add the following to PowerShell Configuration (use $PROFILE to find and create if it doesn't exist): 
   ```ps1
   Invoke-Expression (&starship init powershell)
   $ENV:STARSHIP_CONFIG = "$HOME\<path\to>\starship.toml"
   ```

6. Lastly, configure the Command Prompt and PowerShell windows to use a Nerd Font:
   - Right click on taskbar of Command Prompt and choose Settings\Profile\Command Prompt/PowerShell. Scroll to the bottom and click Appearance and then change the font face to a Nerd Font.
   - Admin versions of need to be addressed individually, open an admin Command Prompt/PowerShell and right click on taskbar and choose Properties\Font and then choose a Nerd Font.

## Usage
Describe alias's and functions/how to utilize.

Basic description of packages:
- starship/modifying .toml
- zoxide and navigation (aliased to ls and key binding for 'ctrl + f' for searching)
- fzf (utilized by zoxide): A command-line fuzzy finder.
- multitail: An advanced tail program for monitoring log files
- tldr: Simplified and community-driven man pages
- trash-cli: Command-line interface to the freedesktop.org trash can
- btop: An advanced resource monitor
- bat: A cat clone with syntax highlighting and Git integration
- thefuck: A tool that corrects your previous console command
- fastfetch: A tool to display system information in a fast and minimal way

## Development
- Documentation on modifying the Starship configuration file `starship.toml` and the modules available to use can be found [here](https://starship.rs/config/).
- Modifying `setup.sh` to include extra packages.
- Modifying `.bashrc`/`.zshrc` with aliases and functions.

## Testing
This setup has been tested and is fully functional in the following environments:
- **Advanced Terminal:**
   - Kali 2024 using bash

- **Basic Terminal/CLI Environment:**
   - Ubuntu 22.04 using bash

### Work in progress:
- Add dependencies in setup.sh for non debian and test
- Create .zshrc file based on .bashrc

## License
This project is licensed under the MIT License. See the LICENSE file for details.

## Acknowledgments
Modified verison of christitustech's mybash: https://github.com/ChrisTitusTech/mybash

Sourced alias's and scripts by zachbrowne.me: https://gist.github.com/zachbrowne/8bc414c9f30192067831fafebd14255c

## Source Code
The source code for this project can be found in the GitHub repository: [https://github.com/LukeWait/custom-shell](https://www.github.com/LukeWait/custom-shell).

## Dependencies
- Linux operating system
- Bash or Zsh shell
