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

# This requires ZSH_CUSTOM to be exported, which it is not by default
if [[ ! -e $ZSH_CUSTOM/themes/mxsl.zsh-theme ]]; then
    ln -s $DOT_ROOT/mxsl.zsh-theme $ZSH_CUSTOM/themes/mxsl.zsh-theme
fi
