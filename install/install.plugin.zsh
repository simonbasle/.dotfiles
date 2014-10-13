#!/bin/zsh

function dotinstall() {
	echo "Attempting to install $1"
	WHERE=$PWD
	FROM=$DOTFILES/install/$1
	if [[ -d "$FROM" -a -x "$FROM/install.zsh" ]]; then
		source "$FROM/install.zsh" "$FROM" "$WHERE"
	else
		echo "no $FROM directory or directory does not contain an executable install.zsh"
	fi
	#cleanup
	unset WHERE
	unset FROM
}
