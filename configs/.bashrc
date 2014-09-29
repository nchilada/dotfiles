### Source: configs/.bashrc


### Nothing to inherit from.

export PATH=$HOME/bin:$PATH
export MANPATH=$HOME/man:$MANPATH
export LD_LIBRARY_PATH=$HOME/lib:$LD_LIBRARY_PATH

# prompt
PS1=$'\u \$ '

# git autocompletion.
source ~/.git-completion.bash

# ssh hostname autocompletion.
# - `ssh <prefix>` and then TAB to view suggestions.
complete -o default -o nospace -W "$(grep -i -e '^host ' ~/.ssh/config | awk '{print substr($0, index($0,$2))}' ORS=' ')" ssh scp sftp
