#!/bin/bash

# Fonction pour obtenir le premier lecteur actif
getActivePlayer() {
  # Liste tous les lecteurs disponibles
  players=$(playerctl -l 2>/dev/null)
  
  # Priorité : Spotify > YouTube Music (brave) > autres
  if echo "$players" | grep -q "^spotify$"; then
    echo "spotify"
  elif echo "$players" | grep -q "^brave"; then
    echo "$players" | grep "^brave" | head -n 1
  else
    # Retourne le premier lecteur disponible
    echo "$players" | head -n 1
  fi
}

getTitle() {
  PLAYER=$(getActivePlayer)
  
  if [ -z "$PLAYER" ]; then
    echo "Aucun lecteur"
    exit 0
  fi
  
  # Choisir l'icône selon le lecteur
  if [[ "$PLAYER" == "spotify" ]]; then
    ICON=""
  elif [[ "$PLAYER" == brave* ]]; then
    ICON=""
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