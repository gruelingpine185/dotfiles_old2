#!/usr/bin/env bash


DIR="${BASH_SOURCE%/*}"
if [[ ! -d "$DIR" ]]; then
    DIR="$PWD";
fi

# Remove lldb config if exists
if [[ -L "${HOME}/.lldbinit" ]]; then
    echo "Overwriting ${HOME}/.lldbinit"
    rm "${HOME}/.lldbinit"
fi

# Create symlink for nvim config
echo "Linking $(dirname ${DIR})/lldb/lldbinit -> ${HOME}/.lldbinit"
ln -s "$(realpath $(dirname ${DIR})/lldb/lldbinit)" "${HOME}/.lldbinit"

