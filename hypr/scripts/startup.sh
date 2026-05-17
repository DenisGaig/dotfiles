#!/bin/sh
hyprctl dispatch exec [workspace 2 silent] kitty
hyprctl dispatch exec [workspace 3 silent] brave
#hyprctl dispatch exec [workspace 5 silent] io.github.aaddrick.claude-desktop-debian

sleep 3
hyprctl dispatch workspace 3
