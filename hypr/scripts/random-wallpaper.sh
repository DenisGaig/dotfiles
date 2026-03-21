#!/usr/bin/env bash

WALLPAPER_DIR="$HOME/Images/wallpaper"
CONF="$HOME/.config/hypr/hyprpaper.conf"

# Choisit un fichier aléatoire pour chaque moniteur
WP1=$(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" \) | shuf -n1)
WP2=$(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" \) | shuf -n1)

# Réécrit le fichier de conf
cat > "$CONF" <<EOF
preload = $WP1
preload = $WP2

wallpaper {
    monitor = eDP-1
    path = $WP1
    fit_mode = cover
}

wallpaper {
    monitor = HDMI-A-2
    path = $WP2
    fit_mode = cover
}
EOF

# Installation de paywall: sudo pacman -S python-pywal
# Lance paywall pour adapter les couleurs de waybar sur le wallpaper
wal -i "$WP1" -n -q -s
killall -SIGUSR2 waybar  # Cette ligne force Waybar à relire son CSS sans redémarrer Hyprland

# 1. On tue proprement ET radicalement toute instance existante
killall -9 hyprpaper 2>/dev/null

# 2. On attend un tout petit peu que le port graphique se libère
sleep 0.2

# 3. On lance la nouvelle instance en redirigeant les erreurs pour nettoyer ton terminal
hyprpaper > /dev/null 2>&1 &
