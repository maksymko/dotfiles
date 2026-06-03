if status is-interactive
    # Commands to run in interactive sessions can go here
    if set -q DISPLAY; or set -q WAYLAND_DISPLAY
        set -gx EDITOR 'gvim -f'
    else
        set -gx EDITOR 'vim'
    end
    set -gx GPG_TTY (tty)

    fish_add_path ~/.juliaup/bin
    set -g fish_key_bindings fish_vi_key_bindings
end
