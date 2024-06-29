# Custom Shell for Linux
## Description
Customized bash functionality and appearance.

2 line format:

username@host | ip | dir |

git | py venv | languages | docker >

### Example Starship Prompt Appearance
<p align="center">
  <img src="https://github.com/LukeWait/custom-shell/raw/main/screenshots/starship-home.png" alt="App Screenshot" width="800">
</p>

<p align="center">
  <img src="https://github.com/LukeWait/custom-shell/raw/main/screenshots/starship-git-venv.png" alt="App Screenshot" width="800">
</p>

### Example Starship Prompt Appearance for Basic Terminal (CLI environment)
<p align="center">
  <img src="https://github.com/LukeWait/custom-shell/raw/main/screenshots/starship-cli-home.png" alt="App Screenshot" width="800">
</p>

<p align="center">
  <img src="https://github.com/LukeWait/custom-shell/raw/main/screenshots/starship-cli-git-venv.png" alt="App Screenshot" width="800">
</p>

## Table of Contents
- [Installation](#installation)
- [Usage](#usage)
- [Development](#development)
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

##### The following step is not supported by basic terminal/cli environments
4. Change the default font for your terminal to a nerd font, FiraCode nerd font has been installed as part of setup.sh:
   ```sh
   ~/.local/share/fonts/FiraCode
   ```
   You can install more by visiting [https://www.nerdfonts.com/] and extracting the downloaded fonts into the above directory.

## Usage
Describe alias's and functions.
Describe packages:
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
Work in progress. Things to do:
### setup.sh
- Add dependencies for non debian and test

### .bashrc
- Include .zshrc file based on .bashrc

### starship.toml
- Add some additional palettes

## License
This project is licensed under the MIT License. See the LICENSE file for details.

## Acknowledgments
Modified verison of christitustech's mybash: https://github.com/ChrisTitusTech/mybash
Sourced alias's and scripts by zachbrowne.me

## Source Code
The source code for this project can be found in the GitHub repository: [https://github.com/LukeWait/custom-shell](https://www.github.com/LukeWait/custom-shell).

## Dependencies
