# This scripts updates the UI elements in GNOME 3.
# Elements like theme and fonts.

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


$gs ${settings}.interface gtk-theme "${GTK_THEME}"
$gs ${settings}.interface icon-theme "${ICON_THEME}"

if is_true_false "${PREFER_DARK_TERM}"
then
    $gs org.gnome.Terminal.Legacy.Settings dark-theme "${PREFER_DARK_TERM,,}"
fi

##### Set Fonts #####
if is_font_present "${INTERFACE_FONT}"
then
    if is_number "${INTERFACE_FONT_SIZE}"
    then
	$gs ${settings}.interface font-name \
	    "${INTERFACE_FONT} ${INTERFACE_FONT_SIZE}"
    fi
fi

if is_font_present "${WINDOW_TITLE_FONT}"
then
    if is_number "${WINDOW_TITLE_FONT_SIZE}"
    then
	$gs ${settings}.wm.preferences titlebar-font \
	    "${WINDOW_TITLE_FONT} ${WINDOW_TITLE_FONT_SIZE}"
    fi
fi

# Set Gedit font
if is_font_present "${EMACS_FONT}"
then
    if is_number "${EMACS_FONT_SIZE}"
    then
	$gs org.gnome.gedit.preferences.editor editor-font \
	    "${EMACS_FONT} ${EMACS_FONT_SIZE}"
    fi
fi

if is_font_present "${MONOSPACE_FONT}"
then
    if is_number "${MONOSPACE_FONT_SIZE}"
    then
	$gs ${settings}.interface monospace-font-name \
	    "${MONOSPACE_FONT} ${MONOSPACE_FONT_SIZE}"
    fi
fi
