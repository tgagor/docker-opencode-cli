#!/usr/bin/env bash

set -eu

USER_UID=${DEFAULT_UID:-1000}
GROUP_GID=${DEFAULT_GID:-1000}
USER=${DEFAULT_USERNAME:-opencode}
HOME=${DEFAULT_HOME_DIR:-/home/$USER}

if [ "$DEBUG" == "true" ]; then
    echo "Creating unprivileged user matching system user..."
    echo "  Name:     $USER"
    echo "  UID:      $USER_UID"
    echo "  GID:      $GROUP_GID"
    echo "  Home dir: $HOME"
fi

# create group if it doesn't exist
getent group $GROUP_GID >/dev/null 2>&1 || groupadd -g $GROUP_GID $USER

# create user if it doesn't exist
# assign to existing group at GID if available, otherwise use $USER as group name
getent passwd $USER_UID >/dev/null 2>&1 || {
    GROUP_NAME=$(getent group "$GROUP_GID" | cut -d: -f1) || GROUP_NAME="$USER"
    useradd -u $USER_UID -g "$GROUP_NAME" -d "$HOME" -s /bin/bash -m $USER
}

exec gosu "${USER_UID}:${GROUP_GID}" "$@"
