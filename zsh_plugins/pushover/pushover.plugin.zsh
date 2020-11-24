PUSHOVER_BASE_URL=${PUSHOVER_BASE_URL:-https://api.pushover.net/1/messages.json}
PUSHOVER_VERBOSE=${PUSHOVER_VERBOSE:-}

_do_pushover() {
    local message="$1"
    curl ${PUSHOVER_VERBOSE} $PUSHOVER_BASE_URL \
        -d token=$PUSHOVER_API_TOKEN \
        -d user=${PUSHOVER_USER_KEY} \
        -d message=${message}
}

alias pushover=false

if which curl > /dev/null; then
    alias pushover=_do_pushover
else
    echo "curl not found, pushover plugin is not enabled." > 2
fi
