#!/bin/bash
# See: https://wiki.manjaro.org/index.php?title=Swap

readonly RAM_SIZE=$(/bin/free --giga | grep "Mem" | awk '{print $2}')

swap_size="$((${RAM_SIZE} / 2))G"
swap_path="/swapfile"
while [ "$1" != "" ]; do
    case $1 in
    -p | --path)
        SWAP_PATH="$2"
        shift
        ;;
    -s | --size)
        swap_size="$2G"
        shift
        ;;
    -h | --help)
        echo "Usage: $0 [--path <path>] [--size <size>]"
        echo
        echo "Options:"
        echo "  -p --path       Specify swap file location [default: ${swap_path}]"
        echo "  -s --size       Specify swap file size in Gigabytes [default: half the RAM size]"
        echo "  -h --help       Display this help and exit"
        exit 0
        ;;
    esac
    shift
done

banner "SWAP FILE"

if [ $(/bin/free --giga | grep "Swap" | awk '{print $2}') != 0 ]; then
    readonly EXISTING_SWAP_PATH=$(swapon | grep "file" | awk '{print $1}')
    log "Skip creating swap file <_${swap_path}_> (already exists: ${EXISTING_SWAP_PATH})" ${C_YELLOW}
else
    log "Creating swap file <_${swap_path}_> sized <_${swap_size}_>" ${C_GREEN}
    sudo fallocate -l ${swap_size} ${swap_path}
    sudo mkswap ${swap_path}

    if [ $(stat -c "%a" ${swap_path}) == "600" ]; then
        log "Skip setting permissions for <_${swap_path}_> (already set)" ${C_YELLOW}
    else
        log "Setting permissions for <_${swap_path}_>" ${C_GREEN}
        sudo chmod 600 ${swap_path}
    fi

    if swapon | grep -q "${swap_path}"; then
        log "Skip enabling swap file <_${swap_path}_> (already enabled)" ${C_YELLOW}
    else
        log "Enabling swapfile <_${swap_path}_>" ${C_GREEN}
        sudo swapon ${swap_path}
    fi

    if grep -q "swapfile" /etc/fstab; then
        log "Skip enabling swap <_${swap_path}_> on boot (already enabled)" ${C_YELLOW}
    else
        log "Enabling swap file <_${swap_path}_> on boot" ${C_GREEN}
        sudo bash -c "echo ${swap_path} none swap defaults 0 0 >> /etc/fstab"
    fi
fi
