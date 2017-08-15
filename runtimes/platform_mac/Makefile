# Symlinks to runtimes, once installed.

HOMEBREW := /usr/local/bin/brew
CASK := ${HOMEBREW} cask
CASK_ARTIFACT := /usr/local/bin/brew-cask.rb

CLOJURE := /usr/local/bin/clj
LEININGEN := /usr/local/bin/lein

ELM := /usr/local/bin/elm-make

GIT := /usr/local/bin/git

JAVA := /usr/local/bin/java

SED := /usr/local/opt/gnu-sed/libexec/gnubin/sed

TREE := /usr/local/bin/tree

# For commands that ask for confirmation.  See http://stackoverflow.com/a/16745106
YES := /usr/bin/yes



# Don't create a file at ./install when running the install command,
# and run the install command even if a file exists at ./install.
#
# NOTE: For some reason, install is the only command for which make creates such
#       a file.  Perhaps because it's the first/default command?
.PHONY: install



# Install runtimes.

install: install-brew-and-cask install-cask-apps install-command-line-tools install-elm-and-packages install-java-and-clojure-and-packages install-nvm install-pyenv



install-brew-and-cask: install-brew install-cask

install-brew:
	type ${HOMEBREW} >/dev/null 2>&1 || \
		ruby -e "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

install-cask: install-brew
	type ${CASK_ARTIFACT} >/dev/null 2>&1 || \
		${HOMEBREW} tap caskroom/cask



install-cask-apps: install-cask
	${CASK} install \
		acorn `# Should track the license in this repo.` \
		charles `# Should track the license in this repo.` \
		clipy \
		emacs \
		evernote \
		firefox \
		flux \
		free-ruler \
		google-chrome \
		gpgtools \
		iterm2 \
		jitouch \
		nosleep \
		1password `# Should get a license and track it in the repo.` \
		praat \
		pycharm \
		selfcontrol \
		skype \
		slack \
		slate \
		spectacle \
		sourcetree `# Should get a license and track it in the repo.` \
		sync \
		webstorm \
		whatsapp \
		witch `# Should track the license in this repo.` \



install-command-line-tools: install-git install-sed install-tree

install-git: install-brew
	type ${GIT} >/dev/null 2>&1 || \
		${HOMEBREW} install git

install-sed: install-brew
	type ${SED} >/dev/null 2>&1 || \
		${HOMEBREW} install gnu-sed

install-tree: install-brew
	type ${TREE} >/dev/null 2>&1 || \
		${HOMEBREW} install tree



install-elm-and-packages: install-elm-packages

install-elm: install-cask
	type ${ELM} >/dev/null 2>&1 || \
		${CASK} install elm-platform

install-elm-packages: install-elm
	true



install-java-and-clojure-and-packages: install-clojure-packages

install-clojure: install-brew install-java
	type ${LEININGEN} >/dev/null 2>&1 || \
		${HOMEBREW} install leiningen

install-clojure-packages: install-clojure
	true

install-java: install-cask
	type ${JAVA} >/dev/null 2>&1 || \
		${CASK} install java



# TODO: Maybe use `nvm` to install a basic Node with lodash, request, and collections?
install-nvm: install-brew
	${HOMEBREW} install nvm



# TODO: Maybe use `pyenv` to install a basic Python 2 and a Python 3 with ipython, pdbpp, and requests?
install-pyenv: install-brew
	${HOMEBREW} install pyenv && ${HOMEBREW} install pyenv-virtualenv



# Update runtimes.

update: install-brew
	${HOMEBREW} update && \
		${HOMEBREW} upgrade


# Uninstall runtimes.

# Uninstall individual brew packages BEFORE uninstalling brew.
uninstall: uninstall-cask-apps uninstall-command-line-tools uninstall-elm-and-packages uninstall-java-and-clojure-and-packages uninstall-nvm uninstall-pyenv uninstall-brew-and-cask



uninstall-brew-and-cask: uninstall-cask uninstall-brew

uninstall-brew:
	type ${HOMEBREW} >/dev/null 2>&1 && \
		rm -rf /usr/local/Cellar /usr/local/.git && ${HOMEBREW} cleanup && rm ${HOMEBREW}

uninstall-cask: install-brew
	type ${CASK_ARTIFACT} >/dev/null 2>&1 && \
		${HOMEBREW} uninstall caskroom/cask/brew-cask



uninstall-cask-apps: install-cask
	${CASK} uninstall \
		acorn \
		charles \
		clipmenu \
		dropbox \
		emacs \
		evernote \
		firefox \
		flux \
		free-ruler \
		google-chrome \
		gpgtools \
		iterm2 \
		jitouch \
		lighttable \
		nosleep \
		1password \
		praat \
		selfcontrol \
		skype \
		slate \
		spectacle \
		sourcetree \
		webstorm \
		witch \



uninstall-command-line-tools: uninstall-git uninstall-sed uninstall-tree

uninstall-git: install-brew
	type ${GIT} >/dev/null 2>&1 && \
		${HOMEBREW} uninstall git || \
		true

uninstall-sed: install-brew
	type ${SED} >/dev/null 2>&1 && \
		${HOMEBREW} uninstall gnu-sed || \
		true

uninstall-tree: install-brew
	type ${TREE} >/dev/null 2>&1 && \
		${HOMEBREW} uninstall tree || \
		true



uninstall-elm-and-packages: uninstall-elm-packages uninstall-elm

uninstall-elm:
	type ${ELM} >/dev/null 2>&1 && \
		${CASK} uninstall elm-platform || \
		true

uninstall-elm-packages: install-elm
	true



uninstall-java-and-clojure-and-packages: uninstall-clojure-packages uninstall-clojure uninstall-java

uninstall-clojure: install-brew
	type ${LEININGEN} >/dev/null 2>&1 && \
		${HOMEBREW} uninstall leiningen || \
		true

uninstall-clojure-packages: install-clojure
	true

uninstall-java: install-cask
	type ${JAVA} >/dev/null 2>&1 && \
		${CASK} uninstall java || \
		true



uninstall-nvm: install-brew
	${HOMEBREW} uninstall nvm



uninstall-pyenv: install-brew
	${HOMEBREW} uninstall pyenv-virtualenv && ${HOMEBREW} uninstall pyenv
