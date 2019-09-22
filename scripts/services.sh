#!/bin/bash

readonly SERVICES=(
    org.cups.cupsd.service docker
)

banner "ENABLE SERVICES"
for service in "${SERVICES[@]}"; do
    if [ "$(systemctl is-enabled ${service})" -o "enabled" ]; then
        log "Skip enabling <_${service}_> (already enabled)" ${C_YELLOW}
    else
        log "Enabling service <_${service}_>" ${C_GREEN}
        sudo systemctl ${service}
    fi
done
