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

. "${SCRIPT_DIR}"/scripts/gtk-ui.sh

if [ "${EDITOR,,}" == "emacs" ]
then
    # Set Emacs Key bindings for the complete desktop
    $gs ${settings}.interface gtk-key-theme "Emacs"
    echo "Desktop shortcuts set to Emacs style (almost)"
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
