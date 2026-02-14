#!/bin/bash

# Source the official icon mapping
source "$CONFIG_DIR/helpers/icon_map.sh"

# W I N D O W  T I T L E 
CURRENT_WS=$(/opt/homebrew/bin/aerospace list-workspaces --focused 2>/dev/null)
WINDOW_COUNT=$(/opt/homebrew/bin/aerospace list-windows --workspace "$CURRENT_WS" 2>/dev/null | wc -l | tr -d ' ')

# If no windows in current workspace, hide the title
if [[ "$WINDOW_COUNT" -eq 0 ]]; then
  sketchybar -m --set title drawing=off
  exit 0
fi

# Get the focused window's app name
APP_NAME=$(/opt/homebrew/bin/aerospace list-windows --focused --format '%{app-name}' 2>/dev/null)

# If no window is focused, hide the title
if [[ -z "$APP_NAME" ]]; then
  sketchybar -m --set title drawing=off
  exit 0
fi

# Make sure drawing is on when we have an app
sketchybar -m --set title drawing=on

# Get the icon for the app using the official icon mapping
__icon_map "$APP_NAME"
ICON="$icon_result"

if [[ ${#APP_NAME} -gt 50 ]]; then
  APP_NAME=$(echo "$APP_NAME" | cut -c 1-50)
  sketchybar -m --set title icon="$ICON" label="$APP_NAME…"
  exit 0
fi

sketchybar -m --set title icon="$ICON" label="$APP_NAME"