#!/usr/bin/env bash

main_note_dir=~/brain/daily

current_year=$(date +"%Y")
current_month_num=$(date +"%m")
current_month_abbr=$(date +"%b")
current_day=$(date +"%d")
current_weekday=$(date +"%A")

# Chemin de la note du jour
note_dir=${main_note_dir}/${current_year}/${current_month_num}-${current_month_abbr}
note_name=${current_year}-${current_month_num}-${current_day}-${current_weekday}
full_path=${note_dir}/${note_name}.md

if [ ! -d "$note_dir" ]; then
  mkdir -p "$note_dir"
fi

if [ ! -f "$full_path" ]; then
  cat <<EOF >"$full_path"
# ${note_name}
## Daily Note
EOF
fi

###############################################################################
#                      Daily note with Kitty Sessions
###############################################################################
kitty_sess_file="$HOME/.dotfiles/kitty/sessions/daily.kitty-session"

# Si la note d'aujourd'hui est déjà dans le fichier de session, on y saute
if grep -Fq "${note_name}.md" "$kitty_sess_file"; then
  kitten @ action goto_session "$kitty_sess_file"
  exit 0
fi

# Commande de lancement avec fish
launch_cmd="launch --title \"${note_name}\" fish -i -c 'nvim +cd\\\ \"${main_note_dir}\" +norm\\\ G \"${full_path}\"'"

# Mise à jour du fichier de session kitty
# awk lit le fichier ligne par ligne et modifie les lignes correspondantes
awk -v dir="$note_dir" -v launch="$launch_cmd" '
  /^# kitty_session_cd_line$/    { print; getline; print "cd " dir; next }
  /^# kitty_session_launch_line$/ { print; getline; print launch; next }
  { print }
' "$kitty_sess_file" >"${kitty_sess_file}.tmp" && mv "${kitty_sess_file}.tmp" "$kitty_sess_file"

# Fermeture de la session et réouverture de la session au cas où la session d'hier reste ouverte
kitten @ action close_session "$HOME/.dotfiles/kitty/sessions/daily.kitty-session"
sleep 0.5
kitten @ action goto_session "$kitty_sess_file"
