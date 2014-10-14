# aliases for zsh
alias topdirs='du -h | sort -hr | head'
alias topfiles='du -axh . | sort -nr | head'
alias move='rsync -ahP --remove-source-files --progress '

#ls related
alias ls='ls --color'
alias l='ls -lh'
alias ll='ls -la'

#grep-related
alias -g G='| grep'
alias falias='alias | grep'

#gitignore.io gitignore tool
function gi() {
	curl -L -s https://www.gitignore.io/api/$@ ;
}

#nicer presentation of mount
function nicemount() { (echo "DEVICE PATH TYPE FLAGS" && mount | awk '$2="";1') | column -t ; }

#get current dir (only last dir)
function pwdd() {
  result=${PWD##*/}          # to assign to a variable
  #printf '%s\n' "${PWD##*/}" # to print to stdout
                           # ...more robust than echo for unusual names
                           #    (consider a directory named -e or -n
  printf '%q\n' "${PWD##*/}" # to print to stdout, quoted for use as shell input
                           # ...useful to make hidden characters readable.
}


HELP_DOTFILES+=("topdirs" "list biggest dirs in current directory (see also topfiles)")
HELP_DOTFILES+=("move file1 fil2 dest" "rsync move the$YELLOW files$RESET to$CYAN dest$RESET, with a progress bar")
HELP_DOTFILES+=("nicemount" "more readable version of mount list" "falias" "grep the alias list for a specific word" "G" "global alias, pipes a grep")
HELP_DOTFILES+=("pwdd" "shows current directory (not full path), quoted")
