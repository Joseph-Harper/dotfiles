#!/bin/bash

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUPDIR=~/dotfiles_backup
FILES="bashrc vimrc alias gitconfig inputrc profile"    # list of files/folders to symlink in homedir

# create dotfiles_backup in homedir
echo "Creating $BACKUPDIR for backup of any existing dotfiles in ~"
mkdir -p $BACKUPDIR
echo "...done"

# change to the dotfiles directory
echo "Changing to the $BASEDIR directory"
cd $BASEDIR
echo "...done"

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks
for file in $FILES; do
	echo "Moving any existing dotfiles from ~ to $BACKUPDIR"
	mv ~/.$file ~/dotfiles_backup
	echo "Creating symlink to $file in home directory."
	ln -s $BASEDIR/$file ~/.$file
done

# Clone gruvbox if it doesn't exist
if [ ! -d ~/.vim/pack/default/start/gruvbox ]; then
	echo "Cloning https://github.com/morhetz/gruvbox.git..."
	git clone https://github.com/morhetz/gruvbox.git ~/.vim/pack/default/start/gruvbox
fi
