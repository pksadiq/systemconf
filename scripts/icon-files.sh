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

# Icon Theme listing
declare -A ICONS
ICONS["Moka"]=MOKA
ICONS["Paper"]=PAPER
ICONS["Numix"]=NUMIX
ICONS["Numix-Light"]=NUMIX
ICONS["Numix-Circle"]=NUMIX_CIRCLE
ICONS["Numix-Circle-Light"]=NUMIX_CIRCLE

### Icon themes ###
# Moka Icon theme
declare -A MOKA_ICONS
MOKA_ICONS[commit]="50894ee9411721649019cd168b8ae2c85f4b5cf0"
MOKA_ICONS[url]="https://github.com/snwh/moka-icon-theme/archive/${MOKA_ICONS[commit]}.tar.gz"
MOKA_ICONS[type]="tar.gz"
MOKA_ICONS[size]="65.1 MiB"
MOKA_ICONS[sha1]="0db869644d121737044c8544860760f52097b7d8"
MOKA_ICONS[name]="moka-icon-theme"
MOKA_ICONS[dir1]="moka-icon-theme-${MOKA_ICONS[commit]}/Moka"

# Numix Icon theme
declare -A NUMIX_ICONS
NUMIX_ICONS[commit]="e35fff81da202dc65c3e9db7b4c342272e30f9e6"
NUMIX_ICONS[url]="https://github.com/numixproject/numix-icon-theme/archive/${NUMIX_ICONS[commit]}.tar.gz"
NUMIX_ICONS[type]="tar.gz"
NUMIX_ICONS[size]="1.6 MiB"
NUMIX_ICONS[sha1]="1b8b91f3dc8d78ff1c20e0fe3fd0fb7f2633dbe4"
NUMIX_ICONS[name]="numix-icon-theme"
NUMIX_ICONS[dir1]="numix-icon-theme-${NUMIX_ICONS[commit]}/Numix"
NUMIX_ICONS[dir2]="numix-icon-theme-${NUMIX_ICONS[commit]}/Numix-Light"

# Numix Circle Icon theme
declare -A NUMIX_CIRCLE_ICONS
NUMIX_CIRCLE_ICONS[commit]="6cccdbcc685fe5a8318a499f3fdd12db431f8973"
NUMIX_CIRCLE_ICONS[url]="https://github.com/numixproject/numix-icon-theme-circle/archive/${NUMIX_CIRCLE_ICONS[commit]}.tar.gz"
NUMIX_CIRCLE_ICONS[type]="tar.gz"
NUMIX_CIRCLE_ICONS[size]="1.6 MiB"
NUMIX_CIRCLE_ICONS[sha1]="87f764d5ce0c93d5547b4c6f3e9ca20f7ac73ea4"
NUMIX_CIRCLE_ICONS[name]="numix-icon-theme-circle"
NUMIX_CIRCLE_ICONS[dir1]="numix-icon-theme-circle-NUMIX_CIRCLE_ICONS[commit]/Numix-Circle-Light"
NUMIX_CIRCLE_ICONS[dir2]="numix-icon-theme-circle-NUMIX_CIRCLE_ICONS[commit]/Numix-Circle"

# Paper Icon theme
declare -A PAPER_ICONS
PAPER_ICONS[commit]="ae82c98cc8c4248d940fdd27870f146c70cdf228"
PAPER_ICONS[url]="https://github.com/snwh/paper-icon-theme/archive/${PAPER_ICONS[commit]}.tar.gz"
PAPER_ICONS[type]="tar.gz"
PAPER_ICONS[size]="18.9 MiB"
PAPER_ICONS[sha1]="962eafb8dfaf95786d34beab099f5192000e1f1b"
PAPER_ICONS[name]="paper-icon-theme"
PAPER_ICONS[dir1]="paper-icon-theme-PAPER_ICONS[commit]/Paper"
