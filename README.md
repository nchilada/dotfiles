dotfiles
=====


## Configure

Pick a platform and a profile for use on your machine, for example `mac` and `mba12`.

Install the relevant dotfiles:

```sh
./bootstrap.sh mac mba12
```

**This is dangerous!**  It'll override any existing dotfiles in your home directory with symlinks to files in this repository.


## Install

The previous step also creates a symlink, at the top level of this repository, to a platform- and profile-specific Makefile.  Use this Makefile to download and install packages:

```sh
make install
```

If you don't like what has transpired:

```sh
make uninstall
```


## Credits

Inspired by [https://github.com/jsm/env](https://github.com/jsm/env).
