#!/bin/zsh

# dotinstall scriptname [where]
#
# attempt to run a custom install.zsh script found in subdirectory "scriptname"
function dotinstall() {
	echo "Attempting to install $1"
	WHERE=$PWD
	FROM=$DOTFILES/install/$1
	if [[ -x "$FROM/install.zsh" ]]; then
		source "$FROM/install.zsh" "$FROM" "$WHERE"
	else
		echo "no $FROM directory or directory does not contain an executable install.zsh"
	fi
	#cleanup
	unset WHERE
	unset FROM
}

HELP_DOTFILES+=("dotinstall package" "attempt to run a custom install.zsh script found in subdirectory$YELLOW package$RESET")
