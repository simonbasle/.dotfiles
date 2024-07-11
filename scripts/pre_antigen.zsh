#tic functions and other things depends on GNU date
#on OSX we should have them in coreutils package
#make sure OSX uses coreutils date in the path
if [[ "$(uname)" == "Darwin" ]]; then
  export PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH"
  export MANPATH="/opt/homebrew/opt/coreutils/libexec/gnuman:$MANPATH"
fi

#prepare timing functions
# tic()
#
# prints milliseconds since the Epoch, a timestamp (store it in a variable like START=$(tic))
function tic() { echo $(date +%s.%N | cut -b1-14); }

# toc(startTimestamp)
#
# prints difference between now and START (from tic()) as seconds.milliseconds
function toc() {
  START=$1
  END=$(date +%s.%N | cut -b1-14)
  DIFF=$(echo "$END - $START" | bc)
  # DIFF=$((END-START))
  echo $DIFF
}

#prepare prompt color variables
autoload -U colors && colors
for COLOR in RED GREEN YELLOW BLUE MAGENTA CYAN BLACK WHITE; do
    eval $COLOR='$fg_no_bold[${(L)COLOR}]'
    eval BOLD_$COLOR='$fg_bold[${(L)COLOR}]'
done
eval RESET='$reset_color'

# configure hub's completion BEFORE antigen/omz start
if (( ! ${fpath[(I)/usr/local/share/zsh/site-functions]} )); then
  FPATH=/usr/local/share/zsh/site-functions:$FPATH
fi

### BUGFIX:
# OMZ has current regression: https://github.com/ohmyzsh/ohmyzsh/issues/12328#issuecomment-2043492331
# Set async explicitly  to 'no' for now.
zstyle ':omz:alpha:lib:git' async-prompt no