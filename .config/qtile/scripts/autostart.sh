#!/bin/sh

/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
setxkbmap -layout us,ru  -option 'grp:rctrl_rshift_toggle'
picom &
/usr/lib/kdeconnectd &
xfce4-power-manager &
solaar -w hide -b symbolic &
emacs --daemon &
dunst &
xfce4-clipman &
# sudo timeshift --check
