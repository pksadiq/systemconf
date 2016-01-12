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
    done
    IFS="${IFS_OLD}"
}

get_fonts ()
{
    # FIXME: Is there a better way to get the fonts, just with fc-list?
    fc-list | tr '=' ':' | cut -d ':' -f 2,4 | tr ':' '=' | while read FONT
    do
	# TODO: avoid duplicate names. Save list to a file to avoid repeating
	print_font_name "$FONT"
    done
}

is_font_present ()
{
    CHECK="$1"
    CHECK_SIZE="$1_SIZE"
    if ! $(get_fonts | grep "^${!CHECK}$" 2>&1 > /dev/null)
    then
	echo "\"${!CHECK}\" Font seems not present"
	return $(false)
    fi
    is_number ${!CHECK_SIZE}
}

get_themes ()
{
    # Lets hope there won't be spaces in directory names
    if [ $1 = gtk_theme ]
    then
       THEME_DIRS="${HOME_DIR}/.themes ${HOME_DIR}/.local/share/themes"
       THEME_DIRS="${THEME_DIRS} /usr/share/themes"
    else if [ $1 = icon_theme ]
	 then
	     THEME_DIRS="${HOME_DIR}/.icons ${HOME_DIR}/.local/share/icons"
	     THEME_DIRS="${THEME_DIRS} /usr/share/icons"
	 fi
    fi
    
    for THEME_DIR in ${THEME_DIRS}
    do
	[ -d $THEME_DIR ] && for DIR in $THEME_DIR/*
	do
	    if [ -d $DIR ]
	    then
		cd $DIR
		if [ -f index.theme ]
		then
		    grep "^Name=" index.theme | cut -d "=" -f 2
		fi
	    fi
	done
    done
}

