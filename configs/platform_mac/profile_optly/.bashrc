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

# Point to the legacy Homebrew Cask installations.
HOMEBREW_CASK_OPTS="--caskroom=/opt/homebrew-cask/Caskroom"

# The next line updates PATH for the Google Cloud SDK.
source '/Users/nchelliah/.google-cloud-sdk/path.bash.inc'

# The next line enables shell command completion for gcloud.
source '/Users/nchelliah/.google-cloud-sdk/completion.bash.inc'

# MacPorts.
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"

# Optimizely dependencies.
source $HOME/optimizely/.source_this.sh
source $HOME/.optimizely/.rake_autocomplete.sh
export PATH=$HOME/tools/arcanist/bin:$PATH

# Optimizely environment variables.
# TODO: Unfortunately, `source "$PARENT/.bashrc"` sets `$DIR` to the parent, so we have to index into profile_optly/...
export GITHUB_TOKEN=$(cat "$DIR/profile_optly/github_token.txt")
source $DIR/profile_optly/browserstack.bash

# Sign git commits using GPG.
# These settings would ideally be in .gitconfig, but this repo doesn't support a profile-specific .gitconfig.
git config --global user.name "nikhil"
git config --global user.email "nikhil@optimizely.com"
git config --global user.signingkey "64A09F45"
git config --global commit.gpgsign "true"

# Suppress some warnings from OS 10.8's implementation of sudo.
# See http://apple.stackexchange.com/a/83566.
sudo () { ( unset LD_LIBRARY_PATH DYLD_LIBRARY_PATH; exec command sudo $* ) }

export NVM_DIR=~/.nvm
. $(brew --prefix nvm)/nvm.sh
