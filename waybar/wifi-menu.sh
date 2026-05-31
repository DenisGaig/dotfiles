#!/bin/bash
# Liste les réseaux disponibles et permet de s'y connecter via rofi

SELECTED=$(nmcli -t -f SSID,SIGNAL,SECURITY device wifi list | \
  awk -F: '{printf "%s\t(%s%%) %s\n", $1, $2, $3}' | \
  rofi -dmenu -p "󰤨  WiFi" -theme ~/.config/rofi/wifi-menu.rasi | \
  awk -F'\t' '{print $1}')

# Si l'utilisateur annule (Escape) dans rofi, on quitte immédiatement
if [ -z "$SELECTED" ]; then
  exit 0
fi

# Vérifier si déjà connu
KNOWN=$(nmcli -t -f NAME connection show | grep -x "$SELECTED")

if [ -n "$KNOWN" ]; then
  nmcli connection up "$SELECTED"
else
  PASSWORD=$(rofi -dmenu -p "󰌾  Mot de passe" -password -theme ~/.config/rofi/wifi-menu.rasi)
  nmcli device wifi connect "$SELECTED" password "$PASSWORD"

  # Si l'utilisateur annule la saisie du mot de passe
  if [ -z "$PASSWORD" ]; then
    exit 0
  fi
fi
