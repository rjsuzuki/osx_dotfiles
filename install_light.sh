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
zsh=1
tools=1

#--------------------------------------------
# MANDATORY SWITCHES
#--------------------------------------------
if [ $back_up == 1 ] ; then
	echo "-------------------------------------------"
	echo " BACKUP DOTFILES"
	echo "-------------------------------------------"
	echo "Backing up your system's dotfiles..."
	BACKUP_DIR="$HOME/backup_old_dotfiles"
	mkdir $BACKUP_DIR
	mv "~/.bashrc" $BACKUP_DIR
	mv "~/.bash_profile" $BACKUP_DIR
fi

#--------------------------------------------
# SYMLINKS
#--------------------------------------------
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

#--------------------------------------------
# TERMINAL TOOLS
#--------------------------------------------
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
