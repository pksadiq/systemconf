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

cd "${SCRIPT_DIR}/.bash"

### GNU Bash Configuration ###
sed -i "s/^export EDITOR=.*/export EDITOR=${EDITOR}/" bashrc
# Set VISUAL editor to EDITOR, if emacs. Else use gedit
[ ${EDITOR} = "emacs" ] && VISUAL="emacs" || VISUAL="gedit"
sed -i "s/^export VISUAL=.*/export VISUAL=${VISUAL}/" bashrc
sed -i "s/^export EMAIL=.*/export EMAIL=\"${EMAIL}\"/" bashrc

cd "${SCRIPT_DIR}"

### gitconfig Configuration ###
sed -i "s/^ *name *=.*/    name = $NAME/" .gitconfig
sed -i "s/^ *email *=.*/    email = $EMAIL/" .gitconfig
sed -i "s/^ *editor *=.*/    editor = $EDITOR/" .gitconfig
