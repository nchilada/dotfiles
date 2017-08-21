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

# The next line updates PATH for the Google Cloud SDK.
if [ -f '$HOME/.google-cloud-sdk/path.bash.inc' ]
then
    source '$HOME/.google-cloud-sdk/path.bash.inc'
fi

# The next line enables shell command completion for gcloud.
if [ -f '$HOME/.google-cloud-sdk/completion.bash.inc' ]
then
    source '$HOME/.google-cloud-sdk/completion.bash.inc'
fi

# Optimizely dependencies.
source $HOME/optimizely/optimizely/.source_this.sh
export PATH=$HOME/tools/arcanist/bin:$PATH

# Optimizely environment variables.
# TODO: Unfortunately, `source "$PARENT/.bashrc"` sets `$DIR` to the parent, so we have to index into profile_optly/...
export GITHUB_TOKEN=$(cat "$DIR/profile_optly/github_token.txt")
source $DIR/profile_optly/client-js-github-token.bash
source $DIR/profile_optly/browserstack.bash

# Suppress some warnings from OS 10.8's implementation of sudo.
# See http://apple.stackexchange.com/a/83566.
sudo () { ( unset LD_LIBRARY_PATH DYLD_LIBRARY_PATH; exec command sudo $* ) }
