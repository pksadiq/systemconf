# Copyright (c) 2016 Mohammed Sadik <sadiq@sadiqpk.org>

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

### GNU Bash Configuration ###
cd "${HOME_DIR}/.bash"
sed -i "s/^export EDITOR=.*/export EDITOR=${EDITOR}/" bashrc
# Set VISUAL editor to EDITOR, if emacs. Else use gedit
[ ${EDITOR} = "emacs" ] && VISUAL="emacs" || VISUAL="gedit"
sed -i "s/^export VISUAL=.*/export VISUAL=${VISUAL}/" bashrc
sed -i "s/^export EMAIL=.*/export EMAIL=\"${EMAIL}\"/" bashrc
cd "${HOME_DIR}"
is_battery_present || sed -i '/ *get_battery_per/d' .bashrc

### gitconfig Configuration ###
sed -i "s/^[[:blank:]]*name *=.*/    name = $NAME/" .gitconfig
sed -i "s/^[[:blank:]]*email *=.*/    email = $EMAIL/" .gitconfig
sed -i "s/^[[:blank:]]*editor *=.*/    editor = $EDITOR/" .gitconfig

### .emacs Configuration ###
sed -i "s/user-full-name *\".*\"/user-full-name \"${NAME}\"/" .emacs
sed -i "s/user-mail-address *\".*\"/user-mail-address \"${EMAIL}\"/" .emacs
sed -i "s/set-default-font *\".*\"/set-default-font \"${EMACS_FONT%* Medium}-${EMACS_FONT_SIZE}\"/" .emacs
