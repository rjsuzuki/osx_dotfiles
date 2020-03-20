if [ -r ~/.bashrc ]; then
	source ~/.bashrc
fi

for DOTFILE in 'find /$HOME/.dotfiles'
do 
	[ -f "$DOTFILE" ] && source "$DOTFILE"
done
#------------------------------------------------

source ~/.bash_profile



export ANDROID_HOME=/Users/$USER/Library/Android/sdk
export PATH={$PATH}:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools
export PATH="$PATH:$HOME/Downloads/flutter/bin"
export PATH="$PATH:$HOME/Projects/osx_dotfiles/tools"

