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
        log "Removing existing symlink <_${dest_file}_>" ${C_RED}
        rm ${dest_file}

    elif [ -f "${dest_file}" ]; then
        # Existing file
        log "Backing up existing file <_${dest_file}_>" ${C_GREEN}
        mv ${dest_file}{,.backup}

    elif [ -d "${dest_file}" ]; then
        # Existing dir
        log "Backing up existing dir <_${dest_file}_>" ${C_GREEN}
        mv ${dest_file}{,.backup}
    fi

    log "Creating new symlink <_${dest_file}_>" ${C_GREEN}
    ln -s ${dotfiles_dir}/$1 ${dest_file}
}

for dotfile in $(ls -A ${dotfiles_dir}); do
    linkDotfile ${dotfile}
done
