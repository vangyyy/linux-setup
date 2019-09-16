#!/bin/bash

if [ "${DIR}" = "" ]; then
    echo "This script can't be run directly!"
    exit 1
fi

declare -A EXTENSIONS
readonly EXTENSIONS=(
    [0019]="User Themes"
    [0118]="No Topleft Hot Corner"
    [0307]="Dash to Dock"
    [0355]="Status Area Horizontal Spacing"
    [0800]="Remove Dropdown Arrows"
    # [1011]="Dynamic Panel Transparency"
    [1128]="Hide Activities Button"
    [1217]="Appfolders Management"
)

banner "GNOME EXTENSIONS"
readonly SCRIPT_NAME="gnomeshell-extension-manage"
if command -v ${SCRIPT_NAME} >/dev/null; then
    log "Skip cloning \e[93m${SCRIPT_NAME}\e[0m script (already exists)"
else
    log "Cloning \e[32m${SCRIPT_NAME}\e[0m script"
    readonly SCRIPT_URL="https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/ubuntugnome/gnomeshell-extension-manage"
    sudo wget -O /usr/local/bin/${SCRIPT_NAME} ${SCRIPT_URL}
    sudo chmod +x /usr/local/bin/${SCRIPT_NAME}
fi
for id in "${!EXTENSIONS[@]}"; do
    log "Installing \e[32m${EXTENSIONS[$id]}\e[0m (id: ${id})"
    gnomeshell-extension-manage --install --extension-id ${id} --user --version latest
done

banner "WALLPAPER, GTK THEME, ICON PACK"
readonly WALLPAPER_NAME="pawel-czerwinski-unsplash.jpg"
if [ -f ${HOME}/Pictures/Wallpapers/${WALLPAPER_NAME} ]; then
    log "Skip copying \e[93m${WALLPAPER_NAME}\e[0m (already exists: ${HOME}/Pictures/Wallpapers/${WALLPAPER_NAME})"
else
    log "Copying \e[32m${WALLPAPER_NAME}\e[0m (${DIR}/${WALLPAPER_NAME})"
    cp ${DIR}/wallpaper/${WALLPAPER_NAME} ${HOME}/Pictures/Wallpapers
fi

readonly THEME_NAME='Ant-Bloody'
readonly THEME_PATH=${HOME}/.themes/${THEME_NAME}
if [ -d ${HOME}/.themes/${THEME_NAME} ]; then
    log "Skip getting \e[93m${THEME_NAME}\e[0m (already exists: ${THEME_PATH})"
else
    log "Getting \e[32m${THEME_NAME}\e[0m"
    readonly ARCHIVE1='Ant.tar'
    readonly ARCHIVE2='Ant-Bloody-slim-standard-buttons.tar'
    wget -q --show-progress https://github.com/EliverLara/Ant-Bloody/releases/latest/download/Ant-Bloody-slim.tar.xz -O /tmp/${ARCHIVE1}
    log "Unpacking \e[32m${THEME_NAME}\e[0m (${THEME_PATH})"
    tar -xvf /tmp/${ARCHIVE1} -C /tmp/ ${ARCHIVE2} >/dev/null
    tar -xvf /tmp/${ARCHIVE2} -C ${HOME}/.themes >/dev/null
fi

readonly ICON_PACK_DIR_NAME="papirus-icon-theme"
readonly ICON_PACK_REPO_PATH="${HOME}/bin/${ICON_PACK_DIR_NAME}"
if [ -d ${ICON_PACK_REPO_PATH} ]; then
    log "Skip cloning \e[93m${ICON_PACK_DIR_NAME}\e[0m (already exists: ${ICON_PACK_REPO_PATH})"
else
    log "Cloning \e[32m${ICON_PACK_DIR_NAME}\e[0m (${ICON_PACK_REPO_PATH})"
    git clone https://github.com/vangyyy/papirus-icon-theme.git ${ICON_PACK_REPO_PATH}
fi
readonly ICON_PACK_NAME="Papirus"
readonly ICON_PACK_BUILD_PATH="${HOME}/.icons/${ICON_PACK_NAME}"
if [ -d ${ICON_PACK_BUILD_PATH} ]; then
    log "Skip building \e[93m${ICON_PACK_NAME}\e[0m (already build: ${ICON_PACK_BUILD_PATH})"
else
    log "Building \e[32m${ICON_PACK_NAME}\e[0m (${ICON_PACK_BUILD_PATH})"
    ${ICON_PACK_BUILD_PATH}/my_install.sh
fi

function gset() {
    case "$1" in
    --schemadir)
        log "Setting $3 \e[32m$4\e[0m ($5)"
        gsettings $1 $2 set $3 $4 "$5"
        ;;
    *)
        log "Setting $1 \e[32m$2\e[0m ($3)"
        gsettings set $1 $2 "$3"
        ;;
    esac
}

banner "GNOME SETTINGS"
gset org.gnome.desktop.interface clock-format 24h
gset org.gnome.desktop.interface clock-show-date true
gset org.gnome.desktop.interface clock-show-weekday true
gset org.gnome.desktop.interface clock-show-seconds true
gset org.gnome.desktop.interface show-battery-percentage true
gset org.gnome.desktop.interface font-name 'Roboto Medium 12'
gset org.gnome.desktop.interface document-font-name 'Roboto Medium 12'
gset org.gnome.desktop.interface monospace-font-name 'Roboto Mono Medium 12'
gset org.gnome.desktop.interface gtk-theme 'Ant-Bloody'
gset org.gnome.desktop.interface cursor-theme 'Adwaita'
gset org.gnome.desktop.interface icon-theme 'Papirus'
gset org.gnome.desktop.peripherals.touchpad tap-to-click true
gset org.gnome.desktop.peripherals.touchpad click-method 'fingers'
gset org.gnome.desktop.background picture-uri 'file:///home/rastik/Pictures/Wallpapers/'${WALLPAPER_NAME}
gset org.gnome.desktop.screensaver picture-uri 'file:///home/rastik/Pictures/Wallpapers/'${WALLPAPER_NAME}
gset org.gnome.desktop.wm.preferences button-layout "close,minimize,maximize:"
gset org.gnome.desktop.wm.keybindings show-desktop "['<Super>d']"
gset org.gnome.desktop.wm.keybindings switch-input-source "['<Alt>Shift_R']"
gset org.gnome.desktop.wm.keybindings switch-input-source-backward "['<Alt>Shift_L']"
gset org.gnome.desktop.input-sources sources "[('xkb', 'us'), ('xkb', 'sk+qwerty')]"
gset org.gnome.desktop.session idle-delay 'uint32 0'
gset org.gnome.settings-daemon.peripherals.touchscreen orientation-lock true
gset org.gnome.settings-daemon.peripherals.mouse locate-pointer true
gset org.gnome.settings-daemon.plugins.color night-light-enabled true
gset org.gnome.settings-daemon.plugins.color night-light-temperature 5500
gset org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type 'nothing'
gset org.gnome.settings-daemon.plugins.power sleep-inactive-battery-type 'nothing'
gset org.gnome.settings-daemon.plugins.power ambient-enabled false
gset org.gnome.settings-daemon.plugins.power idle-dim false
gset org.gnome.shell favorite-apps "['google-chrome.desktop', 'firefox.desktop', \
'chrome-bgjohebimpjdhhocbknplfelpmdhifhd-Default.desktop', 'chrome-hmjkmjkepdijhoojdojkdfohbdgmmhki-Default.desktop', \
'gpmdp.desktop', 'spotify.desktop', 'synergy.desktop', 'deluge.desktop', 'postman.desktop', 'visual-studio-code.desktop', \
'gnome-system-monitor.desktop', 'org.gnome.Terminal.desktop', 'org.gnome.Nautilus.desktop']"
gset org.gnome.nautilus.preferences executable-text-activation 'ask'
gset org.gnome.nautilus.preferences default-folder-viewer 'list-view'
readonly TERM_PROFILE=b1dcc9dd-5262-4d8d-a863-c897e6d979b9
gset org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:${TERM_PROFILE}/ audible-bell false
gset org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:${TERM_PROFILE}/ use-theme-colors false
gset org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:${TERM_PROFILE}/ background-color 'rgb(30, 40, 50)'
gset org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:${TERM_PROFILE}/ foreground-color 'rgb(255,255,255)'
gset org.gnome.gedit.preferences.editor bracket-matching true
gset org.gnome.gedit.preferences.editor display-line-numbers true
gset org.gnome.gedit.preferences.editor highlight-current-line true
gset org.gnome.gedit.preferences.editor tabs-size 4
gset org.gnome.gedit.preferences.editor scheme "solarized-dark"
gset org.gnome.gedit.plugins active-plugins "['spell', 'quickopen', 'modelines', 'wordcompletion', 'bracketcompletion', \
'git', 'codecomment', 'filebrowser', 'snippets', 'docinfo', 'externaltools', 'terminal', 'smartspaces', 'time']"

banner "GNOME EXTENSIONS SETTINGS"
readonly EXTENSIONS_DIR=${HOME}/.local/share/gnome-shell/extensions

readonly DASH_TO_DOCK=${EXTENSIONS_DIR}/dash-to-dock@micxgx.gmail.com/schemas/
gset --schemadir ${DASH_TO_DOCK} org.gnome.shell.extensions.dash-to-dock click-action 'minimize'
gset --schemadir ${DASH_TO_DOCK} org.gnome.shell.extensions.dash-to-dock dock-fixed true
gset --schemadir ${DASH_TO_DOCK} org.gnome.shell.extensions.dash-to-dock extend-height true
gset --schemadir ${DASH_TO_DOCK} org.gnome.shell.extensions.dash-to-dock background-color '#000000'
gset --schemadir ${DASH_TO_DOCK} org.gnome.shell.extensions.dash-to-dock background-opacity 1.0
gset --schemadir ${DASH_TO_DOCK} org.gnome.shell.extensions.dash-to-dock custom-background-color true
gset --schemadir ${DASH_TO_DOCK} org.gnome.shell.extensions.dash-to-dock custom-theme-shrink true
gset --schemadir ${DASH_TO_DOCK} org.gnome.shell.extensions.dash-to-dock dock-fixed true
gset --schemadir ${DASH_TO_DOCK} org.gnome.shell.extensions.dash-to-dock extend-height true
gset --schemadir ${DASH_TO_DOCK} org.gnome.shell.extensions.dash-to-dock force-straight-corner true
gset --schemadir ${DASH_TO_DOCK} org.gnome.shell.extensions.dash-to-dock transparency-mode 'FIXED'
gset --schemadir ${DASH_TO_DOCK} org.gnome.shell.extensions.dash-to-dock dash-max-icon-size 28
gset --schemadir ${DASH_TO_DOCK} org.gnome.shell.extensions.dash-to-dock custom-theme-customize-running-dots true
gset --schemadir ${DASH_TO_DOCK} org.gnome.shell.extensions.dash-to-dock custom-theme-shrink true
gset --schemadir ${DASH_TO_DOCK} org.gnome.shell.extensions.dash-to-dock running-indicator-style 'DOTS'

# readonly DYNAMIC_PANEL_TRANSPARENCY=${EXTENSIONS_DIR}/dynamic-panel-transparency@rockon999.github.io/schemas/
# gset --schemadir ${DYNAMIC_PANEL_TRANSPARENCY} org.gnome.shell.extensions.dynamic-panel-transparency enable-background-color true
# gset --schemadir ${DYNAMIC_PANEL_TRANSPARENCY} org.gnome.shell.extensions.dynamic-panel-transparency enable-opacity true
# gset --schemadir ${DYNAMIC_PANEL_TRANSPARENCY} org.gnome.shell.extensions.dynamic-panel-transparency theme-opacity 255
# gset --schemadir ${DYNAMIC_PANEL_TRANSPARENCY} org.gnome.shell.extensions.dynamic-panel-transparency unmaximized-opacity 255
