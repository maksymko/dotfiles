#!/bin/zsh

if [ ! -n ${ZSH_CUSTOM+1} ]; then
    echo "Please export ZSH_CUSTOM, then run this script again.";
    exit 1;
fi

SCRIPT=$(realpath $0)
DOT_ROOT=${SCRIPT:h}

link_if_not_exists() {
    local src=$1;
    local dst=$2;

    if [[ ! -e $dst ]]; then
        ln -s $src $dst;
        echo "$src --> $dst ... link created";
    else
        echo "$src --> $dst ... exists, skipping";
    fi
}

restore_dot() {
    local fname=$1;
    link_if_not_exists "${DOT_ROOT}/${fname}" "${HOME}/.${fname}";
}

restore_dot vimrc
restore_dot gvimrc
restore_dot i3

# This requires ZSH_CUSTOM to be exported, which it is not by default
if [[ ! -e $ZSH_CUSTOM/themes/mxsl.zsh-theme ]]; then
    ln -s $DOT_ROOT/mxsl.zsh-theme $ZSH_CUSTOM/themes/mxsl.zsh-theme
fi
