#!/bin/bash

gs="gsettings set"
settings="org.gnome.desktop"

if [ "${EDITOR,,}" == "emacs" ]
then
    # Set Emacs Key bindings for the complete desktop
    $gs ${settings}.interface gtk-key-theme "Emacs"
    echo "Desktop shortcuts set to Emacs style (almost)"
fi
