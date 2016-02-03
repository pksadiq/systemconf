#!/bin/bash

# Copyright (c) 2015, 2016 Mohammed Sadik <sadiq@sadiqpk.org>

# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 3, or (at your option)
# any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.


gs="gsettings set"
settings="org.gnome.desktop"
error="Error: gsettings not found. Not Running GNOME 3?"

# Return to the parent script, if `gsettings' not found
gsettings --version > /dev/null 2>&1 || { echo "$error" ; return 1; }

if [ "${EDITOR,,}" == "emacs" ]
then
    # Set Emacs Key bindings for the complete desktop
    $gs ${settings}.interface gtk-key-theme "Emacs"
    echo "Keyboard shortcuts set to use Emacs keybinding"
fi
case "${CAPS_IS_CTRL,,}" in
    true)
	$gs ${settings}.input-sources xkb-options "['caps:ctrl_modifier']"
	echo "Caps Lock will now act as Control"
	;;
    false)
	$gs ${settings}.input-sources xkb-options "['']"
	echo "Caps Lock will act as Caps Lock"
esac

$gs ${settings}.peripherals.touchpad tap-to-click "true"
$gs ${settings}.peripherals.touchpad scroll-method "two-finger-scrolling"

if is_true_false "${NATURAL_SCROLL}"
then
   $gs ${settings}.peripherals.touchpad natural-scroll "${NATURAL_SCROLL,,}"
   echo "Natural Scrolling for touchpad state: ${NATURAL_SCROLL,,}"
fi

if is_true_false "${AUTO_SOFTWARE_UPDATE}"
then
    $gs org.gnome.software download-updates "${AUTO_SOFTWARE_UPDATE,,}"
    echo "Auto updates via GNOME Software is set to ${AUTO_SOFTWARE_UPDATE,,}"
fi

if [ "${CUSTOM_SHORTCUTS,,}" = "true" ]
then
    # FIXME: This replaces all other custom shortcuts
    $gs org.gnome.settings-daemon.plugins.media-keys custom-keybindings "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom100/']"
    $gs org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom100/ name 'GNOME Terminal'
    $gs org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom100/ command 'gnome-terminal'
    $gs org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom100/ binding '<Primary><Alt>t'
fi
