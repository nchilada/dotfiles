### Source: configs/.bashrc


### Nothing to inherit from.

export PATH=$HOME/bin:/usr/local/bin:$PATH
export MANPATH=$HOME/man:/usr/local/man:$MANPATH
export LD_LIBRARY_PATH=$HOME/lib:/usr/local/lib:$LD_LIBRARY_PATH

export EDITOR=emacs
export PAGER=less

# prompt
export PS1="\u » "

# git autocompletion.
source ~/.git-completion.bash

# ssh hostname autocompletion.
# - `ssh <prefix>` and then TAB to view suggestions.
complete -o default -o nospace -W "$(grep -i -e '^host ' ~/.ssh/config | awk '{print substr($0, index($0,$2))}' ORS=' ')" ssh scp sftp
