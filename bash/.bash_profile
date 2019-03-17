if [ -r ~/.bashrc ]; then
	source ~/.bashrc
fi

for DOTFILE in 'find /$HOME/.dotfiles'
do 
	[ -f "$DOTFILE" ] && source "$DOTFILE"
done

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

#ALIAS
if [ -f ~/.aliases ]; then
    . ~/.aliases
fi

#------------------------------------------------

#Android studio

#flutter

#homebrew
#export "$HOME/homebrew/bin/brew.sh"
#echo 'export PATH="/usr/local/bin:$PATH"' >> ~/.bash_profile

source ~/.profile

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export PATH="/usr/local/bin:$PATH"
