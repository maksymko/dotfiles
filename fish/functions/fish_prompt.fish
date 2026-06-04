function fish_prompt
    set -l last_status $status

    # Shorten path: show ~ and abbreviate dirs to 1 char
    set -l cwd (prompt_pwd -d3 -D2)
    set -l fstype (findmnt -T $PWD -no FSTYPE)

    set -l git_prompt ''

    if not string match -q 'fuse*' $fstype
        set -gx __fish_git_prompt_showdirtystate 1
        set -gx __fish_git_prompt_showuntrackedfiles 0
        set -gx __fish_git_prompt_showcolorhints 1
        set -gx __fish_git_prompt_color_cleanstate green
        set -gx __fish_git_prompt_showupstream auto
        set git_prompt (fish_git_prompt "(%s)")
    else
        set git_prompt 'FUSE'
    end

    set -l status_color green
    if test $last_status -ne 0
        set status_color red
    end

    set -l host_information ''
    if set -q DEVENV_ROOT
        set -l devenv_name (path basename $DEVENV_ROOT)
        set host_information (set_color brblue)"(devenv:"(set_color normal)"$devenv_name"(set_color brblue)") "(set_color normal)
    end

    if set -q SSH_CLIENT
        set host_information "$host_information ($USER@"(hostname)") "
    end

    # First line
    if not test "$fish_key_bindings" = fish_vi_key_bindings
        echo -n (set_color $status_color)'╭ '(set_color normal)
    end
    echo -n $host_information
    echo -n (set_color cyan)$cwd(set_color normal)

    if not test -z $git_prompt
        echo -n (set_color brblue)" git:$git_prompt"(set_color normal)
    end

    if test $last_status -ne 0
        echo -n ' '
        echo -n (set_color red)"[$last_status]"(set_color normal)
    end

    echo

    # Second line
    echo -n (set_color $status_color)'╰⇾ '(set_color normal)
end
