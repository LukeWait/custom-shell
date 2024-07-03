# Custom Shell for Linux
## Description
Enhances Linux environments with the Starship customizable prompt for visual fanciness, personalized aliases for lazy people, and essential packages. The packages have been selected to enhance navigation and provide a user-friendly experience that, for the most part, seamlessly integrates into everyday use through the use of alias and functions. Further details on the packages and their functionality can be found in the [Usage](#usage) section.

Installing is easy - the `setup.sh` file takes care of everything, including installing the dependencies and creating symbolic links to the included shell/Starship config files. The script will automatically detect the following and act accordingly: 
- The Linux distribution in use is used to install dependencies based on the required syntax and package managers (as of v2.0.0, only apt has been tested)
- The shell type in use will determine which shell config file to link (currently only .bashrc is provided however .zshrc is in the works).
- If you're using a basic terminal with limited color range/font choices it will link to an alternative Starship config that is tailored to these restrictions. It will also skip installation of a Nerd Font as it won't be supported.

The default Starship config features a two-line prompt format as follows:
   ```sh
   username@host | ip | dir |
   git | py venv | languages | docker >
   ```
Note: There are several alternative presets included which will drastically alter the prompt appearance. Manually editing the file is also quite simple, so customize it with what works for you. Details on modifying any of the config files can be found in the [Development](#development) section.

### Example Starship Prompt Appearance
<p align="left">
  <img src="https://github.com/LukeWait/custom-shell/raw/main/screenshots/starship-home.png" alt="App Screenshot" width="700">
</p>

<p align="left">
  <img src="https://github.com/LukeWait/custom-shell/raw/main/screenshots/starship-git-venv.png" alt="App Screenshot" width="700">
</p>

### Example Starship Prompt Appearance for Basic Terminal (CLI environment)
<p align="left">
  <img src="https://github.com/LukeWait/custom-shell/raw/main/screenshots/starship-cli-home.png" alt="App Screenshot" width="700">
</p>

<p align="left">
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

3. The script will automatically proceed with installations until it gets to Starship. Accept the Starship installation query and upon completion you'll be prompted to restart the terminal to see the changes. You can restart the config file without leaving the terminal with the following command:
   ```sh
   source ~/.bashrc
   ```

4. Change the default font for your terminal to a Nerd Font by checking the available settings. The FiraCode Nerd Font has been installed as part of the setup script at:
   ```sh
   ~/.local/share/fonts/FiraCode
   ```
   Note: Basic terminals/CLI environments will not support Nerd Fonts. If the environment running `setup.sh` is a basic terminal, the Nerd Font won't be installed. Install more Nerd Fonts by visiting https://www.nerdfonts.com/ and extracting the download into the above directory.
 
### Windows
The `setup.sh` file will not work with Windows however you can take advantage of the Starship custom prompt styles.
1. Install Starship with winget package manager (details on winget and how to install: https://learn.microsoft.com/en-us/windows/package-manager/winget/):
   ```sh
   winget install --id Starship.Starship
   ```

2. Create a `starship.toml` file somewhere (clone the repo and choose a preset).

3. Install a Nerd Font by visiting https://www.nerdfonts.com/ and adding the extracted download files to Control Panel\Fonts.

4. Install Clink to utilize Starship with Command Prompt. This package includes auto completion and other features present in Linux distros (details on clink and features: https://chrisant996.github.io/clink/clink.html):
   ```sh
   winget install clink
   ```

5. Create config files for Command Prompt and PowerShell to initialize Starship and provide path to `starship.toml` file:
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
### Included Packages
<details>
  <summary style="font-weight: bold;">starship</summary>
  The minimal, blazing-fast, and infinitely customizable prompt for any shell!

  https://github.com/starship/starship
  <p align="left">
    <img src="https://raw.githubusercontent.com/starship/starship/master/media/demo.gif" alt="Starship Video" width="600">
  </p>
</details>


<details>
  <summary style="font-weight: bold;">zoxide</summary>
  zoxide is a smarter cd command, inspired by z and autojump.

  It remembers which directories you use most frequently, so you can "jump" to them in just a few keystrokes.

  https://github.com/ajeetdsouza/zoxide
  <p align="left">
    <img src="https://github.com/ajeetdsouza/zoxide/blob/main/contrib/tutorial.webp" alt="zoxide Video" width="600">
  </p>
</details>


<details>
  <summary style="font-weight: bold;">fzf</summary>
  fzf is a general-purpose command-line fuzzy finder.
  
  It's an interactive filter program for any kind of list; files, command history, processes, hostnames, bookmarks, git commits, etc. It implements a "fuzzy" matching algorithm, so you can quickly type in patterns with omitted characters and still get the results you want.

  https://github.com/junegunn/fzf
  <p align="left">
    <img src="https://raw.githubusercontent.com/junegunn/i/master/fzf-preview.png" alt="fzf Screeenshot" width="800">
  </p>
</details>


<details>
  <summary style="font-weight: bold;">tldr</summary>
  The tldr-pages project is a collection of community-maintained help pages for command-line tools, that aims to be a simpler, more approachable complement to traditional man pages.

  https://github.com/tldr-pages/tldr
  <p align="left">
    <img src="https://github.com/tldr-pages/tldr/raw/main/images/tldr-dark.png" alt="tldr Screeenshot" width="800">
  </p>
</details>


<details>
  <summary style="font-weight: bold;">btop</summary>
  Resource monitor that shows usage and stats for processor, memory, disks, network and processes.

  C++ version and continuation of bashtop and bpytop.

  https://github.com/aristocratos/btop
  <p align="left">
    <img src="https://github.com/aristocratos/btop/raw/main/Img/normal.png" alt="btop Screeenshot" width="800">
  </p>
</details>


<details>
  <summary style="font-weight: bold;">bat</summary>
  A cat clone with syntax highlighting and Git integration 

  https://github.com/sharkdp/bat
  <p align="left">
    <img src="https://camo.githubusercontent.com/be35879c510cea3111901d01e4af4d7e8f38fbb7c56a49ca711f07edf1b2d6fd/68747470733a2f2f696d6775722e636f6d2f724773646e44652e706e67" alt="bat Screeenshot" width="600">
  </p>
</details>


<details>
  <summary style="font-weight: bold;">thefuck</summary>
  A tool that corrects errors in your previous console command.

  https://github.com/nvbn/thefuck
  <p align="left">
    <img src="https://raw.githubusercontent.com/nvbn/thefuck/master/example.gif" alt="thefuck Video" width="600">
  </p>
</details>


<details>
  <summary style="font-weight: bold;">fastfetch</summary>
  Fastfetch is a neofetch-like tool for fetching system information and displaying it prettily. It is written mainly in C, with performance and customizability in mind.

  https://github.com/fastfetch-cli/fastfetch
  <p align="left">
    <img src="https://private-user-images.githubusercontent.com/6134068/269350182-4f72d5bb-4e85-458c-9d60-20af01346728.png?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3MTk5ODEzNzIsIm5iZiI6MTcxOTk4MTA3MiwicGF0aCI6Ii82MTM0MDY4LzI2OTM1MDE4Mi00ZjcyZDViYi00ZTg1LTQ1OGMtOWQ2MC0yMGFmMDEzNDY3MjgucG5nP1gtQW16LUFsZ29yaXRobT1BV1M0LUhNQUMtU0hBMjU2JlgtQW16LUNyZWRlbnRpYWw9QUtJQVZDT0RZTFNBNTNQUUs0WkElMkYyMDI0MDcwMyUyRnVzLWVhc3QtMSUyRnMzJTJGYXdzNF9yZXF1ZXN0JlgtQW16LURhdGU9MjAyNDA3MDNUMDQzMTEyWiZYLUFtei1FeHBpcmVzPTMwMCZYLUFtei1TaWduYXR1cmU9NjRjZTYzMTk0YzliYjY4ODUzZWI0M2QzYjY5N2M2ZWE2NTU0MGEyZmNhMGNhOTgxNDAwYWViNTBmYzE1MTZhZCZYLUFtei1TaWduZWRIZWFkZXJzPWhvc3QmYWN0b3JfaWQ9MCZrZXlfaWQ9MCZyZXBvX2lkPTAifQ.vyOm9bEVDKePmVfdMOBvDp_ROs9DkggPsQ9jTUbw7LA" alt="fastfetch Screeenshot" width="600">
  </p>
</details>


<details>
  <summary style="font-weight: bold;">multitail</summary>
  MultiTail allows you to monitor logfiles and command output in multiple windows in a terminal, colorize, filter and merge.

  https://github.com/folkertvanheusden/multitail/?tab=readme-ov-file
  <p align="left">
    <img src="https://www.tecmint.com/wp-content/uploads/2014/03/View-Files-in-3-Columns-620x405.jpeg" alt="multitail Screeenshot" width="800">
  </p>
</details>


<details>
  <summary style="font-weight: bold;">trash-cli</summary>
  trash-cli trashes files recording the original path, deletion date, and permissions. It uses the same trashcan used by KDE, GNOME, and XFCE, but you can invoke it from the command line (and scripts).
</details>


### Overview of Aliases & Functions in `.bashrc`
<details>
  <summary style="font-weight: bold;">Aliases</summary>
  <ul>
    <li>alert - Notify on long-running commands.</li>
    <li>ebrc - Edit .bashrc with nano.</li>
    <li>da - Show current date and time.</li>
    <li>
      Modified commands:
      <ul>
        <li>cp - Copy with confirmation.</li>
        <li>mv - Move with confirmation.</li>
        <li>rm - Move to trash.</li>
        <li>mkdir - Create directory with parents.</li>
        <li>ps - Show process status.</li>
        <li>ping - Ping 10 times.</li>
        <li>less - Show less with color.</li>
        <li>multitail - Multi-tail with no repeat.</li>
        <li>freshclam, apt, apt-get - Run with sudo.</li>
      </ul>
    </li>
    <li>
      Change directory:
      <ul>
        <li>home, cd.., .., ..., ...., ..... - Navigate directories.</li>
        <li>bd - Change to previous directory.</li>
        <li>web - Go to web directory.</li>
      </ul>
    </li>
    <li>rmd - Remove directory recursively and forcefully.</li>
    <li>
      List directories:
      <ul>
        <li>la - List all with details.</li>
        <li>ls - List all with color.</li>
        <li>
          lx, lk, lc, lu, lr, lt, lm, lw, ll, labc, lf, ldir - Various ls options.
        </li>
      </ul>
    </li>
    <li>
      Chmod commands:
      <ul>
        <li>mx, 000, 644, 666, 755, 777 - Change permissions.</li>
      </ul>
    </li>
    <li>
      Search:
      <ul>
        <li>h - Search history.</li>
        <li>p - Search processes.</li>
        <li>topcpu - Show top CPU processes.</li>
        <li>f - Search files.</li>
      </ul>
    </li>
    <li>countfiles - Count files, links, directories.</li>
    <li>openports - List open ports.</li>
    <li>
      Reboot:
      <ul>
        <li>rebootsafe, rebootforce - Safe and forced reboot.</li>
      </ul>
    </li>
    <li>
      Disk space:
      <ul>
        <li>diskspace - Show disk space.</li>
        <li>folders, folderssort - Show folder sizes.</li>
        <li>tree, treed - Show directory tree.</li>
        <li>mountedinfo - Show mounted filesystems.</li>
      </ul>
    </li>
    <li>
      Archives:
      <ul>
        <li>mktar, mkbz2, mkgz - Create tar archives.</li>
        <li>untar, unbz2, ungz - Extract archives.</li>
      </ul>
    </li>
    <li>logs - Show all logs.</li>
    <li>sha1 - Generate SHA1 hash.</li>
    <li>clickpaste - Paste clipboard content.</li>
    <li>kssh - Use Kitty features on remote servers.</li>
  </ul>
</details>


<details>
  <summary style="font-weight: bold;">Functions</summary>
  <ul>
    <li>extract() - Extract various types of archives (tar, gzip, bzip2, etc.) based on file extension.</li>
    <li>ftext() - Searche for text in all files in the current directory recursively, with case insensitivity and line numbering.</li>
    <li>cpp() - Copy files with a progress bar showing the completion percentage.</li>
    <li>cpg() - Copy files and changes directory to the destination if it's a directory.</li>
    <li>mvg() - Move files and changes directory to the destination if it's a directory.</li>
    <li>mkdirg() - Create directories recursively and changes directory to the newly created directory.</li>
    <li>cd() - Change directory using zoxide and lists the contents of the directory automatically.</li>
    <li>distribution() - Display the current Linux distribution.</li>
    <li>ver() - Display the current version of the operating system.</li>
    <li>install_bashrc_support() - Install dependencies and support files for .bashrc based on the Linux distribution.</li>
    <li>whatsmyip() - Display internal and external IP addresses.</li>
    <li>apachelog() - Display Apache logs using multitail.</li>
    <li>apacheconfig() - Edit the Apache configuration file.</li>
    <li>phpconfig() - Edit the PHP configuration file.</li>
    <li>mysqlconfig() - Edit the MySQL configuration file.</li>
    <li>trim() - Trim leading and trailing spaces.</li>
    <li>gcom() - GitHub: Add files, commit with message.</li>
    <li>lazyg() - GitHub: Add files, commit with message, and push.</li>
  </ul>
</details>


## Development
### Modifying `starship.toml`
- Documentation on modifying the Starship config file, as well as the modules which can be included in the prompt, can be found [here](https://starship.rs/config/).

### Modifying `setup.sh`
- To add/remove packages from installation script, locate the `installDepend()` function and add/remove from DEPENDENCIES/PYTHONSTUFF variables. Packages requiring additional steps, such as installing the latest version of fastfetch for apt, can be adjusted directly from the case relevant to each $PACKAGER. 
- If adding an installation by using a downloaded script, and the process is the same for all distros, create a new function using the `installStarship()` function as a functional template. Ensure to add the function call to the end of the script.
- Linking shell and Starship config files occurs in the `linkConfig()` function. If you create addtional shell config files for other shell types you can add them here. You can also change the path for any of the linked files in case you want to store them elsewhere and delete the cloned repo after running the setup.

### Modifying `.bashrc`
- SYSTEM CONFIG: Fastfetch is set to automatically run whenever a new terminal is started - you can remove that functionality here.
- EXPORTS: Here you can set the shell default settings such as preferred text editor. Everything is labelled so modify as you see fit.
- ALIASES/FUNCTIONS: Again, everything is labelled so should be pretty straightforward.
- INITIALIZATION: Here you can add/remove key bindings for keyboard shortcuts. Some packages such as Starship, zoxide, and thefuck require initilization when a shell is launched so ensure the `eval` statements for these packages remain intact unless you plan to remove them. I also disabled Starship on remote connections to avoid basic terminal connections looking like a mess of symbols.

## Testing
Version v2.0.0 has been tested and is fully functional in the following environments:
- **Advanced Terminal:**
   - Kali 2024 using bash

- **Basic Terminal/CLI Environment:**
   - Ubuntu 22.04 using bash

### Work in progress:
- Test non-debian package installation process
- Create .zshrc file based on .bashrc and test

## License
This project is licensed under the MIT License. See the LICENSE file for details.

## Acknowledgments
Modified verison of christitustech's mybash: https://github.com/ChrisTitusTech/mybash

Sourced Aliases and scripts by zachbrowne.me: https://gist.github.com/zachbrowne/8bc414c9f30192067831fafebd14255c

## Source Code
The source code for this project can be found in the GitHub repository: [https://github.com/LukeWait/custom-shell](https://www.github.com/LukeWait/custom-shell).

## Dependencies
- Linux operating system
- Bash
