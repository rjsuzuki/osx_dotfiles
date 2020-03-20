#!/bin/bash

# -------------------------------------------
# get current directory
# -------------------------------------------

export DOTFILES_DIR
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

#****************************************
# Switches - edit these to install or not
#****************************************

back_up=0
xcode=0
homebrew=0
symlinks=1
vim=0
zsh=0
ios=0
android=0
npm=0

#--------------------------------------------
# copy system's dotfiles and store in backup folder
#--------------------------------------------

if [ $back_up == 1 ]; then
	echo "*********************************"
	echo "* BACKUP DOTFILES"
	echo "*********************************"
	echo "Backing up your system's dotfiles..."
	BACKUP_DIR="$HOME/backup_old_dotfiles"
	mkdir $BACKUP_DIR
	mv "~/.bashrc" $BACKUP_DIR
	mv "~/.bash_profile" $BACKUP_DIR
fi

if [ $symlinks == 1 ] ; then	
	echo "*****************************"
	echo "* SYMLINKS"
	echo "*****************************"
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
	echo "*********************************"
	echo "* INSTALL XCODE"
	echo "*********************************"
	sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer
	sudo xcodebuild -license
fi

if [ $homebrew == 1 ] ; then 
	echo '*********************************'
	echo '*INSTALL HOMEBREW and dependencies'
	echo '*********************************'
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"	
	echo '***** add to PATH *****'
	echo 'export PATH="/usr/local/bin:$PATH"' >> ~/.bash_profile		
	echo '***** update brew *****'	
	brew update
fi

if [ $vim == 1 ] ; then
	echo "*****************************"
	echo "* Installing MAC VIM and Plugins..."
	echo "*****************************"
	git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
	vim +PluginInstall +qall
fi

if [ $zsh == 1 ] ; then 
	echo "*****************************"
	echo "* Installing ZSH"
	echo "*****************************"
	brew install zsh zsh-completions
	echo "Setting zsh as default shell"
	chsh -s /bin/zsh
	echo "*****************************"
	echo "* oh my zsh"
	echo "*****************************"
	#. "$DOTFILES_DIR/install/oh-my-zsh.sh"

	sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

	# spaceship-prompt (theme)
	git clone https://github.com/denysdovhan/spaceship-prompt.git "$HOME/.oh-my-zsh/themes/spaceship-prompt"

	# powerline fonts
	brew install fonts-powerline

	# create symlink
	ln -s "$HOME/.oh-my-zsh/themes/spaceship-prompt/spaceship.zsh-theme" "$HOME/.oh-my-zsh/themes/spaceship-prompt/spaceship.zsh-theme"

	source ~/.zshrc
fi

if [ $ios == 1 ] ; then
    echo "*****************************"
    echo "installing ios libraries"
    echo "*****************************"

    brew install --HEAD usbmuxd
    brew link usbmuxd
    brew install --HEAD libimobiledevice
    brew install ideviceinstaller
    brew install ios-deploy
    brew install cocoapods
    pod setup
fi

if [ $android == 1 ] ; then
	echo "*****************************"
	echo 'install android studio and set sdk path'
	echo "*****************************"

	curl -O "https://dl.google.com/dl/android/studio/install/3.3.2.0/android-studio-ide-182.5314842-mac.dmg"
	echo 'install flutter and set path'

	curl -O "https://storage.googleapis.com/flutter_infra/releases/stable/macos/flutter_macos_v1.2.1-stable.zip"
	unzip ~/flutter_macos_v1.2.1-stable.zip
	
    # Need to verify this line
    echo 'export PATH="$PATH:/usr/flutter/bin"' >> ~/.bash_profile
    
    source ~/.bash_profile
	echo 'update flutter'
	flutter doctor
fi

if [ $npm == 1 ] ; then
    echo "****************************"
    echo 'installing npm and nvm'
    echo "****************************"
    brew install node -y
    brew install npm -y
    npm install npm@latest -gy
    curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh | bash
    echo "****************************"
    echo 'confirming nvm is installed'
    nvm -v
fi
