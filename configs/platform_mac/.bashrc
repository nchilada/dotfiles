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

# Use Emacs.app on the command line.
alias emacs='/Applications/Emacs.app/Contents/MacOS/Emacs -nw $@'

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
