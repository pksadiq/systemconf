# Copyright (c) 2016 Mohammed Sadiq <sadiq@sadiqpk.org>

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

### GNU/Linux Distribution specific settings
# Set variables like package manager
set_dist_vars

### GNU Bash Configuration ###
cd "${HOME_DIR}/.bash"
set_file "s/^export EDITOR=.*/export EDITOR=${EDITOR}/" bashrc
# Set VISUAL editor to EDITOR, if emacs. Else use gedit
[ ${EDITOR} = "emacs" ] && VISUAL="emacs" || VISUAL="gedit"
set_file "s/^export VISUAL=.*/export VISUAL=${VISUAL}/" bashrc
set_file "s/^export EMAIL=.*/export EMAIL=\"${EMAIL}\"/" bashrc
is_battery_present || set_file "s/set_battery_ps1;\ //" bashrc
make_cd aliases
set_file "s/^PING_IP=.*/export PING_IP=\"${PING_IP}\"/" functions
set_file "s/^PING_URL=.*/export PING_URL=\"${PING_URL}\"/" functions
cd "${HOME_DIR}"
is_battery_present || set_file '/ *get_battery_per/d' .bashrc

### gitconfig Configuration ###
set_file "s/^[[:blank:]]*name *=.*/    name = $NAME/" .gitconfig
set_file "s/^[[:blank:]]*email *=.*/    email = $EMAIL/" .gitconfig
set_file "s/^[[:blank:]]*editor *=.*/    editor = $EDITOR/" .gitconfig

### Gtk3/GNOME Configuration ###
GTK3_CONF="${HOME_DIR}/.config/gtk-3.0/settings.ini"
IS_DARK=$(get_true_false "$PREFER_DARK")
[ "${IS_DARK}" ] &&
  sed -i "s/^gtk.*prefer-dark-theme.*/gtk-application-prefer-dark-theme=${IS_DARK}/" "${GTK3_CONF}"
add_bookmarks
