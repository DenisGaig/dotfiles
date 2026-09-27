#!/usr/bin/env bash
#
# rofi-keybinds.sh
# Affiche dans rofi les keybinds Hyprland (via hyprctl -j) + les remaps
# clavier maintenus à la main (keyd, xkb, etc.)
#
# Dépendances : hyprctl, jq, rofi
#
# Astuce : pour avoir de vraies descriptions, préfère `bindd=` à `bind=`
# dans ta config Hyprland. Ex :
#   bindd = SUPER, Return, Ouvrir un terminal, exec, kitty
# hyprctl binds -j expose alors le champ "description".

set -euo pipefail

REMAPS_FILE="${HOME}/.config/keybinds/keybinds.txt"

# --- 1. Récupération des binds Hyprland ---------------------------------
# On privilégie "description" si présente (bindd=...), sinon on retombe
# sur "dispatcher arg" pour ne pas perdre les binds sans description.
hypr_binds=$(hyprctl binds -j | jq -r '
  .[] |
  ( [.modmask, .key, .keycode] | @tsv ) as $unused |
  ( if .description != "" and .description != null
      then .description
      else "\(.dispatcher) \(.arg)"
    end
  ) as $desc |
  ( (if .mouse then "MOUSE" else .key end) ) as $key |
  "\(.modmask | tostring)\t\($key)\t\($desc)"
')

# On reformate modmask (bitmask) en texte lisible (SUPER, SHIFT, CTRL, ALT)
format_mods() {
    local mask=$1
    local mods=()
    ((mask & 64)) && mods+=("SUPER")
    ((mask & 1)) && mods+=("SHIFT")
    ((mask & 4)) && mods+=("CTRL")
    ((mask & 8)) && mods+=("ALT")
    local IFS='+'
    echo "${mods[*]:-—}"
}

formatted_binds=""
while IFS=$'\t' read -r mask key desc; do
    mods=$(format_mods "$mask")
    formatted_binds+="[Hyprland] ${mods} + ${key}  →  ${desc}"$'\n'
done <<<"$hypr_binds"

# --- 2. Remaps clavier (maintenus à la main) ------------------------------
formatted_remaps=""
if [[ -f "$REMAPS_FILE" ]]; then
    while IFS= read -r line; do
        [[ -z "$line" || "$line" == \#* ]] && continue
        formatted_remaps+="${line}"$'\n'
    done <"$REMAPS_FILE"
fi

# --- 3. Affichage rofi -----------------------------------------------------
{
    printf '%s' "$formatted_binds"
    printf '%s' "$formatted_remaps"
} | rofi -dmenu -i -p "Keybinds" -no-custom -markup-rows -theme rofi-keybinds
