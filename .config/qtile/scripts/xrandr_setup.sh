#!/bin/sh

if [ "$1" = '-h' ]
then
  echo "horizontal"
  xrandr \
    --output HDMI-0 --primary --mode 1920x1080 --pos 1921x0 --rotate normal \
    --output DP-0 --mode 1920x1080 --pos 0x0 --rotate normal\

  nitrogen --restore &> /dev/null
elif [ "$1" = '-v' ]
then
  echo "vertical"
  xrandr \
    --output HDMI-0 --primary --mode 1920x1080 --pos 1080x0 --rotate normal \
    --output DP-0 --mode 1920x1080 --pos 0x0 --rotate left \

  feh --bg-fill \
    /usr/share/backgrounds/xfce/xfce-leaves.svg \
    Pictures/dark_vertical_anime_girls.jpg
else
  echo \
    " \
    -v set second monitor verticaly \
    -h set second monitor horizontaly \
    "
  nitrogen --restore &> /dev/null
fi

