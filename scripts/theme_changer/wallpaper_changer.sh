#!/bin/bash
set -euo pipefail

SELECTED_IMAGE="$1"
THEME_DIR="$2"
CURRENT_DIR="$HOME/.config/themes/current_wallpaper"
BLUR_LEVEL="0x12"

REQUIRED_FILES=(
    "blurred.png"
    "wlogout_style.css"
    "dynamic-border.lua"
    "waybar.css"
    "swaync.css"
    "current_theme.omp.json"
    "colors-kitty.conf"
    "colors.json"
    "colors-rofi.rasi"
)

mkdir -p "$CURRENT_DIR" "$THEME_DIR"

is_theme_complete() {
    for file in "${REQUIRED_FILES[@]}"; do
        if [ ! -f "$THEME_DIR/$file" ]; then
            return 1
        fi
    done
    return 0
}

if is_theme_complete; then
    echo "Theme found, copying existing files..."
else 
    notify-send -i "$SELECTED_IMAGE" -u low 'Building theme...' "Wallpaper: $(basename "$SELECTED_IMAGE")"
    echo "Incomplete or missing theme, building needed files..."
    
    for cmd in magick awww bc; do
        if ! command -v "$cmd" &>/dev/null; then
            echo "Error: '$cmd' is not installed."
            exit 1
        fi
    done

    if ! awww query &>/dev/null; then
        awww-daemon &
        sleep 0.5
    fi

    PALETTE_SCRIPT="$(dirname "$0")/palette_changer.sh"
    "$PALETTE_SCRIPT" "$SELECTED_IMAGE" "$THEME_DIR"

    echo "Genating blurred wallpaper..."
    magick "$SELECTED_IMAGE" -resize 1920x1080^ -gravity center -extent 1920x1080 -blur "$BLUR_LEVEL" "$THEME_DIR/blurred.png"
fi

echo "Applying theme files..."
cp "$SELECTED_IMAGE" "$CURRENT_DIR/wallpaper.png"
cp "$THEME_DIR/blurred.png" "$CURRENT_DIR/blurred.png"
cp "$THEME_DIR/wlogout_style.css" "$HOME/.config/wlogout/style.css"
cp "$THEME_DIR/dynamic-border.lua" "$HOME/.config/hypr/modules/dynamic-border.lua"
cp "$THEME_DIR/waybar.css" "$HOME/.config/waybar/style.css"
cp "$THEME_DIR/swaync.css" "$HOME/.config/swaync/style.css"
cp "$THEME_DIR/current_theme.omp.json" "$HOME/.config/oh-my-posh/themes/current_theme.omp.json"
cp "$THEME_DIR/colors-rofi.rasi" "$HOME/.config/rofi/colors.rasi"
cp "$THEME_DIR/colors-kitty.conf" "$HOME/.config/kitty/colors-kitty.conf"

RAND_X=$(echo "scale=2; $((RANDOM % 101)) / 100" | bc)
RAND_Y=$(echo "scale=2; $((RANDOM % 101)) / 100" | bc)

awww img "$SELECTED_IMAGE" \
    --transition-type grow \
    --transition-pos "$RAND_X,$RAND_Y" \
    --transition-step 90 \
    --transition-fps 60 \
    --transition-duration 1.5

if sudo -n cp "$CURRENT_DIR/blurred.png" "/usr/share/sddm/themes/pixie/assets/wallpaper.png" 2>/dev/null; then
    echo "SDDM wallpaper updated."
else
    echo "SDDM update skipped."
fi

hyprctl reload
pkill -x waybar && waybar &
swaync-client -R && swaync-client -rs

killall -SIGUSR1 kitty || true

echo "Wallpaper update process completed!"
