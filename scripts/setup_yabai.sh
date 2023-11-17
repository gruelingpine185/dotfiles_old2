#!/usr/bin/env bash


DIR="${BASH_SOURCE%/*}"
if [[ ! -d "$DIR" ]]; then
    DIR="$PWD";
fi


config_path="${HOME}/.config"


if [[ ! -d "${config_path}/yabai" ]]; then
    echo "Building ${config_path}/yabai"
    mkdir "${config_path}/yabai"
fi

if [[ ! -d "${config_path}/skhd" ]]; then
    echo "Building ${config_path}/skhd"
    mkdir "${config_path}/skhd"
fi

if [[ -e "${config_path}/yabai/yabairc" ]]; then
    echo "Overwriting ${config_path}/yabai/yabairc"
    rm "${config_path}/yabai/yabairc"
fi

if [[ -e "${config_path}/skhd/skhdrc" ]]; then
    echo "Overwriting ${config_path}/skhd/skhdrc"
    rm "${config_path}/skhd/skhdrc"
fi

# Path to yabai config folder.
dot_path="$(dirname ${DIR})/config"

# Symlink yabai files to ~/.config/yabai
if [[ ! -e "${dot_path}/yabai/yabairc" ]]; then
    echo "Skipped linking for '${config_path}/yabai/yabairc'. No such file" 2>&1 
    continue
fi

echo "Linking ${dot_path}/yabai/yabairc -> ${config_path}/yabai/yabairc"
ln -s "$(realpath ${dot_path}/yabai/yabairc)" "${config_path}/yabai/yabairc"


# Symlink yabai files to ~/.config/skhd
if [[ ! -e "${dot_path}/skhd/skhdrc" ]]; then
    echo "Skipped linking for '${dot_path}/skhd/skhdrc'. No such file" 2>&1 
fi

echo "Linking ${dot_path}/skhd/skhdrc -> ${config_path}/skhd/skhdrc"
ln -s "$(realpath ${dot_path}/skhd/skhdrc)" "${config_path}/skhd/skhdrc"
