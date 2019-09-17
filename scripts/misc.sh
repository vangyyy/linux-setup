#!/bin/bash

banner "DOCKER SETUP"
# Create docker user group
if ! grep -q "docker" /etc/group; then
    log "Creating \e[32mdocker\e[0m group"
    sudo groupadd docker
else
    log "Skip creating \e[32mdocker\e[0m group"
fi

# Assign current user to docker user group
if ! grep -q "docker:[a-z0-9:]*:[\w,]*${USER}[\w,]*" /etc/group; then
    log "Adding user \e[32m${USER}\e[0m to docker group"
    sudo usermod -aG docker ${USER}
else
    log "Skip adding user \e[32m${USER}\e[0m to docker group"
fi

# Nautilus bookmarks config
file=${HOME}/.config/gtk-3.0/bookmarks
log "Adding \e[32mnautilus\e[0m bookmarks (${file})"
cat >${file} <<EOF
sftp://pi@192.168.1.200/home/pi Pi
file://${HOME}/.icons Icons
file://${HOME}/.fonts Fonts
file://${HOME}/.themes Themes
file://${HOME}/.local/share/gnome-shell/extensions Extensions
file://${HOME}/StudioProjects Android projects
file://${HOME}/Documents
file://${HOME}/Music
file://${HOME}/Pictures
file://${HOME}/Videos
file://${HOME}/Downloads
EOF
