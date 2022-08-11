#used to source homebrew github access token HOMEBREW_GITHUB_API_TOKEN
#previous committed one was revoked, moved to uncomitted ../common/private.zsh

#iTerm2 utilities with command line integration
# see https://iterm2.com/documentation-utilities.html
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

#broot
source /Users/sbasle/.config/broot/launcher/bash/br

git config --global core.editor 'codium --wait'

alias tree=br