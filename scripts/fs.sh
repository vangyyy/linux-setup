#!/bin/bash

readonly REMOVE=(
    ${HOME}/Templates/
    ${HOME}/Public/
    ${HOME}/.config/autostart/create-template.desktop
    /usr/share/gnome-shell/extensions/*
)

readonly CREATE=(
    ${HOME}/.icons
    ${HOME}/.themes
    ${HOME}/.fonts
    ${HOME}/Pictures/Wallpapers
    ${HOME}/StudioProjects
)

banner "REMOVING FILES AND DIRECTORIES"
for file in "${REMOVE[@]}"; do
    if [ -d "${file}" ]; then
        log "Removing \e[91m${file}\e[0m"
        sudo rm -rf ${file}
    else
        log "Skip removing \e[93m${file}\e[0m (non-existent)"
    fi
done

banner "CREATING DIRECTORIES"
for file in "${CREATE[@]}"; do
    if [ -d "${file}" ]; then
        log "Skip creating \e[93m${file}\e[0m (already exists)"
    else
        log "Creating \e[93m${file}\e[0m"
        mkdir ${file}
    fi
done
