# configure antigen
ZSHA_BASE=$HOME/.dotfiles
source $ZSHA_BASE/antigen/antigen.zsh

#ensure correct terminal configuration
export LANG=en_US.UTF-8
export TERM=xterm-256color

# load oh-my-zsh
antigen use oh-my-zsh

# load various 3rd-party bundles
antigen bundles <<EOBUNDLES
  # syntax coloration
  zsh-users/zsh-syntax-highlighting

  # search command history for prefixed commands
  zsh-users/zsh-history-substring-search

  # locate the package in which to find an unknown command (via /etc/zsh_command_not_found)
  command-not-found

  # cat with syntax highlight (need python's Pygments)
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

# load local bundles
antigen bundle $ZSHA_BASE/alias

# choose a theme
################
#fallback to af-magic if more advanced theme don't work well
#antigen theme af-magic
################
#On Babun, shell is too slow with powerline themes so fall back to pure
if (($+BABUN_HOME)) then
  antigen bundle sindresorhus/pure
else
  antigen theme caiogondim/bullet-train-oh-my-zsh-theme bullet-train
fi
# apply antigen to zsh
antigen apply
