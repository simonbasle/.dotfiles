# configure antigen
DOTFILES=$HOME/.dotfiles
source $DOTFILES/antigen/antigen.zsh

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

# choose a theme
################
#fallback to af-magic if more advanced theme don't work well
#THEME="antigen theme af-magic"
################
THEME="antigen theme caiogondim/bullet-train-oh-my-zsh-theme bullet-train"

export HELP_DOTFILES="Useful aliases/functions:"

# load local bundles and env-specific bundles
antigen bundle $DOTFILES/scripts/common
if (($+BABUN_HOME)) then
  #On Babun, shell is too slow with powerline themes so fall back to pure
  THEME="antigen bundle sindresorhus/pure"
  #Source babun-specific configurations
  antigen bundle $DOTFILES/scripts/babun/babun.zsh
fi

# apply theme
eval $THEME

# apply antigen to zsh
antigen apply

# help : append useful aliases from bundles
export HELP_DOTFILES="$HELP_DOTFILES\ngst, ggpush, gcmsg : git status / push origin currBranch / commit -m\ngi - generate a gitignore file\nx - extract from various archive formats"
echo "Welcome Simon - for a list of useful aliases/functions, type 'help'"
function help() {
  echo $HELP_DOTFILES;
}
