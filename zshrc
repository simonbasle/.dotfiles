# configure antigen
ZSHA_BASE=$HOME/.dotfiles
source $ZSHA_BASE/antigen/antigen.zsh

# load oh-my-zsh
antigen use oh-my-zsh

# load various 3rd-party bundles
antigen bundle git
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-history-substring-search
antigen bundle command-not-found

# load custom bundles

# choose a theme
antigen theme ys

# apply antigen to zsh
antigen apply
