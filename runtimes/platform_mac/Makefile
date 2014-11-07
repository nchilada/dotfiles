# Symlinks to runtimes, once installed.

HOMEBREW := /usr/local/bin/brew
CASK := ${HOMEBREW} cask
CASK_ARTIFACT := /usr/local/bin/brew-cask.rb

CLOJURE := /usr/local/bin/clj
LEININGEN := /usr/local/bin/lein

GIT := /usr/local/bin/git

JAVA := /usr/local/bin/java

NODE := /usr/local/bin/node

PYTHON := /usr/local/bin/python
PIP := /usr/local/bin/pip
VIRTUALENV := /usr/local/bin/virtualenv # necessary?

TREE := /usr/local/bin/tree


# Don't create a file at ./install when running the install command,
# and run the install command even if a file exists at ./install.
#
# NOTE: For some reason, install is the only command for which make creates such
#       a file.  Perhaps because it's the first/default command?
.PHONY: install


# Install runtimes.

install: install-brew install-cask install-clojure-packages install-git install-node-packages install-python-packages install-tree


install-brew:
	type ${HOMEBREW} >/dev/null 2>&1 || \
		ruby -e "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

install-cask: install-brew
	type ${CASK_ARTIFACT} >/dev/null 2>&1 || \
		${HOMEBREW} install caskroom/cask/brew-cask


install-clojure: install-brew install-java
	type ${LEININGEN} >/dev/null 2>&1 || \
		${HOMEBREW} install leiningen

install-clojure-packages: install-clojure
	true


install-git: install-brew
	type ${GIT} >/dev/null 2>&1 || \
		${HOMEBREW} install git


install-java: install-cask
	type ${JAVA} >/dev/null 2>&1 || \
		${CASK} install java


install-node: install-brew
	type ${NODE} >/dev/null 2>&1 || \
		${HOMEBREW} install node

install-node-packages: install-node
	npm install --prefix ${HOME} collections es6-promise lodash request


install-python: install-brew
	type ${PYTHON} >/dev/null 2>&1 || \
		${HOMEBREW} install python

install-python-packages: install-python
	${PIP} install ipython requests virtualenv


install-tree: install-brew
	type ${TREE} >/dev/null 2>&1 || \
		${HOMEBREW} install tree


# Upgrade runtimes.

upgrade: update-brew
	${HOMEBREW} upgrade `${HOMEBREW} outdated`

upgrade-node: update-brew
	${HOMEBREW} upgrade `${HOMEBREW} outdated | grep node`

# Helper.
update-brew: install-brew
	${HOMEBREW} update


# Uninstall runtimes.

# Uninstall individual brew packages BEFORE uninstalling brew.
uninstall: uninstall-clojure uninstall-git uninstall-node uninstall-python uninstall-tree uninstall-cask uninstall-brew


uninstall-brew:
	type ${HOMEBREW} >/dev/null 2>&1 && \
		rm -rf /usr/local/Cellar /usr/local/.git && ${HOMEBREW} cleanup && rm ${HOMEBREW}

uninstall-cask: install-brew
	type ${CASK_ARTIFACT} >/dev/null 2>&1 && \
		${HOMEBREW} uninstall caskroom/cask/brew-cask


uninstall-clojure: uninstall-clojure-packages
	type ${LEININGEN} >/dev/null 2>&1 && \
		${HOMEBREW} uninstall leiningen

uninstall-clojure-packages: install-clojure
	true


uninstall-git: install-brew
	type ${GIT} >/dev/null 2>&1 && \
		${HOMEBREW} uninstall git


uninstall-java: install-cask
	type ${JAVA} >/dev/null 2>&1 && \
		${CASK} uninstall java


uninstall-node: uninstall-node-packages
	type ${NODE} >/dev/null 2>&1 && \
		${HOMEBREW} uninstall node

# If node is already uninstalled (likely due to extramakefile hijinks),
# then we'll have to install it, and this command will have the side-effect of
# having installed node.
uninstall-node-packages: install-node
	npm uninstall --prefix ${HOME} collections es6-promise lodash request


uninstall-python: uninstall-python-packages
	type ${PYTHON} >/dev/null 2>&1 && \
		${HOMEBREW} uninstall python

# If python is already uninstalled (likely due to extramakefile hijinks),
# then we'll have to install it, and this command will have the side-effect of
# having installed python.
uninstall-python-packages: install-python
	${PIP} uninstall ipython requests virtualenv


uninstall-tree: install-brew
	type ${TREE} >/dev/null 2>&1 && \
		${HOMEBREW} uninstall tree
