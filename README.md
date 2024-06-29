# Custom Shell for Linux
## Description
Customized bash functionality and appearance.

2 line format:
```sh
username@host | ip | dir |
git | py venv | languages | docker >
```

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
#### Windows
Not currently supported - maybe in the future.

#### Linux
1. Clone the repository:
    ```sh
    git clone https://github.com/LukeWait/custom-shell.git
    cd custom-shell
    ```

2. Make executable and run the setup script:
    ```sh
    chmod -x setup.sh
    ./setup.sh
    ```
    
3. Accept the starship installation and then restart terminal or run:
   ```sh
   source ~/.bashrc # or ~/.zshrc depending on which shell your using
   ```

4. Change the default font for your terminal to a Nerd Font. The FiraCode Nerd Font has been installed as part of setup.sh at:
   ```sh
   ~/.local/share/fonts/FiraCode
   ```
   Note: Basic terminals/cli environments will not support Nerd Fonts and as such, won't be installed by setup.sh.
   Install more Nerd Fonts by visiting [https://www.nerdfonts.com/] and extracting the download into the above directory.

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
- How to customize starship: (https://starship.rs/guide/)
- Modifying setup.sh
- Modifying bashrc/zshrc

## Testing
This setup has been tested and is fully functional in the following environments:
- **Advanced Terminal:**
  - Kali 2024 using bash

- **Basic Terminal/CLI Environment:**
  - Ubuntu 22.04 using bash

### Work in progress:
- Add dependencies in setup.sh for non debian and test
- Create .zshrc file based on .bashrc
- Add some additional palettes and customizable options to starship.toml

## License
This project is licensed under the MIT License. See the LICENSE file for details.

## Acknowledgments
Modified verison of christitustech's mybash: https://github.com/ChrisTitusTech/mybash

Sourced alias's and scripts by zachbrowne.me

## Source Code
The source code for this project can be found in the GitHub repository: [https://github.com/LukeWait/custom-shell](https://www.github.com/LukeWait/custom-shell).

## Dependencies
- Linux operating system
- Bash or Zsh shell
