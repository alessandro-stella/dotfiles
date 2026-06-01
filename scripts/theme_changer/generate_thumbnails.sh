#!/bin/bash

WALLPAPER_DIR="$HOME/.config/themes/wallpapers"
THUMB_DIR="$WALLPAPER_DIR/thumbnails"
THUMB_SIZE="320x180"
QUALITY=80

if [ ! -d "$WALLPAPER_DIR" ]; then
    echo "Error: Directory $WALLPAPER_DIR does not exist."
    exit 1
fi

mkdir -p "$THUMB_DIR"

mapfile -t WALLPAPERS < <(
    find "$WALLPAPER_DIR" -maxdepth 1 -type f \
    \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \)
)

declare -A WALL_NAMES
for FILE in "${WALLPAPERS[@]}"; do
    NAME="$(basename "$FILE")"
    WALL_NAMES["${NAME%.*}"]=1
done

mapfile -t THUMBS < <(find "$THUMB_DIR" -maxdepth 1 -type f -iname "*.png")
for THUMB in "${THUMBS[@]}"; do
    NAME="$(basename "$THUMB")"
    BASE="${NAME%.png}"
    if [ -z "${WALL_NAMES[$BASE]}" ]; then
        rm -f "$THUMB"
    fi
done

MISSING=()
for FILE in "${WALLPAPERS[@]}"; do
    NAME="$(basename "$FILE")"
    BASE="${NAME%.*}"
    THUMB_FILE="$THUMB_DIR/$BASE.png"
    if [ ! -f "$THUMB_FILE" ]; then
        MISSING+=("$FILE")
    fi
done

TOTAL_MISSING=${#MISSING[@]}
if [ "$TOTAL_MISSING" -eq 0 ]; then exit 0; fi

for FILE in "${MISSING[@]}"; do
    mogrify -path "$THUMB_DIR" \
            -thumbnail "$THUMB_SIZE^" \
            -gravity center \
            -extent "$THUMB_SIZE" \
            -quality "$QUALITY" \
            -format png \
            "$FILE"
done
