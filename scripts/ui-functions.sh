# This file contains functions that are related to UI elements
# like Theme, icon, etc

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

# Extract and print each Comma Separated Value pairs on newline
print_font_name ()
{
  IFS_OLD="${IFS}"
  IFS=','
  
  FONT_NAMES="${1%=*}"
  STYLE_NAMES="${1#*=}"
  
  for FONT_NAME in ${FONT_NAMES}
  do
    for STYLE_NAME in ${STYLE_NAMES}
    do
      echo "$FONT_NAME" "$STYLE_NAME"
    done
    # FIXME: Is this right? Seems to happen in gtk font chooser
    echo "$FONT_NAME Bold"
    echo "$FONT_NAME Italic"
    echo "$FONT_NAME Bold Italic"
  done
  IFS="${IFS_OLD}"
}

get_fonts ()
{
  # FIXME: Is there a better way to get the fonts, just with fc-list?
  fc-list | tr '=' ':' | cut -d ':' -f 2,4 | tr ':' '=' | while read FONT
  do
    # TODO: avoid duplicate names. Save list to a file to avoid repeating
    # Required? Many people uses SSDs. Extensive writing to disk may be bad
    print_font_name "$FONT"
  done
}

is_font ()
{
  CHECK="$1"
  CHECK_SIZE="$1_SIZE"
  if ! $(get_fonts | grep "^${!CHECK}$" >/dev/null 2>&1)
  then
    echo "\"${!CHECK}\" Font seems not present"
    return $(false)
  fi
  is_number ${!CHECK_SIZE}
}

list_themes ()
{
  if [ $1 = gtk_theme ]
  then
    THEME_DIRS="${HOME_DIR}/.themes, ${HOME_DIR}/.local/share/themes,"
    THEME_DIRS="${THEME_DIRS} /usr/share/themes"
  elif [ $1 = icon_theme ]
  then
    THEME_DIRS="${HOME_DIR}/.icons, ${HOME_DIR}/.local/share/icons,"
    THEME_DIRS="${THEME_DIRS} /usr/share/icons"
  fi

  OLD_IFS="${IFS}"
  IFS=", "
  
  for THEME_DIR in ${THEME_DIRS}
  do
    [ -d "$THEME_DIR" ] && for DIR in $THEME_DIR/*
    do
      if [ -d "$DIR" ]
      then
	cd "$DIR"
	if [ -f index.theme ]
	then
	  echo "$(basename ${DIR})"
	fi
      fi
    done
  done
  IFS="${OLD_IFS}"
}

is_icon_theme ()
{
  THEME_NAME="$1"
  list_themes icon_theme | grep "$1" >/dev/null 2>&1 ||
    return $(false)
}

is_gtk_theme ()
{
  THEME_NAME="$1"
  list_themes gtk_theme | grep "$1" >/dev/null 2>&1 ||
    return $(false)
}

set_font ()
{
  FONT="$1"
  FONT_SIZE="$1_SIZE"
  SCHEMA="$2"
  KEY="$3"
  if is_font "${FONT}"
  then
    gsettings set "${SCHEMA}" "${KEY}" "${!FONT} ${!FONT_SIZE}"
  fi
}
