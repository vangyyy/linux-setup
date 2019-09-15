#!/bin/bash

readonly SERVICES=(
    org.cups.cupsd.service docker
)

banner "ENABLE SERVICES"
for service in "${SERVICES[@]}"; do
    if [ "$(systemctl is-enabled ${service})" -o "enabled" ]; then
        log "Skip enabling \e[93m${service}\e[0m (already enabled)"
    else
        log "Enabling service \e[32m${service}\e[0m"
        sudo systemctl ${service}
    fi
done
