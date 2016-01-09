
# This scripts updates the UI elements in GNOME 3.
# Elements like theme and fonts.

$gs ${settings}.interface gtk-theme "${GTK_THEME}"

if is_true_false "${PREFER_DARK_TERM}"
then
    $gs org.gnome.Terminal.Legacy.Settings dark-theme "${PREFER_DARK_TERM,,}"
fi
