### Source: configs/platform_mac/profile_optly/.bashrc

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

DIR=`dirname "$FILE"`
PARENT=`dirname "$DIR"`
source "$PARENT/.bashrc"


### Now do the rest.

# MacPorts.
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"

# Optimizely dependencies.
source $HOME/optimizely/.source_this.sh
source $HOME/.rake_autocomplete.sh
export PATH=$HOME/tools/arcanist/bin:$PATH

# Optimizely environment variables.
export SAUCE_USERNAME=NikhilChelliah

# Suppress some warnings from OS 10.8's implementation of sudo.
# See http://apple.stackexchange.com/a/83566.
sudo () { ( unset LD_LIBRARY_PATH DYLD_LIBRARY_PATH; exec command sudo $* ) }
