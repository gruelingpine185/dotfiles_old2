#!/usr/bin/env bash

# Install Packer if not already installed
if [[ ! -e "${HOME}/.local/share/nvim/site/pack/packer/start/packer.nvim" ]]; then
    echo "Installing Packer"
    git clone --depth 1 https://github.com/wbthomason/packer.nvim \
        "${HOME}/.local/share/nvim/site/pack/packer/start/packer.nvim"
fi

config_path="${HOME}/.config"


if [[ ! -d "$config_path" ]]; then
    echo "Building ${config_path}"
    mkdir "$config_path"
fi

# Remove neovim config from ~/.config if exists
if [[ -L "${config_path}/nvim" ]]; then
    echo "Overwriting ${config_path}/nvim"
    rm "${config_path}/nvim"
fi

# Create symlink for nvim config
echo "Linking $(dirname ${DIR})/nvim -> ${config_path}/nvim"
ln -s "$(realpath $(dirname ${DIR})/nvim)" "${config_path}/nvim"