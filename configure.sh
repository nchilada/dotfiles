# Expect arguments <platform> and <profile>
# that identify a directory ./configs/<platform>/<profile>/


### Process input

if [ $# -ne 2 ]; then
   echo "Error in $0 $@: expected 2 arguments, received $#"
   exit 1
fi

THIS_REPO="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

CONFIGS="$THIS_REPO/configs"
PLATFORM_CONFIGS="$CONFIGS/platform_$1"
PLATFORM_PROFILE_CONFIGS="$PLATFORM_CONFIGS/profile_$2"


if [ ! -d "$PLATFORM_PROFILE_CONFIGS" ]; then
   echo "Error in $0 $@: can't find $PLATFORM_PROFILE_CONFIGS/"
   exit 1
fi


### Register configs from ./configs/<platform>/<profile>/

# Make sure the wildcard returns hidden files.
shopt -s dotglob
# Make sure the wildcard works even when the directory is empty.
shopt -s nullglob

for filename in "$CONFIGS"/*; do
   # Skip platform_* entries, which are special (see below).
   if [[ `basename "$filename"` == platform_* ]]; then
       continue
   fi
   # Skip temporary files.
   git ls-files "$filename" --error-unmatch &> /dev/null
   exit_status=$?
   if [ $exit_status != 0 ]; then
       continue
   fi

   # For simple files, create a symlink directly from from ~/.
   # DANGER: existing entries in ~/ will be lost forever!
   if [[ -f "$filename" || -L "$filename" || $(basename "$filename") == .emacs.d ]]; then
       linkname=$HOME/$(basename "$filename")
       echo "$linkname ----------------> $filename"
       ln -sf "$filename" "$linkname"

   # Within directories, symlink simple files.
   # DANGER: existing entries within those directories will be lost forever!
   elif [[ -d "$filename" ]]; then
       topname="$filename"
       IFS=$'\n'
       for filename in $(find "$topname" -type f -o -type l); do
           linkname=$(echo "$filename" | sed "s:.*/$(basename "$topname")/:$HOME/$(basename "$topname")/:")
           echo "$linkname ----------------> $filename"
           mkdir -p $(dirname "$linkname")
           ln -sf "$filename" "$linkname"
       done
       unset IFS
   fi
done

for filename in "$PLATFORM_CONFIGS"/*; do
   # Skip profile_* entries, which are special (see below).
   if [[ `basename "$filename"` == profile_* ]]; then
       continue
   fi
   # Skip temporary files.
   git ls-files "$filename" --error-unmatch &> /dev/null
   exit_status=$?
   if [ $exit_status != 0 ]; then
       continue
   fi

   # For simple files, create a symlink directly from from ~/.
   # DANGER: existing entries in ~/ will be lost forever!
   if [[ -f "$filename" || -L "$filename" || $(basename "$filename") == .emacs.d ]]; then
       linkname=$HOME/$(basename "$filename")
       echo "$linkname ----------------> $filename"
       ln -sf "$filename" "$linkname"

   # Within directories, symlink simple files.
   # DANGER: existing entries within those directories will be lost forever!
   elif [[ -d "$filename" ]]; then
       topname="$filename"
       IFS=$'\n'
       for filename in $(find "$topname" -type f -o -type l); do
           linkname=$(echo "$filename" | sed "s:.*/$(basename "$topname")/:$HOME/$(basename "$topname")/:")
           echo "$linkname ----------------> $filename"
           mkdir -p $(dirname "$linkname")
           ln -sf "$filename" "$linkname"
       done
       unset IFS
   fi
done

for filename in "$PLATFORM_PROFILE_CONFIGS"/*; do
   # Skip temporary files.
   git ls-files "$filename" --error-unmatch &> /dev/null
   exit_status=$?
   if [ $exit_status != 0 ]; then
       continue
   fi

   # For simple files, create a symlink directly from from ~/.
   # DANGER: existing entries in ~/ will be lost forever!
   if [[ -f "$filename" || -L "$filename" || $(basename "$filename") == .emacs.d ]]; then
       linkname=$HOME/$(basename "$filename")
       echo "$linkname ----------------> $filename"
       ln -sf "$filename" "$linkname"

   # Within directories, symlink simple files.
   # DANGER: existing entries within those directories will be lost forever!
   elif [[ -d "$filename" ]]; then
       topname="$filename"
       IFS=$'\n'
       for filename in $(find "$topname" -type f -o -type l); do
           linkname=$(echo "$filename" | sed "s:.*/$(basename "$topname")/:$HOME/$(basename "$topname")/:")
           echo "$linkname ----------------> $filename"
           mkdir -p $(dirname "$linkname")
           ln -sf "$filename" "$linkname"
       done
       unset IFS
   fi
done


### Register runtimes from ./runtimes/<platform>/<profile>/

RUNTIMES="$THIS_REPO/runtimes"
PLATFORM_RUNTIMES="$RUNTIMES/platform_$1"
PLATFORM_PROFILE_RUNTIMES="$PLATFORM_RUNTIMES/profile_$2"

# Create a symlink from ./Makefile to the most specific Makefile.
linkname=./Makefile
if [[ -e "$PLATFORM_PROFILE_RUNTIMES"/Makefile ]]; then
    ln -sf "$PLATFORM_PROFILE_RUNTIMES"/Makefile "$linkname"
elif [[ -e "$PLATFORM_RUNTIMES"/Makefile ]]; then
    ln -sf "$PLATFORM_RUNTIMES"/Makefile "$linkname"
elif [[ -e "$RUNTIMES"/Makefile ]]; then
    ln -sf "$RUNTIMES"/Makefile "$linkname"
fi
