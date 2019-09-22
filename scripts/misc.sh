#!/bin/bash

banner "DOCKER SETUP"
# Create docker user group
if ! grep -q "docker" /etc/group; then
    log "Creating <_docker_> group" ${C_GREEN}
    sudo groupadd docker
else
    log "Skip creating <_docker_> group" ${C_YELLOW}
fi

# Assign current user to docker user group
if ! grep -q "docker:[a-z0-9:]*:[\w,]*${USER}[\w,]*" /etc/group; then
    log "Adding user <_${USER}_> to docker group" ${C_GREEN}
    sudo usermod -aG docker ${USER}
else
    log "Skip adding user <_${USER}_> to docker group" ${C_YELLOW}
fi

# Nautilus bookmarks config
file=${HOME}/.config/gtk-3.0/bookmarks
log "Adding <_Nautilus_> bookmarks (${file})" ${C_GREEN}
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
