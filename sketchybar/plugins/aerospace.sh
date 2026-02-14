#!/usr/bin/env bash

# Source the official icon mapping
source "$CONFIG_DIR/helpers/icon_map.sh"

# Ayu Mirage colors
ACCENT="0xffffcc66"
MUTED_ORANGE="0x80ffa659"

# Get the workspace ID from the argument
WORKSPACE=$1

# Get all visible workspaces (one per monitor)
VISIBLE_WORKSPACES=$(aerospace list-workspaces --monitor all --visible)

# Check if this workspace is visible on any monitor
IS_VISIBLE=false
while IFS= read -r visible_ws; do
    if [ "$visible_ws" = "$WORKSPACE" ]; then
        IS_VISIBLE=true
        break
    fi
done <<< "$VISIBLE_WORKSPACES"

# Style based on visibility
if [ "$IS_VISIBLE" = "true" ]; then
    BG_COLOR="$ACCENT"
    LABEL_COLOR="0xff000000"
    BORDER_WIDTH=0
else
    BG_COLOR="0xff242936"
    LABEL_COLOR="0xff8a93a5"
    BORDER_WIDTH=1
fi

# Get list of apps in this workspace and create icon string
APPS=$(aerospace list-windows --workspace "$WORKSPACE" | awk -F'|' '{gsub(/^ *| *$/, "", $2); print $2}')

# Build icon string using the official icon mapping
ICONS=""
if [ -n "$APPS" ]; then
    while IFS= read -r app; do
        # Get the icon for this app using the official icon mapping
        __icon_map "$app"
        ICONS="$ICONS $icon_result"
    done <<< "$APPS"
fi

# Update sketchybar with workspace ID in icon and app icons in label
sketchybar --set "$NAME" \
    icon.color="$LABEL_COLOR" \
    label="$ICONS" \
    label.color="$LABEL_COLOR" \
    background.color="$BG_COLOR" \
    background.border_width="$BORDER_WIDTH" \
    background.border_color="$MUTED_ORANGE"
