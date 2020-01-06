# contains(string, substring)
#
# Returns 0 if the specified string contains the specified substring,
# otherwise returns 1.
function contains() {
    string="$1"
    substring="$2"
    if test "${string#*$substring}" != "$string"
    then
        return 0    # $substring is in $string
    else
        return 1    # $substring is not in $string
    fi
}

# check_antigen()
#
# print days since last antigen update, warning if > 30
function check_antigen() {
  if [[ -f $ADOTDIR/revert-info ]]; then
    LASTUPDATE=$(cat $ADOTDIR/revert-info | head -n 1)
    DAYSSINCE=$(( ( $(date +'%s') - $(date -d "$LASTUPDATE" +'%s') )/60/60/24 ))
    if [ $DAYSSINCE -gt 30 ]; then
      echo "$BOLD_RED$DAYSSINCE$RESET days since last$YELLOW antigen update && antigen selfupdate$RESET, please update!"
    else
      echo "$CYAN$DAYSSINCE$RESET days since last antigen update"
    fi
  else
    echo "antigen never updated, maybe you should run$YELLOW antigen update && antigen selfupdate$RESET?"
  fi
}

HELP_DOTFILES+=("check_antigen" "checks the date of the last antigen update")

# help()
#
# pretty print each pairs describing useful commands from array $HELP_DOTFILES
function help() {
  echo "Useful aliases/functions:"
  #for every pair in array (command and description), print the command in magenta, pad with dots and print the description
  for k v ("${(@kv)HELP_DOTFILES}"); do
    echo "  $MAGENTA${(r:25::.:: :)${k}}$RESET$v"
  done
}
