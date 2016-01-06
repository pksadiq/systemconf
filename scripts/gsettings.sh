#!/bin/bash

gs="gsettings set"
interface="org.gnome.desktop.interface"

if [ "${EDITOR,,}" == "emacs" ]
then
    # Set Emacs Key bindings for the complete desktop
    $gs $interface gtk-key-theme "Emacs"
    echo "Desktop shortcuts set to Emacs style (almost)"
fi
