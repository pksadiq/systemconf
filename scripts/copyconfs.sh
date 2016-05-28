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

cd "${SCRIPT_DIR}"

if [ -n $(mkdir -p "${HOME}/.bash") 2>/dev/null ]
then
  touch "${HOME}/.bash/personal"
  cd .bash
  mycp bashrc "${HOME}/.bash/"
  mycp aliases "${HOME}/.bash/"
  mycp functions "${HOME}/.bash/"
  cd "${SCRIPT_DIR}" # Go back to script dir
fi

# TODO: Make a loop to copy files. But explicit file copying below
# informs the user about the files copied

mycp .bashrc "${HOME}"
mycp .editorconfig "${HOME}"
mycp .guile "${HOME}"
mycp .gitconfig "${HOME}"
mycp .gitignore "${HOME}"
mycp .wgetrc "${HOME}"
mycp .Xmodmap "${HOME}"

# .config Settings
mkdir -p "${HOME_DIR}/.config/gtk-3.0"
cd "${SCRIPT_DIR}/.config/gtk-3.0"
mycp settings.ini "${HOME_DIR}/.config/gtk-3.0"

# Copy Templates only if xdg is present
DIR="$(xdg-user-dir TEMPLATES 2>/dev/null)"
if [ "${DIR}" != "${HOME}/" ] || DIR="${HOME}/Templates" && [ -n "${DIR}" ]
then
  mkdir -p "${DIR}"
  xdg-user-dirs-update --set TEMPLATES "${DIR}"
  cd "${DIR}"
  touch "Text.txt"
  mycp "${SCRIPT_DIR}/Templates/Document.odt" "${DIR}"
  cd "${SCRIPT_DIR}" # Go back to script dir
fi
