#sudo-like workaround for windows executables
alias sudow='cygstart --action=runas '

HELP_DOTFILES+=("sudow somecmd" "run windows command$YELLOW somecmd$RESET as administrator")
