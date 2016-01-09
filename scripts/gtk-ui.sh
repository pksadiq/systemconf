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
