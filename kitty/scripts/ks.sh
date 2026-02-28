#!/usr/bin/env bash

KITTY_BIN="/usr/bin/kitty"
SESSIONS_DIR="$HOME/.dotfiles/kitty/sessions"
SOCK_PATH=$(ls /tmp/kitty-* 2>/dev/null | head -n1)
SOCK="unix:$SOCK_PATH"

if [[ -z "$SOCK_PATH" ]]; then
    echo "Erreur : Socket Kitty non trouvé."
    exit 1
fi

while true; do
    # 1. Récupérer les onglets OUVERTS
    # On crée une ligne : ID|TITRE
    tabs_json=$($KITTY_BIN @ --to "$SOCK" ls)
    tabs_open=$(echo "$tabs_json" | jq -r '.[].tabs[] | "\(.id)|\(.title)"')
    open_names=$(echo "$tabs_json" | jq -r '.[].tabs[].title')

    # 2. Récupérer les fichiers de session et FILTRER
    list_to_show=""

    # Ajouter les sessions ouvertes à la liste
    while IFS='|' read -r id title; do
        if [[ -n "$id" ]]; then
            list_to_show+="$(printf "%-10s | \033[32m[OPEN]\033[0m   %s\n" "$id" "$title")\n"
        fi
    done <<< "$tabs_open"

    # Ajouter les fichiers non ouverts
    sessions_available=$(find "$SESSIONS_DIR" -name "*.kitty-session" -exec basename {} .kitty-session \;)
    for s in $sessions_available; do
        if ! echo "$open_names" | grep -q "^$s$"; then
            list_to_show+="$(printf "%-10s | \033[34m[LAUNCH]\033[0m %s\n" "FILE" "$s")\n"
        fi
    done

    # 3. Menu FZF
    # On affiche tout à partir de la deuxième colonne pour cacher l'ID/FILE
    out=$(echo -e "$list_to_show" | fzf --ansi --reverse \
        --header="ENTER: Switch/Launch | D: Fermer | ESC: Quitter" \
        --expect=d,enter)

    key=$(echo "$out" | head -n1)
    sel=$(echo "$out" | sed -n '2p')

    if [[ -z "$sel" ]]; then exit 0; fi

    # Extraction propre :
    # id_or_file est avant le premier '|'
    # name est après le dernier espace
    id_or_file=$(echo "$sel" | cut -d'|' -f1 | tr -d ' ')
    name=$(echo "$sel" | awk '{print $NF}')

    if [[ "$key" == "d" ]]; then
        if [[ "$id_or_file" != "FILE" ]]; then
            $KITTY_BIN @ --to "$SOCK" close-tab --match id:$id_or_file
        fi
        continue
    elif [[ "$key" == "enter" ]] || [[ -z "$key" ]]; then
        if [[ "$id_or_file" == "FILE" ]]; then
            # LANCEMENT : on ajoute l'extension et le chemin complet
            # On utilise 'action' pour être plus explicite
            "$KITTY_BIN" @ --to "$SOCK" action goto_session "$SESSIONS_DIR/$name.kitty-session"
        else
            # SWITCH
            "$KITTY_BIN" @ --to "$SOCK" focus-tab --match id:$id_or_file
        fi
        exit 0
    fi
  done
