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

#nicer presentation of mount
function nicemount() { (echo "DEVICE PATH TYPE FLAGS" && mount | awk '$2="";1') | column -t ; }

HELP_DOTFILES+=("topdirs" "list biggest dirs in current directory (see also topfiles)" "move" "rsync move the files, with a progress bar")
HELP_DOTFILES+=("nicemount" "more readable version of mount list" "falias" "grep the alias list for a specific word" "G" "global alias, pipes a grep")
