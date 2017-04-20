#!/bin/sh

set -e
set -u

setup() {
    dotfiles=$HOME/dotfiles
    targets=(".vim" ".vimrc" ".zshrc" "play-1.2.5.6" "soumu.sh" \
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

    for target in ${targets[@]}; do
      symlink "$dotfiles/$target" "$HOME/$target"
    done

}

setup
