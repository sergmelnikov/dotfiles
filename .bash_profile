# Homebrew
export PATH=/usr/local/bin:$PATH

# virtualenv and virtualenvwrapper
export WORKON_HOME=$HOME/.virtualenvs
export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python3
source /usr/local/bin/virtualenvwrapper.sh

export PS1='\e[35m\w $ \e[39m'

export BASH_SILENCE_DEPRECATION_WARNING=1

#Aliases
alias f='open -a Finder ./'

alias la='ls -A'
alias l='ls -CF'
alias ll='ls -alF'
alias v='vim'
