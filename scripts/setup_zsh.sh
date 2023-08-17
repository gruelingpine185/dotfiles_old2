#!/usr/bin/env bash


DIR="${BASH_SOURCE%/*}"
if [[ ! -d "$DIR" ]]; then
    DIR="$PWD";
fi

# Install Oh My Zsh if not alreay done
if ! [[ -x "$(command -v omz)" ]]; then
    echo "Installing Oh My Zsh"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh) --unattended"
fi

if [[ -e "${HOME}/.zshrc" ]]; then
    echo "Overwriting ${HOME}/.zshrc"
    rm "${HOME}/.zshrc"
fi

if [[ -e "${HOME}/.zprofile" ]]; then
    echo "Overwriting ${HOME}/.zprofile"
    rm "${HOME}/.zprofile"
fi

# List of Zsh files that would go in $HOME. These files should not be prefixed
# with '.'.
zsh_home_files="zshrc zprofile"

# Path to Zsh config folder.
zsh_dot_path="$(dirname ${DIR})/zsh"


# Symlink zsh files to ~/
for file in $(ls "$zsh_dot_path"); do
    if [[ ! -e "${zsh_dot_path}/${file}" ]]; then
        echo "Skipped linking for '${zsh_dot_path}/${file}'. No such file" 2>&1 
        continue
    fi

    echo "Linking ${zsh_dot_path}/${file} -> ${HOME}/.${file}"
    ln -s "$(realpath ${zsh_dot_path}/${file})" "${HOME}/.${file}"
done

echo "Done"
