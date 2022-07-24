#!/usr/bin/env zsh

CURRENT_DIR=$(pwd)
# SOURCE_DIR=$(dirname "${BASH_SOURCE}")
SOURCE_DIR=`dirname ${BASH_SOURCE[0]-$0}`

# echo $SOURCE_DIR
cd $SOURCE_DIR

# git pull origin main;

function doIt() {
	rsync --exclude ".git/" \
		--exclude ".DS_Store" \
		--exclude ".osx" \
		--exclude "bootstrap.sh" \
		--exclude "README.md" \
		--exclude "LICENSE-MIT.txt" \
		--exclude ".gitignore" \
		-avh --no-perms . ~;
	cd $CURRENT_DIR
	source ~/.zshrc;
	exec -l $SHELL
}

if [ "$1" = "--force" -o "$1" = "-f" ]; then
	doIt;
else
	read "?This may overwrite existing files in your home directory. Are you sure? (y/n) :";
	echo "";
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		doIt;
	fi;
fi;
unset doIt;

cd $CURRENT_DIR