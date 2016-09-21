#fixes completion for brew-installed "hub" (github wrapper for git))
fpath=(/usr/local/share/zsh/site-functions $fpath)
#aliases hub to git
alias git=hub