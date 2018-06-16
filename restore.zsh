#!/bin/zsh

SCRIPT=$(realpath $0)
DOT_ROOT=${SCRIPT:h}

if [[ ! -e $HOME/.vimrc ]]; then
    ln -s $DOT_ROOT/vimrc $HOME/.vimrc
fi

if [[ ! -e $HOME/.gvimrc ]]; then
    ln -s $DOT_ROOT/gvimrc $HOME/.gvimrc
fi

if [[ ! -e $HOME/.i3 ]]; then
    ln -s $DOT_ROOT/i3 $HOME/.i3
fi
