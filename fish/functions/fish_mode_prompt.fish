function fish_mode_prompt
    set -l last_status $status

    set -l status_color green
    if test $last_status -ne 0
        set status_color red
    end

    echo -n (set_color $status_color)'╭ '(set_color normal)
    fish_default_mode_prompt
end
