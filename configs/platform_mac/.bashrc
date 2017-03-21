### Source: configs/platform_mac/.bashrc


### First, inherit from the common .bashrc.

# Find the path to this file.
FILE="${BASH_SOURCE[0]}"
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
source "$PARENT/.bashrc"


### Now do the rest.

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
