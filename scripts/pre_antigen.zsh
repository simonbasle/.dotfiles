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
