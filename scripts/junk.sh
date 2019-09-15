#!/bin/bash

readonly REMOVE_FILES=(
    $HOME/Templates/ $HOME/Public/
    $HOME/.config/autostart/create-template.desktop
    /usr/share/gnome-shell/extensions/*
)

banner "REMOVING FILES AND DIRECTORIES"
for file in "${REMOVE_FILES[@]}"; do
    if [ -d "${file}" ]; then
        log "Removing file \e[91m${file}\e[0m"
        sudo rm -rf ${file}
    else
        log "Skip removing \e[93m${file}\e[0m (non-existent)"
    fi
done
