#!/bin/bash

# Copyright (c) 2015, 2016 Mohammed Sadiq <sadiq@sadiqpk.org>

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
error="gsettings not found. Not configuring GNOME 3"

# Return to the parent script, if `gsettings' not found
gsettings --version > /dev/null 2>&1 || { say fail "$error" ; return 0; }

if [ "${MORE_EMACS,,}" = "true" ]
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
  # Get the current list of shortcuts
  CUR=$(gsettings get org.gnome.settings-daemon.plugins.media-keys custom-keybindings)
  CUR=${CUR%\]}
  KEY='org.gnome.settings-daemon.plugins.media-keys'
  SUBKEY='/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom100/'
  # Check if already added
  if [[ ! "${CUR}" = */custom100/* ]]
  then
    [ "${CUR}" != "@as [" ] && CUR="${CUR},"
    $gs ${KEY} custom-keybindings "${CUR} '${SUBKEY}']"
    $gs ${KEY}.custom-keybinding:${SUBKEY} name 'GNOME Terminal'
    $gs ${KEY}.custom-keybinding:${SUBKEY} command 'gnome-terminal'
    $gs ${KEY}.custom-keybinding:${SUBKEY} binding '<Primary><Alt>t'
  fi
fi

# Easy bindings for switching workspace
$gs ${settings}.wm.keybindings switch-to-workspace-down "['<Super>j', '<Control><Alt>Down']"
$gs ${settings}.wm.keybindings switch-to-workspace-up "['<Super>k', '<Control><Alt>Up']"
