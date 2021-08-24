#!/bin/sh

nitrogen --restore &
picom &
kdeconnect-app &
xfce4-power-manager &
ruby Documents/code_tests/rclone_script/rclone_script.rb &
bash Documents/scripts/auth.sh &
redshift-gtk &
