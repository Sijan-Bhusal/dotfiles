#!/bin/bash

# Terminal to use (change to 'alacritty' if preferred)
TERM="kitty"

# Window class/name to identify Cmus
CLASS="cmus"

# Check if Cmus terminal is already running
if pgrep -f "$TERM.*$CLASS" > /dev/null; then
    # If open, focus it
    hyprctl dispatch focuswindow "class:$CLASS"
else
    # If not, launch in new terminal with title/class
    $TERM --class "$CLASS" --title "Cmus" -e cmus &
fi
