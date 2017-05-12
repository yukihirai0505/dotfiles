#!/bin/sh

set -e
set -u

setupDotFiles() {

    dotfiles=$HOME/dotfiles
    neobundle=$dotfiles/targets/.vim/neobundle.vim
    neobundleReadMe=$neobundle/README.md
    targets=$dotfiles/targets/\.*

    has() {
        type "$1" > /dev/null 2>&1
    }

    symlink() {
        [ -e "$2" ] || ln -sf "$1" "$2"
    }

    if [ -d "$dotfiles" ]; then
        (cd "$dotfiles" && git pull)
    else
        git clone https://github.com/yukihirai0505/dotfiles "$dotfiles"
    fi

    if [ ! -e "$neobundleReadMe" ]; then
        git clone https://github.com/Shougo/neobundle.vim "$neobundle"
    fi

    for target in ${targets[@]}; do
      targetName=$(basename $target)
      symlink "$target" "$HOME/$targetName"
    done

}

setupLocalCommands() {

    files=$dotfiles/.local/command/*

    for filepath in $files; do
        commandName=$(basename $filepath)
        if [ ! `which $commandName` ]; then
            ln -si $filepath /usr/local/bin
        fi
    done

}

setupDotFiles
setupLocalCommands
