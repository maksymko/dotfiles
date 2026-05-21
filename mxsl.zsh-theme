if (( ${+PROMPT_LOCATION_INFO} )); then
    true
else
    PROMPT_LOCATION_INFO=true
fi

if set | egrep -q DEVENV; then
    env_name=${name}
    ZSH_HOST_INFO="${ZSH_HOST_INFO}[${env_name}] "
fi

if [[ ! -z ${DISTROBOX_HOST_HOME} ]]; then
    ZSH_HOST_INFO="{DB:${CONTAINER_ID}}-${ZSH_HOST_INFO}"
fi

local ret_status_box="%(?:%{$fg_bold[green]%}╭ :%{$fg_bold[red]%}╭ )"
local ret_status_arrow="%(?:%{$fg_bold[green]%}╰⇾ :%{$fg_bold[red]%}╰⇾ )"
PROMPT='${ret_status_box} %{$reset_color%}${ZSH_HOST_INFO}$(${PROMPT_LOCATION_INFO})%{$fg[cyan]%}%3~%{$reset_color%} $(git_prompt_info)
${ret_status_arrow}%{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%}) %{$fg[green]%}✔"

export PROMPT_LOCATION_INFO
