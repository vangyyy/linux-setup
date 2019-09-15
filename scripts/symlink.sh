#!/bin/bash
# Credit: tomnomnom -> https://github.com/tomnomnom/dotfiles/blob/master/setup.sh

if [ "${DIR}" = "" ]; then
    echo "This script can't be run directly!"
    exit 1
fi

banner "DOTFILES"

dotfiles_dir="${DIR}/dotfiles"
function linkDotfile() {
    local dest_file="${HOME}/$1"

    if [ -h ${HOME}/$1 ]; then
        # Existing symlink
        log "Removing existing symlink \e[91m${dest_file}\e[0m"
        rm ${dest_file}

    elif [ -f "${dest_file}" ]; then
        # Existing file
        log "Backing up existing file \e[32m${dest_file}\e[0m"
        mv ${dest_file}{,.backup}

    elif [ -d "${dest_file}" ]; then
        # Existing dir
        log "Backing up existing dir \e[32m${dest_file}\e[0m"
        mv ${dest_file}{,.backup}
    fi

    log "Creating new symlink \e[32m${dest_file}\e[0m"
    ln -s ${dotfiles_dir}/$1 ${dest_file}
}

for dotfile in $(ls -A ${dotfiles_dir}); do
    linkDotfile ${dotfile}
done
