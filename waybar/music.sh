#!/bin/bash

# Fonction pour obtenir le premier lecteur actif
# getActivePlayer() {
#     players=$(playerctl -l 2>/dev/null)
#
#     if echo "$players" | grep -q "^mpd$"; then
#         echo "mpd"
#     elif echo "$players" | grep -q "^brave"; then
#         brave_instance=$(echo "$players" | grep "^brave" | head -n 1)
#         # Vérifie que Brave joue réellement quelque chose
#         if playerctl -p "$brave_instance" status 2>/dev/null | grep -q "Playing"; then
#             echo "$brave_instance"
#         fi
#
#     else
#         # Retourne le premier lecteur disponible
#         echo "$players" | head -n 1
#     fi
# }

getActivePlayer() {
    # Liste tous les lecteurs disponibles
    players=$(playerctl -l 2>/dev/null)

    # Priorité 1 : n'importe quel lecteur en Playing, dans l'ordre mpd > brave > autres
    for p in mpd $(echo "$players" | grep "^brave") $(echo "$players" | grep -v "^mpd$" | grep -v "^brave"); do
        if playerctl -p "$p" status 2>/dev/null | grep -q "Playing"; then
            echo "$p"
            return
        fi
    done

    # Priorité 2 : aucun ne joue, on prend le premier dispo
    echo "$players" | head -n 1
}

getTitle() {
    PLAYER=$(getActivePlayer)

    if [ -z "$PLAYER" ]; then
        echo "Aucun lecteur"
        exit 0
    fi

    # Choisir l'icône selon le lecteur
    if [[ "$PLAYER" == brave* ]]; then
        ICON="🎸"
    elif [[ "$PLAYER" == mpd* ]]; then
        ICON="🎙️"
    else
        ICON=""
    fi

    # Récupère le titre, supprime les emojis avec perl, puis ajoute l'icône
    TITLE=$(playerctl -p "$PLAYER" metadata --format "{{ artist }} - {{ title }}" 2>/dev/null | perl -CS -pe 's/\p{So}//g' | xargs -0 echo)

    if [ -n "$TITLE" ]; then
        echo "${ICON} ${TITLE}"
    else
        echo "Aucune lecture"
    fi
}

isPlaying() {
    PLAYER=$(getActivePlayer)

    if [ -z "$PLAYER" ]; then
        exit 1
    fi

    status=$(playerctl -p "$PLAYER" metadata --format '{{status}}' 2>/dev/null)

    if [ "${status}" = "Playing" ]; then
        echo "$status"
        exit 0
    fi

    exit 1
}

togglePlay() {
    PLAYER=$(getActivePlayer)

    if [ -z "$PLAYER" ]; then
        exit 1
    fi

    playerctl -p "$PLAYER" play-pause
}

case "$1" in
--title)
    getTitle
    ;;
--isPlaying)
    isPlaying
    ;;
--toggle)
    togglePlay
    ;;
*)
    echo "Usage: $0 {--title|--isPlaying|--toggle}"
    exit 1
    ;;
esac
