### Source: configs/platform_mac/.zshrc


### First, inherit from the common .zshrc.

# Find the path to this file.
FILE="${(%):-%x}"
while [ -h "$FILE" ]; do
    # $FILE is a symlink, so follow it to the source.
    TARGET="$(readlink "$FILE")"
    if [[ "$TARGET" == /* ]]; then
        # Absolute path.
        FILE="$TARGET"
    else
        # Relative path.
        DIR="$( cd -P "$( dirname "$FILE" )" && pwd )"
        FILE="$DIR/$TARGET"
    fi
done

DIR=`dirname "$FILE"`
PARENT=`dirname "$DIR"`
source "$PARENT/.zshrc"


### Now do the rest.

# Start an ssh-agent so that we can use ssh-add in this shell session
# TODO: Reuse a single ssh-agent across shell sessions. See http://blog.joncairns.com/2013/12/understanding-ssh-agent-and-ssh-add/ and https://github.com/wwalker/ssh-find-agent
if [[ -z "$SSH_AUTH_SOCK" || -z "$SSH_AGENT_PID" ]]
then
    eval "$(ssh-agent -s)" > /dev/null
fi

# Use Emacs or launch Emacs.app from the command line.
alias emacs='/Applications/Emacs.app/Contents/MacOS/Emacs -nw $@'
alias emax='/Applications/Emacs.app/Contents/MacOS/Emacs $@'

# Hopefully, point to the version of Java installed by
# runtimes/platform_mac/Makefile:java
# Could maybe get it from `/usr/libexec/java_home`, but that requires specific
# versions of XCode.
export JAVA_HOME=/Library/Java/Home
export PATH=$JAVA_HOME/bin:$PATH
export MANPATH=$JAVA_HOME/man:$MANPATH
export LD_LIBRARY_PATH=$JAVA_HOME/lib:$LD_LIBRARY_PATH

# GNU sed, once installed via `make install-sed`.
export PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"
export MANPATH="/usr/local/opt/gnu-sed/libexec/gnuman:$MANPATH"

# iTerm2 tab/window titles.
# - `title` sets the title to the name of the current working directory.
# - `title Foo bar` sets the title to 'Foo bar'.
title() {
    local title
    if [ $# -gt 0 ]
    then
        title=$@
    else
        title=${PWD##*/}
    fi
    echo -ne "\033]0;${title}\007"
};

# Node version manager.
# TODO(zshrc): Is there a more conventional way to check if `nvm` is a function?
if (( ${+functions[nvm]} ));
then
    :
else
    source "$(brew --prefix nvm)/nvm.sh"
    source "$(brew --prefix nvm)/etc/bash_completion.d/nvm"
fi

# Python version manager.
if which pyenv > /dev/null
then
    :
else
    eval "$(pyenv init -)"
    # TODO: Maybe test for a different condition than `which pyenv` before running this command?
    eval "$(pyenv virtualenv-init -)"
fi
