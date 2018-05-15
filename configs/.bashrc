### Source: configs/.bashrc


### Nothing to inherit from.

export PATH=$HOME/bin:/usr/local/bin:$PATH
export MANPATH=$HOME/man:/usr/local/man:$MANPATH
export LD_LIBRARY_PATH=$HOME/lib:/usr/local/lib:$LD_LIBRARY_PATH

export EDITOR=emacs
export PAGER=less

# prompt
export PS1="\u » "

# When listing directory contents, use colors and trailing slashes appropriately.
alias ls='ls -GF'
alias tree='tree -CF'

# git autocompletion.
source ~/.git-completion.bash

# ssh hostname autocompletion.
# - `ssh <prefix>` and then TAB to view suggestions.
complete -o default -o nospace -W "$(grep -i -e '^host ' ~/.ssh/config | awk '{print substr($0, index($0,$2))}' ORS=' ')" ssh scp sftp

# Bash history
export HISTSIZE=10000000
export HISTFILESIZE=10000000
# *Append* to the history file so that we don't overwrite changes from other shells that may have been spawned and
# terminated during this shell's lifetime. https://unix.stackexchange.com/a/6509/291058
shopt -s histappend
# Create a *single* history entry for each multiline command
shopt -s cmdhist
shopt -s lithist
