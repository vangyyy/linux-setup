#!/bin/bash

readonly REMOVE_PACKAGES=(
    manjaro-gdm-theme manjaro-gnome-assets matcha-gtk-theme papirus-icon-theme yaru-gtk-theme
    manjaro-hello hexchat appimagelauncher epiphany networkmanager-openconnect mhwd-tui yelp
    gtkhash imagewriter totem qt4
)

readonly INSTALL_PACKAGES=(
    git adb vim unrar chrome-gnome-shell gedit-plugins openssh deluge gimp inkscape rhythmbox vlc
    vinagre jdk intellij-idea-ultimate-edition android-studio webstorm phpstorm visual-studio-code-bin
    postman google-chrome etcher spotify gpmdp virtualbox slack-desktop teamviewer synergy
    ttf-roboto ttf-roboto-mono noto-fonts manjaro-printer net-tools svgo bash-completion
    docker docker-compose npm nodejs #TODO:texlive-full
)

banner "UPDATE PACKAGES"
yay -Syyu --noconfirm

banner "REMOVING PACKAGES"
for pkg in "${REMOVE_PACKAGES[@]}"; do
    if yay -Qi ${pkg} &>/dev/null; then
        log "Removing \e[91m${pkg}\e[0m"
        yay -Rsc ${pkg} --noconfirm
    else
        log "Skip removing \e[93m${pkg}\e[0m (not installed)"
    fi
done

banner "INSTALLING PACKAGES"
for pkg in "${INSTALL_PACKAGES[@]}"; do
    if yay -Qi ${pkg} &>/dev/null; then
        log "Skip installing \e[93m${pkg}\e[0m (already installed)"
    else
        log "Installing \e[32m${pkg}\e[0m"
        yay -S ${pkg} --noconfirm
    fi
done
