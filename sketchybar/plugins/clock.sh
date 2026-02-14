#!/bin/bash

# The $NAME variable is passed from sketchybar and holds the name of
# the item invoking this script:
# https://felixkratz.github.io/SketchyBar/config/events#events-and-scripting

# Ayu Mirage colors
RED="0xffF28779"
ORANGE="0xffFFA659"
DEFAULT="0xff8a93a5"

# Get current time
HOUR=$(date '+%H')
MINUTE=$(date '+%M')
TIME_NUM=$((10#$HOUR * 100 + 10#$MINUTE))

# Determine color based on time
if [ $TIME_NUM -ge 1200 ] && [ $TIME_NUM -lt 1300 ]; then
    # 12:00 PM - 1:00 PM (Lunch time - RED)
    COLOR=$RED
elif [ $TIME_NUM -ge 1630 ] && [ $TIME_NUM -lt 1730 ]; then
    # 4:30 PM - 5:30 PM (Winding down - ORANGE)
    COLOR=$ORANGE
elif [ $TIME_NUM -lt 900 ] || [ $TIME_NUM -ge 1730 ]; then
    # Before 9:00 AM or after 5:30 PM (Off hours - RED)
    COLOR=$RED
else
    # Work hours - DEFAULT
    COLOR=$DEFAULT
fi

sketchybar --set "$NAME" \
    label="$(date '+%d/%m %H:%M')" \
    label.color="$COLOR" \
    icon.color="$COLOR"

