#!/bin/bash

# === CONFIG ===
WALLPAPER_DIR="$HOME/Pictures/Wallpapers"
SYMLINK_PATH="$HOME/.config/hypr/current_wallpaper"

# Exit if directory doesn't exist or is empty
[ ! -d "$WALLPAPER_DIR" ] && echo "Error: Wallpaper directory not found: $WALLPAPER_DIR" && exit 1

cd "$WALLPAPER_DIR" || exit 1

# === Find image files (jpg, png, gif, jpeg) ===
shopt -s nullglob
IMAGES=(*.jpg *.jpeg *.png *.gif)
shopt -u nullglob

[ ${#IMAGES[@]} -eq 0 ] && echo "No wallpapers found in $WALLPAPER_DIR" && exit 1

# === Pick random wallpaper ===
SELECTED_WALL="${IMAGES[$RANDOM % ${#IMAGES[@]}]}"
SELECTED_PATH="$WALLPAPER_DIR/$SELECTED_WALL"

echo "Selected: $SELECTED_WALL"

# === SET WALLPAPER WITH MATUGEN ===
matugen image "$SELECTED_PATH"

# === UPDATE SYMLINK ===
mkdir -p "$(dirname "$SYMLINK_PATH")"
ln -sf "$SELECTED_PATH" "$SYMLINK_PATH"

echo "Wallpaper set and symlinked: $SELECTED_WALL"
