#!/usr/bin/env bash

# Check if Leader Key has any visible windows
# (Leader Key uses non-activating panels, so it's never "frontmost")
HAS_WINDOWS=$(osascript -e 'tell application "System Events" to get (count (windows of process "Leader Key" whose visible is true)) > 0' 2>/dev/null)

if [ "$HAS_WINDOWS" = "true" ]; then
    # Leader Key is active - bright accent border
    sketchybar --set status_bracket \
        background.border_color=0xffffcc66 \
        background.border_width=3
else
    # Leader Key not active - muted border
    sketchybar --set status_bracket \
        background.border_color=0x80ffa659 \
        background.border_width=2
fi
