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
