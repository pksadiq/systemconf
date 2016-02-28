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

  INSTALL_DIR="/usr/share"
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

  wget "${URL}" -O "${FILE}" 2>/dev/null || return $(false)
}

unpack_file ()
{
  FILE="${1}"
  
  cd "${SCRIPT_DIR}/temp/"
  [ ! -f "${FILE}" ] && return $(false)
  
  case "${FILE}" in
    *.zip)
      unzip -n "${FILE}"
      ;;
    *.tar.gz | *.tar.bz2 | *.tar.xz)
      tar xf "${FILE}" --skip-old-files
      ;;
    *.gz)
      gunzip -k "${FILE}"
      ;;
    *)
      echo "Unpack: Archive format not supported" && return $(false)
      ;;
  esac
}

install_file ()
{
  TYPE="${1,,}s"
  NAME=$(echo -n "${2}" | tr ' ' '_')
  
  cd "${SCRIPT_DIR}/temp"

  # Fail if icon/font/theme not defined as array in scripts/files.sh
  if ! ARRAY="$(declare -p ${NAME^^}_${TYPE^^} 2>/dev/null)"
  then
    say fail "Installation source not found"
    return $(false)
  fi
  eval "declare -A ARRAY=${ARRAY#*=}"
  
  URL="${ARRAY[url]}"
  FILE="${ARRAY[name]}.${ARRAY[type]}"
  CHECKSUM="${ARRAY[sha1]}"

  get_file "$URL" "$FILE" "$CHECKSUM"
  unpack_file  "$FILE" || return $(false)
  ${DO_SUDO} mkdir -p "${INSTALL_DIR}/${TYPE}"
  echo -n "Installing ${TYPE}: "

  for i in $(seq 1 5)
  do
    DIR="${ARRAY[dir${i}]}"
    [ "${DIR}" ] || break
    cd "${SCRIPT_DIR}"
    cd temp
    cd "${DIR}"
    cd ..
    DIR=$(basename "${DIR}")

    if ! ${DO_SUDO} cp -r "${DIR}" "${INSTALL_DIR}/${TYPE}" 2>/dev/null
    then
      say fail "Failed"
      return $(false)
    fi
  done
  say ok "Done"
}

make_cd ()
{
  ALIAS="${1}"
  
  [ "${OVERWRITE,,}" = "true" ] || is_new_file "${ALIAS}" ||
    return $(false)
  
  ARRAY="$(declare -p CD 2>/dev/null)" || return $(false)
  for i in ${!CD[@]}
  do
    echo "alias cd${i}='cd ${CD[${i}]}'" >> "${ALIAS}"
  done
}

add_bookmarks ()
{
  mkdir -p "${HOME}/.config/gtk-3.0" || return $(false)
  FILE="${HOME}/.config/gtk-3.0/bookmarks"
  
  for i in ${BOOKMARKS[*]}
  do
    egrep "file://${CD[${i}]}( |$)" "${FILE}" > /dev/null && continue
    echo "file://${CD[${i}]}" >> "${FILE}"
  done
}

mycp ()
{
  SRC="${1}"
  DST="${2}"

  if [ "${OVERWRITE,,}" = "true" ]
  then
    CP_FLAG=
  else
    CP_FLAG="-n"  # '-n' flag of 'cp' prevents from overwriting files
  fi

  if [ ! -f "${DST}/$(basename ${SRC})" ]
  then
    UPDATE_FILES=("${UPDATE_FILES[@]}" "$(basename ${SRC})")
  fi

  cp ${CP_FLAG} "${SRC}" "${DST}"
}

is_new_file ()
{
  CHECK="${1}"
  
  if [[ " ${UPDATE_FILES[*]} " == *" ${CHECK} "* ]]
  then
    return $(true)
  fi

  return $(false)
}

set_file ()
{
  CHANGE="${1}"
  FILE="${2}"

  if [ "${OVERWRITE,,}" = "true" ] || is_new_file "${FILE}"
  then
    sed -i "${CHANGE}" "${FILE}"
  fi
}

set_dist_vars ()
{
  [ -f /etc/os-release ] || return $(false)
  CHECK="$(grep ^ID= /etc/os-release)"
  
  case "${CHECK}" in
    *debian*)
      DIST="debian"
      PACK="apt-get"
      PACK_INSTALL="apt-get install"
      PACK_UPDATE="apt-get update"
      PACK_INFO="apt-cache info"
      ;;
    *fedora*)
      DIST="fedora"
      PACK="dnf"
      PACK_INSTALL="dnf -C install"
      PACK_UPDATE="dnf check-update"
      PACK_INFO="dnf -C info"
      ;;
  esac
}
