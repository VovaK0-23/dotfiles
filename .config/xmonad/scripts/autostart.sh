#!/bin/sh

xrandr \
    --output DP-0 --off \
    --output DP-1 --off \
    --output DP-2 --off \
    --output DP-3 --off \
    --output HDMI-0 --primary --mode 1920x1080 --pos 1965x0 --rotate normal \
    --output DP-4 --mode 1920x1080 --pos 0x0 --rotate normal --rate 75\
    --output DP-5 --off

stalonetray &
nitrogen --restore &
picom &
kstart5 /usr/lib/kdeconnectd &
xfce4-power-manager &
redshift-gtk &
solaar -w hide -b symbolic &
emacs --daemon &
sudo timeshift --check
