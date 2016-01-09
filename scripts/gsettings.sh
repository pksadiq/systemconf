#!/bin/bash

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
