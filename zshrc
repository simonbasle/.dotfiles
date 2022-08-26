set -A HELP_DOTFILES

#look for a .dotfile-private.zsh file in the HOME directory
if [[ -f $HOME/.dotfiles-private.zsh ]]; then
    source $HOME/.dotfiles-private.zsh
fi

# prepare for antigen
export DOTFILES=$HOME/.dotfiles
source $DOTFILES/scripts/pre_antigen.zsh
source $DOTFILES/scripts/utils.zsh

# configure antigen
START_ANTIGEN=$(tic)
source $DOTFILES/antigen/antigen.zsh

#ensure correct terminal configuration
export LANG=en_US.UTF-8
export TERM=xterm-256color

# load oh-my-zsh
echo "$MAGENTA Oh-My-Zsh Bundles$RESET"
START=$(tic)
antigen use oh-my-zsh
echo "$CYAN [$(toc $START)s]\tOMZ Lib$RESET"

# Bundles
#########
##CLI
START=$(tic)
# syntax coloration
antigen bundle zsh-users/zsh-syntax-highlighting
# search command history for prefixed commands
antigen bundle zsh-users/zsh-history-substring-search
# cat with syntax highlight (need python's Pygments)
antigen bundle colorize
# adds color to man pages
antigen bundle colored-man-pages
echo "$CYAN [$(toc $START)s]\tcli$RESET"

##GIT
START=$(tic)
#git related bundles
antigen bundle git
antigen bundle github
#replaced by hub's own completion antigen bundle github
#note: on OSX (brew installed, the fpath needs to be changed)
echo "$CYAN [$(toc $START)s]\tgit$RESET"

##UTILITIES
START=$(tic)
# # simply extract archives with x
antigen bundle extract
echo "$CYAN [$(toc $START)s]\tutility$RESET"

##BUILD AND DEV TOOLS
START=$(tic)
antigen bundle mvn
antigen bundle gradle
antigen bundle docker
antigen bundle vagrant
echo "$CYAN [$(toc $START)s]\tbuild and dev tools$RESET"

##Java, Ruby & Python
START=$(tic)
antigen bundle spring
# antigen bundle ruby
# antigen bundle rbenv
antigen bundle python
echo "$CYAN [$(toc $START)s]\tJava, Ruby & Python$RESET"

## SSH configuration and bundle
START=$(tic)
#configure plugin ssh-agent to be lazy and have lifetime
if [[ -v SSHADD_TIME ]]; then
    zstyle :omz:plugins:ssh-agent lifetime $SSHADD_TIME
else
    zstyle :omz:plugins:ssh-agent lifetime 1h
fi
zstyle :omz:plugins:ssh-agent lazy yes
antigen bundle ssh-agent
echo "$CYAN [$(toc $START)s]\tSSH with $SSHADD_TIME caching$RESET"

# load local bundles and env-specific bundles
#############################################
FULLOSTYPE=$(uname -a)
#theme
######
#fallback to af-magic if more advanced theme don't work well
#THEME="antigen theme af-magic"
BULLETTRAIN_PROMPT_ORDER=(
  time
  status
  custom
  context
  dir
  git
  cmd_exec_time
)
BULLETTRAIN_PROMPT_CHAR='$ '
THEME="antigen theme caiogondim/bullet-train-oh-my-zsh-theme bullet-train"


#common scripts
echo "$MAGENTA Common$RESET"
START=$(tic)
antigen bundle $DOTFILES/scripts/common/
#the above includes common/private.zsh which is uncommitted
antigen bundle $DOTFILES/install/
echo "$CYAN [$(toc $START)s]$RESET"

START=$(tic)
if (($+BABUN_HOME)) then
  echo "$MAGENTA Babun$RESET"
  #Source babun-specific configurations
  antigen bundle $DOTFILES/scripts/babun/
  #theme
  #On Babun, shell is too slow with powerline themes so fall back to pure
  #THEME="antigen bundle sindresorhus/pure"
  THEME="antigen theme af-magic"
elif contains $FULLOSTYPE "Linux raspbmc"; then
  echo "$MAGENTA Raspbmc$RESET"
  antigen bundle $DOTFILES/scripts/raspbmc/
elif contains $FULLOSTYPE "xbian"; then
  echo "$MAGENTA XBian$RESET"
  antigen bundle $DOTFILES/scripts/raspbmc/
elif contains $FULLOSTYPE "Darwin"; then
  echo "$MAGENTA OSX$RESET"
  antigen bundle brew
  antigen bundle macos
  antigen bundle httpie
  antigen bundle $DOTFILES/scripts/osx/
else
  echo "$YELLOW Other System$RESET"
  echo "Working in $OSTYPE $FULLOSTYPE"
  echo "Please check the PATH : "
  echo $PATH
fi
eval $THEME
# ensure ls colors are solarized
antigen bundle joel-porquet/zsh-dircolors-solarized.git
echo "theme set, you can colorize the console using setupsolarized"
echo "$CYAN [$(toc $START)s]\tScript+Theme$RESET"

# apply antigen to zsh
START=$(tic)
antigen apply
echo "$MAGENTA - TOTAL $(toc $START_ANTIGEN)s$RESET"
echo

# generate help
###############
#append useful aliases from bundles
HELP_DOTFILES+=("gst" "git status" "ggpush" "git push origin currBranch" "gcmsg" "git commit -m" "gi" "generate a gitignore file" "x" "extract from various archive formats")

# Welcome message
#################
echo "Welcome Simon - for a list of useful aliases/functions, type 'help'"
check_antigen
