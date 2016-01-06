#!/bin/bash

gs="gsettings set"
settings="org.gnome.desktop"

if [ "${EDITOR,,}" == "emacs" ]
then
    # Set Emacs Key bindings for the complete desktop
    $gs ${settings}.interface gtk-key-theme "Emacs"
    echo "Desktop shortcuts set to Emacs style (almost)"
fi

$gs ${settings}.peripherals.touchpad tap-to-click "true"
$gs ${settings}.peripherals.touchpad scroll-method "two-finger-scrolling"
$gs ${settings}.peripherals.touchpad natural-scroll "true"
