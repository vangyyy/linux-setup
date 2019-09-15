#!/bin/bash

function log() {
    echo -e "\e[96m[$(date +%T.%3N)]\e[0m $1"
}

function banner() {
    echo -e "\n\e[1m############################################################"
    printf "####  %-48s  ####\n" "$@"
    echo -e "############################################################\e[0m\n"
}

export -f log banner
