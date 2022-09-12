#!/bin/zsh

if [[ -z "$ZSH_CUSTOM" ]]; then
    echo "Please export ZSH_CUSTOM, then run this script again.";
    exit 1;
fi

SCRIPT=${0:a}
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
restore_dot zshrc
restore_dot zsh_aliases

# This requires ZSH_CUSTOM to be exported, which it is not by default
if [[ ! -e $ZSH_CUSTOM/themes/mxsl.zsh-theme ]]; then
    ln -s $DOT_ROOT/mxsl.zsh-theme $ZSH_CUSTOM/themes/mxsl.zsh-theme
fi

# Restore zsh plugins. Note, these are copied!
for pd in zsh_plugins/*; do
    echo "Installing zsh plugin <${pd#**/}>"
    plugin_dir="$ZSH_CUSTOM/plugins/${pd#**/}"
    mkdir -p "$plugin_dir"
    for f in ${pd}/*; do
        cp -f $f "$plugin_dir"
    done
done
