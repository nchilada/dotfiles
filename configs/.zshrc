### Source: configs/.zshrc


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
# TODO(zsh): Re-enable using one of these:
#     https://medium.com/@oliverspryn/adding-git-completion-to-zsh-60f3b0e7ffbc
#     https://github.com/ohmyzsh/ohmyzsh
#     https://github.com/git/git/blob/master/contrib/completion/git-completion.zsh
#     etc.

# ssh hostname autocompletion.
# - `ssh <prefix>` and then TAB to view suggestions.
# TODO(zsh): Re-enable using something like https://www.codyhiar.com/blog/zsh-autocomplete-with-ssh-config-file/
# complete -o default -o nospace -W "$(grep -i -e '^host ' ~/.ssh/config | awk '{print substr($0, index($0,$2))}' ORS=' ')" ssh scp sftp

# TODO(zsh): Customize even more? https://www.soberkoder.com/better-zsh-history/ https://github.com/ohmyzsh/ohmyzsh/blob/master/lib/history.zsh
# Command history
export SAVEHIST=10000000
export HISTSIZE=10000000
export HISTFILESIZE=10000000
# *Append* to the history file so that we don't overwrite changes from other shells that may have been spawned and
# terminated during this shell's lifetime. https://unix.stackexchange.com/a/6509/291058
setopt INC_APPEND_HISTORY
