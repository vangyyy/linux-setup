#!/bin/bash

export readonly DIR=$(dirname $(realpath $0))

source ${DIR}/lib/logging.sh

while [ "$1" != "" ]; do
    case $1 in
    -l | --laptop)
        laptop=true
        shift
        ;;
    -h | --help)
        echo "Usage: $0 [--laptop]"
        echo
        echo "Options:"
        echo "  -l --laptop       Also executes setup script for 1st Generation Lenovo X1 Yoga"
        echo "  -h --help         Display this help and exit"
        exit 0
        ;;
    esac
    shift
done

${DIR}/scripts/swap.sh
${DIR}/scripts/symlink.sh
${DIR}/scripts/junk.sh
${DIR}/scripts/packages.sh
${DIR}/scripts/services.sh
${DIR}/scripts/shortcuts.sh
${DIR}/scripts/desktop.sh
${DIR}/scripts/misc.sh

if [ "${laptop}" == true ]; then
    ${DIR}/scripts/laptop.sh
fi
