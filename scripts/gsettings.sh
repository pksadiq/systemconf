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

    case "${CAPS_IS_CTRL,,}" in
	true)
	    $gs ${settings}.input-sources xkb-options "['caps:ctrl_modifier']"
	    echo "Caps Lock will now act as Control"
	    ;;
	false)
	    $gs ${settings}.input-sources xkb-options "['']"
	    echo "Caps Lock will act as Caps Lock"
    esac
fi

$gs ${settings}.peripherals.touchpad tap-to-click "true"
$gs ${settings}.peripherals.touchpad scroll-method "two-finger-scrolling"
case "${NATURAL_SCROLL,,}" in
    true | false)
	$gs ${settings}.peripherals.touchpad natural-scroll "${NATURAL_SCROLL,,}"
	echo "Natural Scrolling for touchpad state: ${NATURAL_SCROLL,,}"
esac
