#used to source homebrew github access token HOMEBREW_GITHUB_API_TOKEN
#previous committed one was revoked, moved to uncomitted ../common/private.zsh

#iTerm2 utilities with command line integration
# see https://iterm2.com/documentation-utilities.html
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

#broot
source /Users/sbasle/.config/broot/launcher/bash/br
alias tree=br

function sshadd() {
    for x in ${=SSHADD_IDS} ; do
        ssh-add "$HOME/.ssh/$x" -t $SSHADD_TIME
    done
}

git config --global core.editor 'codium --wait'

HELP_DOTFILES+=("tree or br " "$YELLOW broot$RESET is set up to replace tree command")
HELP_DOTFILES+=("sshadd " "$YELLOW SSHIDS$RESET are added to agent for $SSHADD_TIME")
HELP_DOTFILES+=("codium " "$YELLOW vscodium$RESET is set up as git editor")