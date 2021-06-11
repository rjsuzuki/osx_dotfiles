# rjsuzuki's dotfiles

Basic dotfiles setup for osx.

- version 2.0.0

for linux: [go here](https://github.com/rjsuzuki/linux_dotfiles)

---

## 💻 Environment

These dotfiles are opinionated, so please compare the environment settings to yours and modify the files as needed.

## ⚠️ IMPORTANT

1. Go to git folder and modify `.gitconfig` with your own information.
2. Review the `.vimrc` file and edit as needed to fit your preferences.
3. Only source from `install.sh` unless you know what you're doing.
4. Edit the 'binary switches' inside the `install.sh` file to turn ON/OFF the installation of a specific module. accepted values are `0` and `1`. Some switches are important for the script to run properly so handle with care. You can add more customization in the `extras` section of the `install.sh` file for convenience, or simply modify any file as needed!
5. After installation, you can run the cmd `help` in the terminal to print out a list of the custom aliases that were configured. If you add additional aliases and/or exports, you can update the `help.sh` for your own reference.
6. I really gave up on the `bash` related files because I like `zsh` so much more. So use bash at your own discretion.
7. Successful updates should print out `owari` in the terminal. It means `done` in 🇯🇵.

## 📦 What's in the box!?

A non-exhaustive list of dependencies that can be installed.

### Dev Tools

1. homebrew
2. git
3. figlet
4. htop
5. wget
6. nmap
7. npm
8. xcode
9. zsh + oh-my-zsh

### Applications

1. chrome
2. slack
3. atom
4. zoom

### Optional Tools

1. android
2. iOS

---

## ℹ️ Installation

Preferably with a new installation of osx.

#### quick installation with git:

1. Run the following cmd:

```bash
cd $HOME
git clone https://github.com/rjsuzuki/osx_dotfiles.git ~/.dotfiles
source ~/.dotfiles/install.sh
```

#### custom installation with git:

1. Run the following cmd:

```bash
cd $HOME
git clone https://github.com/rjsuzuki/osx_dotfiles.git ~/.dotfiles
```

2. Modify files as needed, and then run:

```bash
cd $HOME
sudo source $HOME/.dotfiles/install.sh
```

#### If you need to start over

- make sure to uninstall `oh-my-zsh` and/or delete the `$HOME/.oh-my-zsh` directory before trying again.

---

### Notes:

- macOS sets PATH environment variable to:
  `/usr/local/bin:/usr/bin/:/usr/sbin:/sbin by default`
- home directory ~/bin for commands
- append to existing Path with: `export PATH="\$PATH:~/bin"`
- `.bash_profile` is convention

### Credits

🙏 Cheers to the [dotfile community](https:///dotfiles.github.io).
