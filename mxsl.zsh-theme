local ret_status_box="%(?:%{$fg_bold[green]%}╭ :%{$fg_bold[red]%}╭ )"
local ret_status_arrow="%(?:%{$fg_bold[green]%}╰⇾ :%{$fg_bold[red]%}╰⇾ )"
PROMPT='${ret_status_box} %{$fg[cyan]%}%3~%{$reset_color%} $(git_prompt_info)
${ret_status_arrow}%{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%}) %{$fg[green]%}✔"