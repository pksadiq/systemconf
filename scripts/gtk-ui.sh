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

if install_themes "${GTK_THEME}"
then
  $gs ${settings}.interface gtk-theme "${GTK_THEME}"
fi

if install_icons "${ICON_THEME}"
then
  $gs ${settings}.interface icon-theme "${ICON_THEME}"
fi

if is_true_false "${PREFER_DARK_TERM}"
then
  $gs org.gnome.Terminal.Legacy.Settings dark-theme "${PREFER_DARK_TERM,,}"
fi

if is_true_false "${PREFER_DARK_IDE}"
then
  $gs org.gnome.builder night-mode "${PREFER_DARK_IDE,,}"
  if [ "${PREFER_DARK_IDE,,}" = "true" ]
  then
    $gs org.gnome.builder.editor style-scheme-name "builder-dark"
    $gs org.gnome.gedit.preferences.editor scheme "builder-dark"
  else
    $gs org.gnome.builder.editor style-scheme-name "builder"
    $gs org.gnome.gedit.preferences.editor scheme "builder"
  fi
fi

##### Set Fonts #####
set_font "INTERFACE_FONT" ${settings}.interface font-name
set_font "WINDOW_TITLE_FONT" ${settings}.wm.preferences titlebar-font

# Set Gedit font
$gs org.gnome.gedit.preferences.editor use-default-font false
set_font "EMACS_FONT" org.gnome.gedit.preferences.editor editor-font
# Set GNOME Builder font
set_font "EMACS_FONT" org.gnome.builder.editor font-name
# Set Global Monospace font (eg: in Devhelp, etc.)
set_font "MONOSPACE_FONT" ${settings}.interface monospace-font-name

# Show date in GNOME shell top bar. "true" is sane enough
$gs ${settings}.interface clock-show-date true

# Show All the three window control buttons.
$gs ${settings}.wm.preferences button-layout 'appmenu:minimize,maximize,close'
