# Options globales SANS preview
set -gx FZF_DEFAULT_OPTS "--layout=reverse --border --height 70% --preview-window 'right:50%:wrap'"

# -- fd comme source --
set -gx FZF_DEFAULT_COMMAND "fd --type f --hidden --exclude .git"
set -gx FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"

# -- Previews spécifiques: eza pour dossiers, bat pour fichiers --
set show_file_or_dir_preview "if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi"

set -gx FZF_CTRL_T_OPTS "--preview 'bash -c \"$show_file_or_dir_preview\"'"
set -gx FZF_ALT_C_OPTS "--preview 'eza --tree --color=always {} | head -200'"

# ============ Functions tournant avec fzf ===========
# équivalent de `tv env`
function fenv --description "Parcourir les variables d'environnement"
    env | sort | fzf
end

# équivalent de `tv text` (live grep)
function ftext --description "Recherche de texte en direct (rg + fzf)"
    set -l rg "rg --line-number --no-heading --color=always --smart-case"
    fzf --ansi --disabled --query "$argv" --delimiter : \
        --bind "start:reload:$rg {q} || true" \
        --bind "change:reload:$rg {q} || true" \
        --preview 'bat --color=always --highlight-line {2} {1}' \
        --preview-window 'right:60%:+{2}/2' \
        --bind 'enter:become($EDITOR {1} +{2})'
end

# rg produit des lignes au format fichier:numeroLigne:texte (grâce à --line-number). Le --delimiter : fait donc :
# {1} = le chemin du fichier
# {2} = le numéro de ligne du match
# {3} = le texte de la ligne

#- Dans fzf, --bind signifie lier/associer. C'est le raccourci clavier ou l'événement à une action : --bind "ÉVÉNEMENT:ACTION".
#- Événement à gauche du : : start, change, enter, ou une touche classique (ctrl-k, double-click, etc.).
#- Action à droite : ce que fzf exécute quand l'événement se produit (reload:..., become(...), up, abort, etc.).

#Exemple de la fonction : --bind "change:reload:$rg {q} || true" se lit "à
#chaque changement de requête (change), recharge la liste en exécutant rg avec
#la requête actuelle".


# ======== Pacman et Yay ========
function pin --description "Installer des paquets (pacman + fzf)"
    pacman -Slq | fzf -q "$argv" -m --select-1 --preview 'pacman -Si {1}' \
        | xargs -ro sudo pacman -S
end

function pre --description "Supprimer des paquets (pacman + fzf)"
    pacman -Qqe | fzf -q "$argv" -m --preview 'pacman -Qi {1}' \
        | xargs -ro sudo pacman -Rns
end

function yin --description "Installer des paquets (yay + fzf)"
    yay -Slq | fzf -q "$argv" -m --preview 'yay -Si {1}' | xargs -ro yay -S
end

function yre --description "Supprimer des paquets (yay + fzf)"
    yay -Qqm | fzf -q "$argv" -m --preview 'yay -Qi {1}' | xargs -ro yay -Rns
end
