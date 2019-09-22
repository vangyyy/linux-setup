#!/bin/bash

export readonly C_CYAN="\e[96m"
export readonly C_GREEN="\e[32m"
export readonly C_RED="\e[91m"
export readonly C_YELLOW="\e[93m"
export readonly C_BOLD="\e[1m"
export readonly C_RESET="\e[0m"

# Prepends string with timestamp and prints it out
# $1 - String to timestamp
function timestamp() {
    echo -e "${C_CYAN}[$(date +%T.%3N)]${C_RESET} $1"
}

# Prints timestamped message and highlights parts surrounded in "<_color_>"
# $1 - String to log
# $2 - Highlight color
function log() {
    timestamp "$(sed "s/<_/\\$2/g" <<<"$1" | sed "s/_>/\\${C_RESET}/g")"
}

# Prints visible divider with attached string
# $1 - Banner Message
function banner() {
    echo -e "${C_BOLD}"
    echo -e "############################################################"
    printf "####  %-48s  ####\n" "$@"
    echo -e "############################################################"
    echo -e "${C_RESET}"
}

export -f timestamp log banner
