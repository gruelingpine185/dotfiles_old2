#!/usr/bin/env bash


DIR="${BASH_SOURCE%/*}"
if [[ ! -d "$DIR" ]]; then
    DIR="$PWD";
fi

# Install Homebrew if it doesn't exist
if ! [[ -x "$(command -v brew)" ]]; then
    echo "Installing Homebrew"
    NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> "$(dirname ${DIR})/zsh/zprofile"
    eval "$(${HOMEBREW_PREFIX}/bin brew shellenv)"
fi


config_path="${HOME}/.config"
# Path to homebrew config files
dot_brew_path="$(dirname ${DIR})/brewfile"

# Remove global Brewfile if already exists
if [[ -e "${config_path}/brewfile/Brewfile" ]]; then
   echo "Overwriting  ${config_path}/brewfile/Brewfile"
   rm "${config_path}/brewfile/Brewfile"
fi

# Creates path for Brefile config
if [[ ! -d "${config_path}/brewfile" ]]; then
    mkdir -p "${config_path}/brewfile"
fi

# Creates a symlinks
echo "Linking ${dot_brew_path}/Brewfile -> ${config_path}/brewfile/Brewfile"
ln -s "$(realpath ${dot_brew_path}/Brewfile)" "${config_path}/brewfile/Brewfile"
echo "Done"
