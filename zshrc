#prepare timing functions
function tic() { echo $(date +%s.%N | cut -b1-14); }
function toc() {
  START=$1
  END=$(date +%s.%N | cut -b1-14)
  DIFF=$(echo "$END - $START" | bc)
  # DIFF=$((END-START))
  echo $DIFF
}
START_ANTIGEN=$(tic)

#prepare prompt color variables
autoload -U colors && colors
for COLOR in RED GREEN YELLOW BLUE MAGENTA CYAN BLACK WHITE; do
    eval $COLOR='$fg_no_bold[${(L)COLOR}]'
    eval BOLD_$COLOR='$fg_bold[${(L)COLOR}]'
done
eval RESET='$reset_color'

# configure antigen
DOTFILES=$HOME/.dotfiles
source $DOTFILES/antigen/antigen.zsh

#ensure correct terminal configuration
export LANG=en_US.UTF-8
export TERM=xterm-256color

# load oh-my-zsh
START=$(tic)
antigen use oh-my-zsh
echo "$CYAN Oh-My-Zsh loaded in $(toc $START)s$RESET"

# Bundles
#########
##CLI
START=$(tic)
# syntax coloration
antigen bundle zsh-users/zsh-syntax-highlighting

# search command history for prefixed commands
antigen bundle zsh-users/zsh-history-substring-search

# locate the package in which to find an unknown command (via /etc/zsh_command_not_found)
antigen bundle command-not-found

# cat with syntax highlight (need python's Pygments)
antigen bundle colorize

# adds color to man pages
antigen bundle colored-man
echo "$CYAN cli bundles loaded in $(toc $START)s$RESET"

##GIT
START=$(tic)
#git related bundles
antigen bundle git
antigen bundle github
# gitignore generation using gi via www.gitignore.io
antigen bundle gitignore
echo "$CYAN git bundles loaded in $(toc $START)s$RESET"

##UTILITIES
START=$(tic)
# # simply extract archives with x
antigen bundle extract
echo "$CYAN utility bundles loaded in $(toc $START)s$RESET"

##BUILD AND DEV TOOLS
START=$(tic)
antigen bundle ant
antigen bundle mvn
antigen bundle gradle
antigen bundle docker
antigen bundle heroku
antigen bundle vagrant
echo "$CYAN build and dev tools loaded in $(toc $START)s$RESET"

# load local bundles and env-specific bundles
#############################################
FULLOSTYPE=$(uname -a)
START=$(tic)
set -A HELP_DOTFILES
#theme
######
#fallback to af-magic if more advanced theme don't work well
#THEME="antigen theme af-magic"
THEME="antigen theme caiogondim/bullet-train-oh-my-zsh-theme bullet-train"
#common scripts
echo "Working in $OSTYPE $FULLOSTYPE"
antigen bundle $DOTFILES/scripts/common
if (($+BABUN_HOME)) then
  echo "Babun"
  #Source babun-specific configurations
  antigen bundle $DOTFILES/scripts/babun
  #theme
  #On Babun, shell is too slow with powerline themes so fall back to pure
  THEME="antigen bundle sindresorhus/pure"
elif [[ FULLOSTYPE =~ "Linux raspbmc" ]] then
  echo "Raspbmc"
  source /etc/profile
  # antigen theme caiogondim/bullet-train-oh-my-zsh-theme bullet-train
else
  echo "Other System, please check the PATH : "
  echo $PATH
fi
echo "applying theme using $THEME"
eval $THEME
echo "$CYAN Local Bundles And Theme Loaded in $(toc $START)s$RESET"

# apply antigen to zsh
antigen apply
echo "Antigen Done in TOTAL  $(toc $START_ANTIGEN)s"
echo

# generate help
###############
#append useful aliases from bundles
HELP_DOTFILES+=("gst" "git status" "ggpush" "git push origin currBranch" "gcmsg" "git commit -m" "gi" "generate a gitignore file" "x" "extract from various archive formats")
function help() {
  echo "Useful aliases/functions:"
  #for every pair in array (command and description), print the command in magenta, pad with dots and print the description
  for k v ("${(@kv)HELP_DOTFILES}"); do
    echo "  $MAGENTA${(r:10::.:: :)${k}}$RESET$v"
  done
}

# Welcome message
#################
echo "Welcome Simon - for a list of useful aliases/functions, type 'help'"
if [[ -f $ADOTDIR/revert-info ]]; then
    echo "last antigen update :"
    cat $ADOTDIR/revert-info | head -n 1
fi
