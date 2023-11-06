#!/bin/sh

if [ "$1" = '-h' ]
then
  echo "horizontal"
  xrandr \
    --output HDMI-1 --primary --mode 1920x1080 --pos 1921x0 --rotate normal \
    --output DP-2 --mode 1920x1080 --pos 0x0 --rotate normal\

 feh --bg-scale \
   Pictures/anime-landscape-sunset-dawn.jpeg \
   Pictures/aesthetic-anime.jpg
elif [ "$1" = '-v' ]
then
  echo "vertical"
  xrandr \
    --output HDMI-1 --primary --mode 1920x1080 --pos 1080x0 --rotate normal \
    --output DP-2 --mode 1920x1080 --pos 0x0 --rotate left \

  feh --bg-fill \
    Pictures/aesthetic-anime.jpg \
    Pictures/dark_vertical_anime_girls.jpg
else
  echo \
    " \
    -v set second monitor verticaly \
    -h set second monitor horizontaly \
    "
  nitrogen --restore &> /dev/null
fi

