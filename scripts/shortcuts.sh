#!/bin/bash

readonly KB_SHORTCUTS=(
    '<Primary><Alt>t;	gnome-terminal;			Open terminal'
    '<Alt>d;			xset dpms force off;	Turn off display'
)

banner "KEYBOARD SHORTCUTS"
for i in "${!KB_SHORTCUTS[@]}"; do
    # Turn 'binding;command;name' into array ['binding', 'command', 'name']
    IFS=";" read -r -a arr <<<"${KB_SHORTCUTS[i]}"

    binding=$(sed -e 's/^[ \t]*//' <<<${arr[0]})
    command=$(sed -e 's/^[ \t]*//' <<<${arr[1]})
    name=$(sed -e 's/^[ \t]*//' <<<${arr[2]})

    log "Setting <_${name}_> (${binding})" ${C_GREEN}
    gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom${i}/ binding "${binding}"
    gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom${i}/ command "${command}"
    gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom${i}/ name "${name}"

    keybinding_list+="'/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom${i}/', "
done

gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "[${keybinding_list::-2}]"
