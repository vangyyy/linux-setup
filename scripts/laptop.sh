#!/bin/bash

# Install packages
sudo pacman -S iio-sensor-proxy xournal

# Enable gyroscope service
systemctl enable iio-sensor-proxy

# Gnome extensions
gnomeshell-extension-manage --install --extension-id 0945 --user # CPU Power Manager

# Disable input sources (use 'Wacom' for all touch input)
line='while read id; do xinput disable $id; done <<< $(xinput | grep 'Finger' | cut -d"=" -f2 | cut -f1)'
file=${HOME}/.profile
grep -qF "${line}" "${file}" || echo -e "\n# Disable input sources\n${line}" >>"${file}"

# Trackpoint sensitivity
# sudo bash -c 'cat << EOF > /etc/udev/rules.d/10-trackpoint.rules
# ACTION=="add", SUBSYSTEM=="input", ATTR{name}=="TPPS/2 IBM TrackPoint", ATTR{device/speed}="255"
# EOF'

# Touch screen scrolling in firefox (needed after every firefox update)
sudo sed -i "s|Exec=|Exec=env MOZ_USE_XINPUT2=1 |g" /usr/share/applications/firefox.desktop
