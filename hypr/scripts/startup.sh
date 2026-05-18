#!/bin/sh

hyprctl dispatch 'hl.dsp.exec_cmd("[workspace 2 silent] kitty")'
hyprctl dispatch 'hl.dsp.exec_cmd("[workspace 3 silent] brave")'
sleep 3
hyprctl dispatch 'hl.dsp.focus({ workspace = 3 })'

# ==== A utiliser avec hyprland.conf ====
#hyprctl dispatch exec [workspace 2 silent] kitty
#hyprctl dispatch exec [workspace 3 silent] brave
#hyprctl dispatch exec [workspace 5 silent] io.github.aaddrick.claude-desktop-debian
#sleep 3
#hyprctl dispatch workspace 3
