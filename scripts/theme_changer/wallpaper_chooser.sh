#!/bin/bash
set -euo pipefail
LOG_FILE="/tmp/wallpaper_script.log"
exec >"$LOG_FILE" 2>&1

SELECTED_IMAGE="$1"
THEME_DIR="$2"
CURRENT_DIR="$HOME/.config/themes/current_wallpaper"
BLUR_LEVEL="0x12"

REQUIRED_FILES=(
    "blurred.png"
    "wlogout_style.css"
    "dynamic-border.conf"
    "waybar.css"
    "swaync.css"
    "current_theme.omp.json"
    "colors-kitty.conf"
    "colors.json"
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
    echo "Tema completo trovato. Utilizzo i file esistenti."
else
    echo "Tema incompleto o mancante. Inizio rigenerazione..."
    
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

    # 1. Genera palette e tutti i file CSS/JSON/CONF dentro THEME_DIR
    PALETTE_SCRIPT="$(dirname "$0")/palette_changer.sh"
    "$PALETTE_SCRIPT" "$SELECTED_IMAGE" "$THEME_DIR"

    # 2. Genera il blurred wallpaper
    echo "Generazione blurred wallpaper..."
    magick "$SELECTED_IMAGE" -resize 1920x1080^ -gravity center -extent 1920x1080 -blur "$BLUR_LEVEL" "$THEME_DIR/blurred.png"
fi

# A questo punto i file in THEME_DIR ci sono sicuramente. Li copiamo nelle directory di sistema.
echo "Applico i file del tema..."
cp "$SELECTED_IMAGE" "$CURRENT_DIR/wallpaper.png"
cp "$THEME_DIR/blurred.png" "$CURRENT_DIR/blurred.png"
cp "$THEME_DIR/wlogout_style.css" "$HOME/.config/wlogout/style.css"
cp "$THEME_DIR/dynamic-border.conf" "$HOME/.config/hypr/dynamic-border.conf"
cp "$THEME_DIR/waybar.css" "$HOME/.config/waybar/style.css"
cp "$THEME_DIR/swaync.css" "$HOME/.config/swaync/style.css"
cp "$THEME_DIR/current_theme.omp.json" "$HOME/.config/oh-my-posh/themes/current_theme.omp.json"

# --- MODIFICA: Copia il file per Kitty ---
mkdir -p "$HOME/.config/kitty"
cp "$THEME_DIR/colors-kitty.conf" "$HOME/.config/kitty/colors-kitty.conf"
# ----------------------------------------

# Transizione sfondo
RAND_X=$(echo "scale=2; $((RANDOM % 101)) / 100" | bc)
RAND_Y=$(echo "scale=2; $((RANDOM % 101)) / 100" | bc)

awww img "$SELECTED_IMAGE" \
    --transition-type grow \
    --transition-pos "$RAND_X,$RAND_Y" \
    --transition-step 90 \
    --transition-fps 60 \
    --transition-duration 1.5

# Riavvio/Ricaricamento dei servizi
if sudo -n cp "$CURRENT_DIR/blurred.png" "/usr/share/sddm/themes/pixie/assets/wallpaper.png" 2>/dev/null; then
    echo "SDDM wallpaper updated."
else
    echo "SDDM update skipped."
fi

hyprctl reload
pkill -x waybar && waybar &
swaync-client -R && swaync-client -rs

# Ricarica i colori di Kitty al volo se ci sono terminali aperti
killall -SIGUSR1 kitty || true

notify-send -i "$SELECTED_IMAGE" -u low "Wallpaper Changed" "Theme: $(basename "$THEME_DIR")"
echo "Wallpaper update process completed!"
