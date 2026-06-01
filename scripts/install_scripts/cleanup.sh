#!/usr/bin/env bash
# Cleanup script se l'utente decide di rimuovere il theme changer,
# mantenendo intatto l'ultimo tema generato e applicato.

CONFIG="$HOME/.config"

echo "Avvio la pulizia del Theme Changer..."

# Arresta i demoni ad esso associati
pkill awww-daemon || true

# Elimina la libreria degli sfondi scaricati (lo sfondo attuale è salvo in current_wallpaper)
rm -rf "$HOME/Pictures/wallpapers"

# Elimina i file temporanei e di cache generati dai nuovi script
rm -rf "$HOME/.cache/wallust"
rm -rf "$HOME/.cache/wallpaper_rofi"
rm -rf "$HOME/.cache/gif_preview"
rm -rf "$HOME/.cache/video_preview"

# Pulisce tutti i temi pre-generati tranne quello attualmente in uso
if [ -d "$CONFIG/themes" ]; then
    find "$CONFIG/themes" -mindepth 1 -maxdepth 1 -type d ! -name "current_wallpaper" -exec rm -rf {} +
fi

# Elimina i template originali dei vari moduli
rm -f "$CONFIG/waybar/template.css"
rm -f "$CONFIG/wlogout/template.css"
rm -f "$CONFIG/swaync/template.css"
rm -f "$CONFIG/oh-my-posh/themes/template.omp.json"
rm -f "$CONFIG/rofi/theme_changer.rasi"

# Rimuove il bind della tastiera da Hyprland
TARGET_FILE="$CONFIG/hypr/hyprland.conf"
if [ -f "$TARGET_FILE" ]; then
    sed -i "\|bind = $mainMod SHIFT, T, exec, sh $HOME/.config/scripts/theme_changer/theme_chooser.sh # Change theme based on wallpaper|d" "$TARGET_FILE"
fi

# Rimuove le dipendenze di pacman
for pkg in "${THEME_CHANGER_DEPENDENCIES_PACMAN[@]}"; do
    if pacman -Qi "$pkg" &>/dev/null; then
        sudo pacman -Rs --noconfirm "$pkg"
    fi
done

# Rimuove le dipendenze di yay
for pkg in "${THEME_CHANGER_DEPENDENCIES_YAY[@]}"; do
    if pacman -Qi "$pkg" &>/dev/null; then
        sudo -u "$USER_NAME" -H yay -R --noconfirm "$pkg"
    fi
done

# Rimuove la cartella degli script del Theme Changer
rm -rf "$CONFIG/scripts/$THEME_CHANGER_SCRIPTS"

# Rimuove le regole sudoers aggiunte durante l'installazione
if [ -f "$SUDOERS_FILE" ]; then
    sudo rm -f "$SUDOERS_FILE"
fi

echo "Pulizia completata! L'ultimo tema impostato resterà attivo nel sistema."
