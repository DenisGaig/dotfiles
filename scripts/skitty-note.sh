#!/bin/bash

if hyprctl clients -j | grep -q '"class": "skitty-notes"'; then
    hyprctl dispatch closewindow class:skitty-notes
else
    export NEOVIM_MODE=skitty
    kitty --class skitty-notes nvim ~/brain/skitty-note.md &
fi
