#!/bin/bash
# Liste les réseaux disponibles et permet de s'y connecter via rofi

#SELECTED=$(nmcli --fields SSID,SIGNAL,SECURITY -t device wifi list --rescan no | \
#  awk -F: '{printf "%s\t(%s%%) %s\n", $1, $2, $3}' | \
#  rofi -dmenu -p "󰤨  WiFi" -theme ~/.config/rofi/wifi-menu.rasi | \
#  awk '{print $1}')

SELECTED=$(nmcli -t -f SSID,SIGNAL,SECURITY device wifi list | \
  awk -F: '{printf "%s\t(%s%%) %s\n", $1, $2, $3}' | \
  rofi -dmenu -p "󰤨  WiFi" -theme ~/.config/rofi/wifi-menu.rasi | \
  awk '{print $1}')


# Vérifier si déjà connu
KNOWN=$(nmcli -t -f NAME connection show | grep -x "$SELECTED")

if [ -n "$KNOWN" ]; then
  nmcli connection up "$SELECTED"
else
  PASSWORD=$(rofi -dmenu -p "󰌾  Mot de passe" -password -theme ~/.config/rofi/wifi-menu.rasi)
  nmcli device wifi connect "$SELECTED" password "$PASSWORD"
fi
