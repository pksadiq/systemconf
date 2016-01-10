# This file contains some common functions

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


# Returns "true" if the value is "true" or "false", and "false" otherwise
is_true_false ()
{
    CHECK="$1"

    case "${CHECK,,}" in
	true | false)
	    return $(true)
	    ;;
	*)
	    return $(false)
    esac
}

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
    fc-list | tr '=' ':' | cut -d ':' -f 2,4 | tr ':' '=' | while read FONT
    do
	print_font_name "$FONT"
    done
}

# detect Debian and derivatives like Ubuntu, GNU/Linux Mint, etc.
is_debian_based ()
{
    # ID and ID_LIKE has to be matched, and nothing else begin with
    # ID, or end with ID now.
    grep "^ID.*=debian" 2>&1 >/dev/null /etc/os-release
}

# detect Fedora and derivatives like RHEL, CentOS, etc.
is_fedora_based ()
{
    # Also match "rhel fedora" present in CentOS
    grep "^ID.*=.*fedora" 2>&1 >/dev/null /etc/os-release
}

is_arch_based ()
{
    grep "^ID.*=arch" 2>&1 >/dev/null /etc/os-release
}

is_gentoo_based ()
{
    grep "^ID.*=gentoo" 2>&1 >/dev/null /etc/os-release
}
