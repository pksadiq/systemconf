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

# ANSI colors
RED="\e[01;31m"
GREEN="\e[01;32m"
YELLOW="\e[01;33m"
RESET="\e[0m"

say ()
{
  LEVEL="$1"
  MESSAGE="$2"

  case "${LEVEL,,}" in
    ok)
      COLOR="$GREEN"
      ;;
    fail)
      COLOR="$RED"
      ;;
  esac
  
  echo -e "$COLOR""${MESSAGE}" "${RESET}"
}

if [ "${BE_ROOT,,}" = "true" ]
then
  if [ -z "$(which sudo 2>/dev/null)" ]
  then
    echo "Error: 'sudo' not found. Can't be root"
    exit 1
  fi

  INSTALL_DIR="/usr/share/"
  DO_SUDO="sudo"
else
  INSTALL_DIR="${HOME_DIR}/.local/share"
  DO_SUDO=""
fi

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

get_true_false ()
{
  CHECK="$1"

  is_true_false "${CHECK}" || return 1
  
  case "${CHECK,,}" in
    true)
      echo "1"
      ;;
    false)
      echo "0"
  esac
  
  return $(true)
}

is_number ()
{
  NUM_REGEX='^[0-9]+$'
  if ! $(egrep ${NUM_REGEX} <<< "$1" >/dev/null 2>&1 && test "$1" -ge 5)
  then
    echo "Interface font size should be an integer greater than 4"
    return $(false)
  fi
}

is_battery_present ()
{
  BAT="$(grep -il 'battery' /sys/class/power_supply/*/type 2>/dev/null)" ||
    return $(false)

  BAT=$(sed 's/type/capacity/' <<< "$BAT")
}

# Calculate sha1sum
checksum ()
{
  FILE="${1}"
  CHECKSUM="${2}"

  cd "${SCRIPT_DIR}/temp"
  
  [ ! -f "${FILE}" ] && return $(false)
  SHASUM=$(sha1sum "${FILE}" | cut -d ' ' -f 1)
  [ "${CHECKSUM}" = "${SHASUM}" ] && return $(true)
  return $(false)
}

get_file ()
{
  URL="${1}"
  FILE="${2}"
  CHECKSUM="${3}"
  
  cd "${SCRIPT_DIR}/temp"
  
  # Return if file already downloaded
  checksum "${FILE}" "$CHECKSUM" && return $(true)
  [ "${USE_INTERNET,,}" = "true" ] || return $(false)

  wget "${URL}" -O "${FILE}" || return $(false)
}

unpack_file ()
{
  FILE="${2}"
  
  cd "${SCRIPT_DIR}/temp/"

  case "${FILE}" in
    *.zip)
      unzip "${FILE}"
      ;;
    *.tar.gz | *.tar.bz2 | *.tar.xz)
      tar xf "${FILE}"
      ;;
    *.gz)
      gunzip "${FILE}"
      ;;
    *)
      echo "Unpack: Archive format not supported" && return $(false)
      ;;
  esac
}

install_file ()
{
  TYPE="${1,,}s"
  DIR="${2}"

  cd "${SCRIPT_DIR}"
  ${DO_SUDO} mkdir -p "${INSTALL_DIR}/${TYPE}"
  echo -n "Installing ${TYPE}: "
  ${DO_SUDO} cp -r "${DIR}" "${INSTALL_DIR}/${TYPE}" || say fail "Failed" &&
    return $(false)
  say ok "OK"
}

# detect Debian and derivatives like Ubuntu, GNU/Linux Mint, etc.
is_debian_based ()
{
  # ID and ID_LIKE has to be matched, and nothing else begin with
  # ID, or end with ID now.
  grep "^ID.*=debian" >/dev/null 2>&1 /etc/os-release
}

# detect Fedora and derivatives like RHEL, CentOS, etc.
is_fedora_based ()
{
  # Also match "rhel fedora" present in CentOS
  grep "^ID.*=.*fedora" >/dev/null 2>&1 /etc/os-release
}

is_arch_based ()
{
  grep "^ID.*=arch" >/dev/null 2>&1 /etc/os-release
}

is_gentoo_based ()
{
  grep "^ID.*=gentoo" >/dev/null 2>&1 /etc/os-release
}
