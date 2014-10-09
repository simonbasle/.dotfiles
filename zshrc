# configure antigen
ZSHA_BASE=$HOME/.dotfiles
source $ZSHA_BASE/antigen/antigen.zsh

# load oh-my-zsh
antigen use oh-my-zsh

# load various 3rd-party bundles
antigen bundles <<<EOBUNDLES
  # git related completions
  git

  # syntax coloration
  zsh-users/zsh-syntax-highlighting

  # search command history for prefixed commands
  zsh-users/zsh-history-substring-search

  # locate the package in which to find an unknown command
  command-not-found
EOBUNDLES

# load custom bundles
antigen bundle $ZSHA_BASE/alias

# choose a theme
antigen theme ys

# apply antigen to zsh
antigen apply
