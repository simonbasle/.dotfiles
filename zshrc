# configure antigen
ZSHA_BASE=$HOME/.dotfiles
source $ZSHA_BASE/antigen/antigen.zsh

# load oh-my-zsh
antigen use oh-my-zsh

# load various 3rd-party bundles
antigen bundles <<EOBUNDLES
  # syntax coloration
  zsh-users/zsh-syntax-highlighting

  # search command history for prefixed commands
  zsh-users/zsh-history-substring-search

  # locate the package in which to find an unknown command
  #needs /etc/zsh_command_not_found : apt-get install command-not-found
  #apt-get install command-not-found
  #sudo apt-file update
  #sudo update-command-not-found
  command-not-found

  # cat with syntax highlight
  #needs pygmentize from python's pygments : pip install Pygments
  colorize

  # adds color to man pages
  colored-man

  #git related bundles
  git
  github
  # gitignore generation using gi via www.gitignore.io
  gitignore

  # simply extract archives with x
  extract

  #build tools
  ant
  mvn
  gradle

  #dev
  docker
  heroku
  vagrant
EOBUNDLES

# load custom bundles
antigen bundle $ZSHA_BASE/alias

# choose a theme
antigen theme ys

# apply antigen to zsh
antigen apply
