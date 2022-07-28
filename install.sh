#!/bin/bash

# -------------------------------------------
# get current directory
# -------------------------------------------

export DOTFILES_DIR
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

#---------------------------------------*
# Switches - edit these to install or not with [0, 1]
#---------------------------------------*

# Mandatory switches (don't touch these without careful consideration)
back_up=1
symlinks=1
xcode=1
homebrew=1
zsh=1
tools=1
apps=1

# Optional switches
ios=0
android=0

# An example switch for your new stuff
extras=1

#--------------------------------------------
# MANDATORY SWITCHES
#--------------------------------------------
if [ $back_up == 1 ]; then
	echo "-------------------------------------------"
	echo " BACKUP DOTFILES"
	echo "-------------------------------------------"
	echo "Backing up your system's dotfiles..."
	BACKUP_DIR="$HOME/backup_old_dotfiles"
	mkdir $BACKUP_DIR
	mv "~/.bashrc" $BACKUP_DIR
	mv "~/.bash_profile" $BACKUP_DIR
fi

if [ $symlinks == 1 ] ; then
	echo "-------------------------------------------"
	echo " SYMLINKS"
	echo "-------------------------------------------"
	echo 'creating symlinks'
	ln -sf "$DOTFILES_DIR/git/.gitconfig" ~
	ln -sf "$DOTFILES_DIR/git/.gitignore_global" ~
	ln -sf "$DOTFILES_DIR/zsh/.zshrc" ~
	ln -sf "$DOTFILES_DIR/zsh/.zsh_exports" ~
	ln -sf "$DOTFILES_DIR/zsh/.zsh_aliases" ~
	ln -sf "$DOTFILES_DIR/bash/.bash_profile" ~
	ln -sf "$DOTFILES_DIR/bash/.bashrc" ~
	ln -sf "$DOTFILES_DIR/vim/.vimrc" ~
fi

if [ $xcode == 1 ] ; then
	echo "-------------------------------------------"
	echo " INSTALL XCODE"
	echo "-------------------------------------------"
	sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer
	sudo xcodebuild -license
fi

if [ $homebrew == 1 ] ; then
	echo "-------------------------------------------"
	echo ' INSTALL HOMEBREW and dependencies'
	echo "-------------------------------------------"
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

	brew update

	echo '----- add to PATH -----'
	echo 'export PATH="/usr/local/bin:$PATH"' >> ~/.bash_profile

fi


if [ $tools == 1 ] ; then
	figlet -c DevTools

	echo "-------------------------------------------"
	echo "Installing git..."
	echo "-------------------------------------------"
	brew install git

	echo "-------------------------------------------"
	echo "Installing figlet..."
	echo "-------------------------------------------"
	brew install figlet

	echo "-------------------------------------------"
	echo "Copying help script..."
	echo "-------------------------------------------"
	cp . "$DOTFILES_DIR/help/help.sh" $HOME

	echo "-------------------------------------------"
	echo "Installing htop..."
	echo "-------------------------------------------"
	brew install htop

	echo "-------------------------------------------"
	echo "Installing wget..."
	echo "-------------------------------------------"
	brew install wget

	echo "-------------------------------------------"
	echo "Installing vim..."
	echo "-------------------------------------------"
	git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
	vim +PluginInstall +qall

	echo "-------------------------------------------"
	echo "Installing nmap..."
	echo "-------------------------------------------"
	brew install nmap

	echo "-------------------------------------------"
	echo "Installing npm..."
	echo "-------------------------------------------"
	brew install node -y
	brew install npm -y
	npm install npm@latest -gy
	curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh | bash
	echo "---------------------------*"
	echo 'confirming nvm is installed'
	nvm -v
fi

# For the full list of available apps supported by Homebrew
# https://formulae.brew.sh/cask/
if [ $apps == 1 ] ; then
	figlet -c Apps

	echo "-------------------------------------------"
	echo "Installing firefox..."
	echo "-------------------------------------------"
	brew install --cask firefox

	echo "-------------------------------------------"
	echo "Installing slack..."
	echo "-------------------------------------------"
	brew install --cask slack

	echo "-------------------------------------------"
	echo "Installing atom..."
	echo "-------------------------------------------"
	brew install --cask atom

	echo "-------------------------------------------"
	echo "Installing zoom..."
	echo "-------------------------------------------"
	brew install --cask zoom
fi

#--------------------------------------------
# OPTIONAL SWITCHES
#--------------------------------------------
if [ $ios == 1 ] ; then
    figlet -c iOS

    brew install --HEAD usbmuxd
    brew link usbmuxd
    brew install --HEAD libimobiledevice
    brew install ideviceinstaller
    brew install ios-deploy
    brew install cocoapods
    pod setup
fi

if [ $android == 1 ] ; then
	figlet -c android

	brew install --cask android-studio
	#curl -O "https://dl.google.com/dl/android/studio/install/3.3.2.0/android-studio-ide-182.5314842-mac.dmg"
	echo 'install flutter and set path'

	brew install --cask flutter
	#curl -O "https://storage.googleapis.com/flutter_infra/releases/stable/macos/flutter_macos_v1.2.1-stable.zip"
	#unzip ~/flutter_macos_v1.2.1-stable.zip

Zce ~/.bash_profile
	echo 'update flutter'
	flutter doctor
fi

#--------------------------------------------
# EXTRAS
# this serves as an example and as a convenience
# for adding additional installation cmds
#--------------------------------------------
if [ $extras == 1 ] ; then
	figlet -c extras

	# ADD MORE COMMANDS HERE

fi

#--------------------------------------------
# Probably not necessary, but doesn't hurt to try
#--------------------------------------------
figlet -c DepsCheck
echo '----- Update deps with brew -----'
brew update
echo '----- Showing all outdated deps with brew -----'
brew outdated
echo '----- Upgrading all deps with brew -----'
brew upgrade
echo '----- Checking system for potential problems with brew -----'
brew doctor

#--------------------------------------------
# WARNING: DO NOT ADD ANYTHING AFTER HERE
# due to the nature of oh-my-zsh installation script,
# it is best to let the oh-my-zsh script run last
#--------------------------------------------
if [ $zsh == 1 ] ; then
	figlet -c zsh
	brew install zsh zsh-completions
	echo "Setting zsh as default shell"
	chsh -s /bin/zsh
	echo "Installing oh-my-zsh"

	sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

	# spaceship-prompt (theme)
	git clone https://github.com/denysdovhan/spaceship-prompt.git "$HOME/.oh-my-zsh/themes/spaceship-prompt"

	# powerline fonts
	brew install fonts-powerline

	# create symlink
	ln -s "$HOME/.oh-my-zsh/themes/spaceship-prompt/spaceship.zsh-theme" "$HOME/.oh-my-zsh/themes/spaceship-prompt/spaceship.zsh-theme"

	source ~/.zshrc
fi

figlet -c Owari
