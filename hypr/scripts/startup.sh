#!/bin/sh
hyprctl dispatch exec [workspace 2 silent] kitty
#sleep 1
#hyprctl dispatch workspace 2
#hyprctl dispatch exec [workspace 2] brave
sleep 1
hyprctl dispatch workspace 5
#hyprctl dispatch exec [workspace 5] flatpak run com.discordapp.Discord
