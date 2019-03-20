if [ -r ~/.bashrc ]; then
	source ~/.bashrc
fi

for DOTFILE in 'find /$HOME/.dotfiles'
do 
	[ -f "$DOTFILE" ] && source "$DOTFILE"
done
#------------------------------------------------

source ~/.bash_profile

export PATH="$PATH:$HOME/Downloads/flutter/bin"
