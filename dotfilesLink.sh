#!/bin/sh

set -e
set -u

setup() {
    dotfiles=$HOME/dotfiles
    neobundle=$dotfiles/.vim/neobundle.vim
    neobundleReadMe=$neobundle/README.md
    targets=(".vim" ".vimrc" ".zshrc" "play-1.2.5.6" \
             ".gitconfig" ".gitignore" ".ctags" ".tmux.conf")

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
      symlink "$dotfiles/$target" "$HOME/$target"
    done

}

setupLocalCommand() {
  files=$dotfiles/.local/*
  for filepath in $files; do
    ln -si $filepath /usr/local/bin
  done
}

setup
setupLocalCommand
