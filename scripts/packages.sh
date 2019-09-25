#!/bin/bash

readonly REMOVE_PACKAGES=(
    manjaro-gnome-assets arc-maia-icon-theme matcha-gtk-theme papirus-icon-theme yaru-gtk-theme
    manjaro-hello hexchat appimagelauncher epiphany networkmanager-openconnect mhwd-tui yelp
    gtkhash imagewriter totem qt4 bauh gnome-characters gnome-calendar gnome-clocks gnome-contacts
    gnome-system-log gnome-todo gnome-maps gnome-notes gnome-weather empathy evolution lollypop
    steam-manjaro transmission-gtk uget gufw
)

readonly INSTALL_PACKAGES=(
    git adb vim unrar chrome-gnome-shell gedit-plugins openssh deluge gimp inkscape rhythmbox
    simple-scan vlc vinagre jdk intellij-idea-ultimate-edition android-studio webstorm phpstorm
    visual-studio-code-bin postman google-chrome etcher spotify gpmdp virtualbox slack-desktop
    teamviewer synergy ttf-roboto ttf-roboto-mono noto-fonts manjaro-printer net-tools svgo
    bash-completion docker docker-compose npm nodejs
    texlive-bibtexextra texlive-core texlive-fontsextra texlive-formatsextra texlive-humanities
    texlive-langextra texlive-latexextra texlive-music texlive-pictures texlive-pstricks
    texlive-publishers texlive-science biber
)

banner "INSTALLING YAY"
if ! [ -x "$(command -v yay)" ]; then
    log "Installing <_Yay_>" ${C_GREEN}
    sudo pacman -S base-devel --noconfirm
    git clone https://aur.archlinux.org/yay.git /tmp/yay
    cd /tmp/yay
    makepkg -si --noconfirm
    cd -
else
    log "Skip installing <_Yay_> (already installed)" ${C_YELLOW}
fi

banner "UPDATE PACKAGES"
# yay -Syyu --noconfirm

banner "REMOVING PACKAGES"
for pkg in "${REMOVE_PACKAGES[@]}"; do
    if yay -Qi ${pkg} &>/dev/null; then
        log "Removing <_${pkg}_>" ${C_RED}
        yay -Rsc ${pkg} --noconfirm
    else
        log "Skip removing <_${pkg}_> (not installed)" ${C_YELLOW}
    fi
done

banner "INSTALLING PACKAGES"
for pkg in "${INSTALL_PACKAGES[@]}"; do
    if yay -Qi ${pkg} &>/dev/null; then
        log "Skip installing <_${pkg}_> (already installed)" ${C_YELLOW}
    else
        log "Installing <_${pkg}_>" ${C_GREEN}
        yay -S ${pkg} --noconfirm
    fi
done
