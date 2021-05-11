export PATH="/usr/local/bin:~/bin:~/.emacs.d/bin:/usr/local/Cellar/emacs-plus@27/27.1/Emacs.app/Contents/MacOS:usr/local/bin/python3:/opt/local/libexec/gnubin:/opt/local/bin:$PATH"
# /Users/sergeymelnikov/input-source-switcher/build:

# virtualenv and virtualenvwrapper
export WORKON_HOME=$HOME/.virtualenvs
export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python3
source /usr/local/bin/virtualenvwrapper.sh

# Git branch in prompt
parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

export PS1='\[\e[34m\]\w\[\e[39m\]$(parse_git_branch) \[\e[32m\]\$\[\e[39m\] '
#export PS1="\u@\h \W\[\033[32m\]\$(parse_git_branch)\[\033[00m\] $ "
export EDITOR=/usr/bin/vim

# Disable warning message about zsh is the new default shell for MacOS
export BASH_SILENCE_DEPRECATION_WARNING=1

# Aliases
alias f='open -a Finder ./'
alias la='ls -A'
alias l='ls -CF'
alias ll='ls -ahlGF'
alias v='vim'
alias python=python3
alias g='git'
alias gs='git status'
alias srv='ssh mainuser@10.0.1.14'
alias srb=~/bng_srv.sh
alias blog='tail ~/code/bng_notificator/log.txt'
alias zkv='cd ~/Library/Mobile\ Documents/iCloud~com~appsonthemove~beorg/Documents/org'

# Create a new directory and enter it
function d() {
    mkdir -p "$@" && cd "$@"
} 

function extract () {
    if [ -f $1 ] ; then
      case $1 in
        *.tar.bz2)   tar xjf $1     ;;
        *.tar.gz)    tar xzf $1     ;;
        *.bz2)       bunzip2 $1     ;;
        *.rar)       unrar e $1     ;;
        *.gz)        gunzip $1      ;;
        *.tar)       tar xf $1      ;;
        *.tbz2)      tar xjf $1     ;;
        *.tgz)       tar xzf $1     ;;
        *.zip)       unzip $1       ;;
        *.Z)         uncompress $1  ;;
        *.7z)        7z x $1        ;;
        *)     echo "'$1' cannot be extracted via extract()" ;;
         esac
     else
         echo "'$1' is not a valid file"
     fi
}
