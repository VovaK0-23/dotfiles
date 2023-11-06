#!/bin/sh

while true; do
  # # Get the LED status from xset
  # led_status=$(xset -q | grep -A 0 'LED' | cut -c59-67)
  # # Check the LED status and assign a variable
  # if [ "$led_status" = "00000000" ]; then
  #   language="en"
  # elif [ "$led_status" = "00001000" ]; then
  #   language="ru"
  # else
  #   language="ua?" # Handle other cases if needed
  # fi
  language=$(xkblayout-state print "%s")
  qtile cmd-obj -o widget layout -f update -a "$language"
  sleep 1
done
