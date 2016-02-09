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

cd "${SCRIPT_DIR}"

if [ "$OVERWRITE" = "true" ]
then
    CP_FLAG=""
else
    CP_FLAG="-n"  # '-n' flag of 'cp' prevents from overwriting files
fi

if [ -n $(mkdir -p "${HOME}/.bash") 2>/dev/null ]
then
    touch "${HOME}/.bash/personal"
    cd .bash
    cp "${CP_FLAG}" bashrc "${HOME}/.bash/"
    cp "${CP_FLAG}" aliases "${HOME}/.bash/"
    cp "${CP_FLAG}" functions "${HOME}/.bash/"    
    cd "${SCRIPT_DIR}" # Go back to script dir
fi

# TODO: Make a loop to copy files. But explicit file copying below
# informs the user about the files copied

cp "${CP_FLAG}" .bashrc "${HOME}"
cp "${CP_FLAG}" .emacs "${HOME}"
cp "${CP_FLAG}" .editorconfig "${HOME}"
cp "${CP_FLAG}" .guile "${HOME}"
cp "${CP_FLAG}" .gitconfig "${HOME}"
cp "${CP_FLAG}" .gitignore "${HOME}"
cp "${CP_FLAG}" .wgetrc "${HOME}"
cp "${CP_FLAG}" .Xmodmap "${HOME}"
