#used to source homebrew github access token HOMEBREW_GITHUB_API_TOKEN
#previous committed one was revoked, moved to uncomitted ../common/private.zsh

#iTerm2 utilities with command line integration
# see https://iterm2.com/documentation-utilities.html
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

#workaround on OSX atom not focusing when launched from command line + use it for git editor
function atom() {
	open -a atom && /usr/local/bin/atom $@
}
git config --global core.editor 'open -a atom && atom --wait'
#gh config set editor "atom --wait"