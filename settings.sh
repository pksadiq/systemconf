# Configuration file to be set by the user

# Copyright (c) 2015, 2016 Mohammed Sadiq <sadiq@sadiqpk.org>

# This file is free software; you can redistribute it and/or modify it
# under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, see <http://www.gnu.org/licenses/>.

# NOTE: Wherever you can fill "true" or "false", you can use
# some other value, to keep the current configuration as such.

NAME="Mohammed Sadiq"
EMAIL="sadiq@sadiqpk.org"

# Do you wish to overwrite your current config files?
OVERWRITE="false"

# Overwrite the file if the file is the default one that came
# with your distribution (Eg.: .bashrc, .emacs)
# TODO: Use this
OVERWRITE_DEFAULTS="true"

# Install packages, themes, etc. as root? configure root settings?
# If not set to "true", themes shall be installed on user specific dirs.
# Packages may not be installed, and root specific settings won't be
# configured.
BE_ROOT="true"

EDITOR="gedit"
# Set Emacs key bindings where ever possible
# This includes Desktop Environment, GNOME Builder, etc.
MORE_EMACS="false"

# Caps Lock acts as Control Key.
# Very helpful if you are an Emacs user.
CAPS_IS_CTRL="false"

# Currently the following are configured:
# Alt+Ctrl+T = gnome-terminal
# Super+j (and Ctrl+Alt+↓) =  Switch to workspace down
# Super+k (and Ctrl+Alt+↑) =  Switch to workspace up
CUSTOM_SHORTCUTS="true"

# Use internet to download missing files or packages?
# anything other than "true" is considered "false"
USE_INTERNET="true"

# Auto update packages via Gnome software?
# Set to "false" if you rely on `apt' or `dnf'
AUTO_SOFTWARE_UPDATE="false"

# URL and IP for ping test.
# Using IPs like Google's one shall reveal Google that
# you are connected to internet.
# TODO: Change to www.sadiqpk.org, once the server is ready
PING_IP="8.8.8.8"
PING_URL="www.google.com"

### cd aliases ###
# You can add any number of aliases
# Eg.: If you have CD[d], you can do 'cdd' to cd to that dir
declare -A CD
CD[m]="/media/sadiq/Main/Manuals"
CD[s]="/media/sadiq/Temp/sadiq/Test_1/Projects/Personal/systemconf"

# Add Bookmarks to Nautilus (GNOME Files). Add shortcodes from
# above CD
declare -a BOOKMARKS
BOOKMARKS=('s' 'm')

# Scroll as on touch screen.
NATURAL_SCROLL="false"

##### Theme settings #####
# Themes, possible values: "Adwaita", "Paper"
GTK_THEME="Adwaita"
PREFER_DARK="false"
PREFER_DARK_TERM="true" # Prefer dark theme for GNOME Terminal?
PREFER_DARK_IDE="true" # Prefer dark theme for GNOME Builder? Gedit?

# The main icons used
# Possible values:
# "Adwaita", "Moka", "Numix-Circles", "Paper"
ICON_THEME="Moka"

# TODO: Use this
LOGO_TEXT="www.sadiqpk.org"

##### Fonts #####
# Font on  title bar
WINDOW_TITLE_FONT="Cantarell Bold"
WINDOW_TITLE_FONT_SIZE="11"

INTERFACE_FONT="Cantarell Regular"
INTERFACE_FONT_SIZE="11"

# Font used for codes, (Eg: Devhelp)
MONOSPACE_FONT="Inconsolata Medium"
MONOSPACE_FONT_SIZE="11"

# Font used for Emacs, GNOME Terminal, Gedit etc.
EMACS_FONT="Inconsolata Medium"
EMACS_FONT_SIZE="13"
