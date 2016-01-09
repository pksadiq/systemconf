
# This scripts updates the UI elements in GNOME 3.
# Elements like theme and fonts.

$gs ${settings}.interface gtk-theme "${GTK_THEME}"
case "${PREFER_DARK_TERM,,}" in
    true | false)
	$gs org.gnome.Terminal.Legacy.Settings dark-theme "${PREFER_DARK_TERM,,}"
esac
