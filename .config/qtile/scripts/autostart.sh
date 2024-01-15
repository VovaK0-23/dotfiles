#!/bin/sh

/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
setxkbmap -layout us,ru,ua  -option 'grp:rctrl_rshift_toggle'
picom &
/usr/lib/kdeconnectd &
xfce4-power-manager &
solaar -w hide -b symbolic &
emacs --daemon &
dunst &
light-locker &
xfce4-clipman &
sudo timeshift --check
