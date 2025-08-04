#!/bin/bash

menu="$1"

if [ "$menu" = "filebrowser" ]; then
    rofi -show filebrowser -theme clean

elif [ "$menu" = "appmenu" ]; then
    rofi -show drun -theme clean

elif [ "$menu" = "powermenu" ]; then
    rofi -modi 'Powermenu:~/.scripts/rofi/powermenu.sh' -show Powermenu -theme powermenu
    #rofi -modi 'Powermenu:~/.scripts/rofi/powermenu.sh' -show Powermenu -theme powermenu -location 3 -xoffset -30 -yoffset 100

elif [ "$menu" = "tabmenu" ]; then
    ~/.scripts/rofi/tabmenu.sh
fi
