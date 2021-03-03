PUSHOVER_BASE_URL=${PUSHOVER_BASE_URL:-https://api.pushover.net/1/messages.json}
PUSHOVER_VERBOSE=${PUSHOVER_VERBOSE:-}
PUSHOVER_CONFIG_FILE=${PUSHOVER_CONFIG_FILE:-$HOME/.pushoverrc}

_do_pushover() {
    local message="$1"
    curl ${PUSHOVER_VERBOSE} $PUSHOVER_BASE_URL \
        -d token=${PUSHOVER_API_TOKEN} \
        -d user=${PUSHOVER_USER_KEY} \
        -d message=${message}
}

_do_pushover_status() {
    local command="$1"

    if $@; then
        pushover "${command} done -- OK"
    else
        local ret_status=$?
        pushover "${command} done -- FAILURE (${ret_status})"
        exit ${ret_status}
    fi
}

alias pushover=false

if [ -z "${PUSHOVER_API_TOKEN}" ] || [ -z "${PUSHOVER_USER_KEY}" ]; then
    # The values configured via zshrc or other means take priority.
    # If the variables are still not configured, try the config file
    if [ -e "$PUSHOVER_CONFIG_FILE" ]; then
        source $PUSHOVER_CONFIG_FILE
    fi
    if [ -z "${PUSHOVER_API_TOKEN}" ] || [ -z "${PUSHOVER_USER_KEY}" ]; then
        # Still not configured, exiting
        echo "Please configure PUSHOVER_API_TOKEN and PUSHOVER_USER_KEY to use the plugin" >&2
        return
    fi
fi

if which curl > /dev/null; then
    alias pushover=_do_pushover
else
    echo "curl not found, pushover plugin is not enabled." >&2
fi

alias pushover_status=_do_pushover_status
