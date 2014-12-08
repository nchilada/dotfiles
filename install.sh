# Use the Makefile (from configure.sh) to install runtimes.
if [[ -e Makefile ]]; then
    make install
    make upgrade
fi
