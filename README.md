## General info

Set of personal setup scripts and dotfiles, to get me up and running quickly when I inevitably break something.

## Requirements

Written and tested for:

-   Manjaro 18.1.0
-   GNOME 3.32.2
-   Bash 5.0.9

Some scripts may work even on other distributions, GNOME setup was originally written for Ubuntu 18.04 with GNOME 3.28 and later modified for Manjaro with newer version of GNOME. Compatibility may vary from script to script.

## Preview

<img src="https://imgur.com/Fh2m7Zf.png"/>

## Warning :warning:

This scripts are highly opinionated and aren't meant to be universaly liked! If you want to give these a try, you should first fork this repository, review the code, and remove things you don’t want or need. Use at your own risk!

## Installation

To install dotfiles and run setup scripts clone the repository and execute `bootstrap.sh` script. Each script can be run multiple times when something fails along the way, nothing should break or be written multiple times.

```
$ git clone https://github.com/vangyyy/linux-setup.git
$ cd linux-setup
$ ./bootstrap.sh
```

## Usage

Main script `bootstrap.sh` supports 2 modes. By default it installs basic configuration. If executed with flag `-l` or `--laptop` it adds additional script with laptop specific packages and other configs.

```
$ ./bootstrap.sh --help
Usage: ./bootstrap.sh [--laptop]

Options:
  -l --laptop       Also executes setup script for 1st Generation Lenovo X1 Yoga
  -h --help         Display this help and exit
```

## Acknowledgements

[@NicolasBernaerts](https://github.com/NicolasBernaerts) (Nicolas Bernaerts)
[https://github.com/NicolasBernaerts/ubuntu-scripts](https://github.com/NicolasBernaerts/ubuntu-scripts)

[@mathiasbynens](https://github.com/mathiasbynens) (Mathias Bynens)
[https://github.com/mathiasbynens/dotfiles](https://github.com/mathiasbynens/dotfiles)

[@necolas](https://github.com/necolas) (Nicolas Gallagher)
[https://github.com/necolas/dotfiles](https://github.com/necolas/dotfiles)

[@tomnomnom](https://github.com/tomnomnom) (Tom Hudson)
[https://github.com/tomnomnom/dotfiles](https://github.com/tomnomnom/dotfiles)
