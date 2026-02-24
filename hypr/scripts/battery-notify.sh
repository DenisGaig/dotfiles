#!/bin/bash

CRITICAL=15
NOTIFIED_FILE="/tmp/battery_notified"

while true; do
    CAPACITY=$(cat /sys/class/power_supply/BAT1/capacity)
    STATUS=$(cat /sys/class/power_supply/BAT1/status)

    if [[ "$STATUS" != "Charging" && "$CAPACITY" -le "$CRITICAL" ]]; then
        if [[ ! -f "$NOTIFIED_FILE" ]]; then
            notify-send -u critical -i battery-caution "Batterie critique" "Niveau : ${CAPACITY}% — Branchez le chargeur !"
            touch "$NOTIFIED_FILE"
        fi
    else
        rm -f "$NOTIFIED_FILE"
    fi

    sleep 60
done
