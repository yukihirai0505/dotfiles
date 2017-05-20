#!/bin/sh

set -e
set -u

BOLD=$(tput bold)
BLUE=$(tput setaf 4)
NORMAL=$(tput sgr0)

printReport() {

    printf "${BLUE}==>${NORMAL} ${BOLD}${1}${NORMAL}\n"

}

setupDotFiles() {

    printReport "Start setupDotFiles"

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

    printReport "Finish setupDotFiles"

}

setupLocalCommands() {

    printReport "Start setupLocalCommands"

    files=$dotfiles/.local/command/*

    for filepath in $files; do
        commandName=$(basename $filepath)
        if [ ! `which $commandName` ]; then
            ln -si $filepath /usr/local/bin
        fi
    done

    printReport "Finish setupLocalCommands"

}

setUpSources() {

    printReport "Start setUpSources"

    sourceDir=$dotfiles/source
    files=$sourceDir/*

    for filepath in $files; do
        if [ -f $filepath ]; then
            if [ `echo $filepath | grep '\.zip'` ] ; then
                if [ ! -d `echo $filepath | sed -e "s/\.zip//"` ] ; then
                    unzip $filepath -d $sourceDir/
                fi
            fi
            if [ `echo $filepath | grep '\-bin\.tar\.gz'` ] ; then
                if [ ! -d `echo $filepath | sed -e "s/-bin\.tar\.gz//"` ] ; then
                    tar vxf $filepath -C $sourceDir/
                fi
            fi
        fi
    done

    printReport "Finish setUpSources"

}

setupDotFiles
setupLocalCommands
setUpSources
