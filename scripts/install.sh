#!/usr/bin/env bash


DIR="${BASH_SOURCE%/*}"
if [[ ! -d "$DIR" ]]; then
    DIR="$PWD";
fi


. "${DIR}/setup_homebrew.sh"
. "${DIR}/setup_zsh.sh"
