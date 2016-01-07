#!/bin/bash

gs="gsettings set"
settings="org.gnome.desktop"
error="Error: gsettings not found. Not Running GNOME?"

# Return to the parent script, if `gsettings' not found
gsettings --version > /dev/null 2>&1 || { echo "$error" ; return 1; }

if [ "${EDITOR,,}" == "emacs" ]
then
    # Set Emacs Key bindings for the complete desktop
    $gs ${settings}.interface gtk-key-theme "Emacs"
    echo "Desktop shortcuts set to Emacs style (almost)"
    if [ "${CAPS_IS_CTRL,,}" == "true" ]
    then
	$gs ${settings}.input-sources xkb-options "['caps:ctrl_modifier']"
	echo "Caps Lock will now act as Control"
    fi
fi

$gs ${settings}.peripherals.touchpad tap-to-click "true"
$gs ${settings}.peripherals.touchpad scroll-method "two-finger-scrolling"
if [ "${NATURAL_SCROLL,,}" == "true" ]
then
    $gs ${settings}.peripherals.touchpad natural-scroll "true"
    echo "Touch pad natural scrolling enabled"
fi
