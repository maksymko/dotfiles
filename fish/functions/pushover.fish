function pushover
    set -l last_status $status

    argparse 's/status' -- $argv

    set -l message $argv
    if set -ql _flag_s
        set message "$message ($last_status)"
    end

    curl $__pushover_base_url \
        -d token=$__pushover_api_token \
        -d user=$__pushover_user_key \
        -d message=$message
end
