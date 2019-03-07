#!/bin/bash

# get current director
export DOTFILES_DIR
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# backup dotfiles
echo "Backing up your system's dotfiles..."
BACKUP_DIR="$HOME/backup_old_dotfiles"
mkdir $BACKUP_DIR
mv "~/.bashrc" $BACKUP_DIR
mv "~/.bash_profile" $BACKUP_DIR


echo 'Install xcode'
sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer
sudo xcodebuild -license


echo 'INSTALL HOMEBREW and dependencies'
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"


#symlinks
echo 'creating symlinks'
ln -sf "$DOTFILES_DIR/git/.gitconfig" ~
ln -sf "$DOTFILES_DIR/git/.gitignore_global" ~
ln -sf "$DOTFILES_DIR/zsh/.zshrc" ~
ln -sf "$DOTFILES_DIR/zsh/.zsh_exports" ~
ln -sf "$DOTFILES_DIR/zsh/.zsh_aliases" ~
ln -sf "$DOTFILES_DIR/bash/.bash_profile" ~ 
ln -sf "$DOTFILES_DIR/bash/.bashrc" ~
ln -sf "$DOTFILES_DIR/vim/.vimrc" ~

echo "*****************************"
echo "Installing MAC VIM and Plugins..."
echo "*****************************"

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall

echo "*****************************"
echo "Installing ZSH"
echo "*****************************"

brew install zsh zsh-completions

echo "*****************************"
echo "Setting zsh as default shell"
echo "*****************************"

chsh -s /bin/zsh

echo "*****************************"
echo "oh my zsh"
echo "*****************************"

# . "$DOTFILES_DIR/install/oh-my-zsh.sh"

sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# spaceship-prompt (theme)
git clone https://github.com/denysdovhan/spaceship-prompt.git "$HOME/.oh-my-zsh/themes/spaceship-prompt"

# powerline fonts
brew install fonts-powerline

# create symlink
ln -s "$HOME/.oh-my-zsh/themes/spaceship-prompt/spaceship.zsh-theme" "$HOME/.oh-my-zsh/themes/spaceship.zsh-theme"

source ~/zsh/.zshrc

echo "*****************************"

echo "*****************************"
echo 'set bash_profile'
echo "*****************************"

chmod 700 ~/bash/.bash_profile
chmod 700 ~/bash/.bashrc

echo "*****************************"
echo 'install android studio and set sdk path'
echo "*****************************"

curl -O "https://dl.google.com/dl/android/studio/install/3.3.2.0/android-studio-ide-182.5314842-mac.dmg"
echo 'install flutter and set path'

curl -O "https://storage.googleapis.com/flutter_infra/releases/stable/macos/flutter_macos_v1.2.1-stable.zip"
unzip ~/flutter_macos_v1.2.1-stable.zip
export PATH=$PATH:`pwd`/flutter/bin"


echo 'update flutter'
flutter doctor

echo 'update brew'
brew update


