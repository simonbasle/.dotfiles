# aliases for zsh
alias topdirs='du -h | sort -hr | head'
alias topfiles='du -axh . | sort -nr | head'
alias move='rsync -ahP --remove-source-files --progress --'

#ls related
alias ls='ls --color'
alias l='ls -lh'
alias ll='ls -la'

#grep-related
alias -g G='| grep'
alias falias='alias | grep '

#nicer presentation of mount
function nicemount() { (echo "DEVICE PATH TYPE FLAGS" && mount | awk '$2="";1') | column -t ; }

export HELP_DOTFILES="$HELP_DOTFILES\ntopdirs and topfiles - list biggest dirs/files in current directory\nmove - rsync move the files, with a progress bar"
export HELP_DOTFILES="$HELP_DOTFILES\nnicemount - more readable version of mount list\nfalias - grep the alias list for a specific word\nG - global alias, pipes a grep"
