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
export EC2_HOME=/Users/nikhil/optimizely/out/ec2_api_tools
export PATH=/Users/nikhil/optimizely/out/ec2_api_tools/bin:$PATH
export PATH=/Users/nikhil/optimizely/out:$PATH
export PATH=/Users/nikhil/tools/arcanist/bin:$PATH

# Optimizely environment variables.
export SAUCE_USERNAME=NikhilChelliah

# Sets `java`, `javac`, etc. to Oracle Java 7 which was installed with default configs.
# Unfortunately, I forget why I needed to install Java in the first place. :(
export JAVA_HOME="`/usr/libexec/java_home -v '1.7.*'`"
