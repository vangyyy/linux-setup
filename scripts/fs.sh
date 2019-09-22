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
        log "Removing <_${file}_>" ${C_RED}
        sudo rm -rf ${file}
    else
        log "Skip removing <_${file}_> (non-existent)" ${C_YELLOW}
    fi
done

banner "CREATING DIRECTORIES"
for file in "${CREATE[@]}"; do
    if [ -d "${file}" ]; then
        log "Skip creating <_${file}_> (already exists)" ${C_YELLOW}
    else
        log "Creating <_${file}_>" ${C_GREEN}
        mkdir ${file}
    fi
done
