### Source: configs/platform_linux/profile_ews/.bashrc


### First, inherit from the platform's .bashrc.

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

PLATFORM_PROFILE_CONFIGS=`dirname "$FILE"`
PLATFORM_CONFIGS=`dirname "$PLATFORM_PROFILE_CONFIGS"`
source "$PLATFORM_CONFIGS/.bashrc"


### Now do the rest.

# K Framework (cs422).
export PATH=$HOME/k-framework-read-only/dist/bin:$PATH
export PATH=$HOME/k-framework-read-only/dist/bin/maude/binaries:$PATH
export MAUDE_LIB=$HOME/k-framework-read-only/dist/bin/maude:$MAUDE_LIB

# LLVM (cs426).
export PATH=$HOME/cs426/llvm-3.1.src/Release+Asserts/bin:$PATH
alias ll-gcc='llvm-gcc -S --emit-llvm'           # Run ll-gcc -o <output filename>
