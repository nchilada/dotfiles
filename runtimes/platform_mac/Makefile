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

install: install-brew-and-cask install-command-line-tools install-java-and-clojure-and-packages install-node-and-packages install-python-and-packages



install-brew-and-cask: install-brew install-cask

install-brew:
	type ${HOMEBREW} >/dev/null 2>&1 || \
		ruby -e "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

install-cask: install-brew
	type ${CASK_ARTIFACT} >/dev/null 2>&1 || \
		${HOMEBREW} install caskroom/cask/brew-cask



install-command-line-tools: install-git install-tree

install-git: install-brew
	type ${GIT} >/dev/null 2>&1 || \
		${HOMEBREW} install git

install-tree: install-brew
	type ${TREE} >/dev/null 2>&1 || \
		${HOMEBREW} install tree



install-java-and-clojure-and-packages: install-clojure-packages

install-clojure: install-brew install-java
	type ${LEININGEN} >/dev/null 2>&1 || \
		${HOMEBREW} install leiningen

install-clojure-packages: install-clojure
	true

install-java: install-cask
	type ${JAVA} >/dev/null 2>&1 || \
		${CASK} install java



install-node-and-packages: install-node-packages

install-node: install-brew
	type ${NODE} >/dev/null 2>&1 || \
		${HOMEBREW} install node

install-node-packages: install-node
	npm install --prefix ${HOME} collections es6-promise lodash request



install-python-and-packages: install-python-packages

install-python: install-brew
	type ${PYTHON} >/dev/null 2>&1 || \
		${HOMEBREW} install python

install-python-packages: install-python
	${PIP} install ipython requests virtualenv



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
uninstall: uninstall-command-line-tools uninstall-java-and-clojure-and-packages uninstall-node-and-packages uninstall-python-and-packages uninstall-brew-and-cask



uninstall-brew-and-cask: uninstall-cask uninstall-brew

uninstall-brew:
	type ${HOMEBREW} >/dev/null 2>&1 && \
		rm -rf /usr/local/Cellar /usr/local/.git && ${HOMEBREW} cleanup && rm ${HOMEBREW}

uninstall-cask: install-brew
	type ${CASK_ARTIFACT} >/dev/null 2>&1 && \
		${HOMEBREW} uninstall caskroom/cask/brew-cask



uninstall-command-line-tools: uninstall-git uninstall-tree

uninstall-git: install-brew
	type ${GIT} >/dev/null 2>&1 && \
		${HOMEBREW} uninstall git || \
		true

uninstall-tree: install-brew
	type ${TREE} >/dev/null 2>&1 && \
		${HOMEBREW} uninstall tree || \
		true



uninstall-java-and-clojure-and-packages: uninstall-clojure-packages uninstall-clojure uninstall-java

uninstall-clojure:
	type ${LEININGEN} >/dev/null 2>&1 && \
		${HOMEBREW} uninstall leiningen || \
		true

uninstall-clojure-packages: install-clojure
	true

uninstall-java: install-cask
	type ${JAVA} >/dev/null 2>&1 && \
		${CASK} uninstall java || \
		true



uninstall-node-and-packages: uninstall-node-packages uninstall-node

uninstall-node:
	type ${NODE} >/dev/null 2>&1 && \
		${HOMEBREW} uninstall node || \
		true

uninstall-node-packages: install-node
	npm uninstall --prefix ${HOME} collections es6-promise lodash request



uninstall-python-and-packages: uninstall-python-packages uninstall-python

uninstall-python:
	type ${PYTHON} >/dev/null 2>&1 && \
		${HOMEBREW} uninstall python || \
		true

uninstall-python-packages: install-python
	${PIP} uninstall ipython requests virtualenv
