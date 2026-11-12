function _puffer_fish_expand_bang
    set my_version $(echo $version | cut -d. -f1)

    set -l search_field
    if test $my_version -ge 4
        if commandline --search-field >/dev/null
            set search_field 1
        end
    end

    if [ $search_field ]
        commandline --search-field --insert '!'
    else if string match --quiet -- '!' "$(commandline --current-token)"
        commandline --current-token $history[1]
    else
        commandline --insert '!'
    end
end

