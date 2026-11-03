# === Fichier de configuration de nnn avec passage de variables dans fish ====

# ---- Plugins ----
# - o : fzopen : ouvre un fzf dans le dossier pour éditer
# - c : fzcd : Recherche floue de plusieurs dirs (ou $PWD) et visite de fichier
# - j : autojump : utilise zoxide pour aller rapidement aux dossiers populaires
# - p : preview-tui : affiche le contenu des fichiers et des dossiers avec tree
# - i : imgview : affiche les images avec nsxiv
# - n : nuke : ouvre le contenu des fichiers avec xdg-open
# - y : .cbcp : copie le chemin dans le clipboard

set -gx NNN_PLUG 'o:fzopen;c:fzcd;j:autojump;p:preview-tui;i:imgview;n:nuke;y:.cbcp'

# ---- Bookmarks : taper b+d ou t ou ... pour aller directement au dossier ----
set -gx NNN_BMS 'd:~/Documents;t:~/Téléchargements;p:/data/projets;c:~/.config'

# ---- Variables ----
set -gx NNN_FIFO '/tmp/nnn.fifo'
set -gx NNN_SEL "$HOME/.config/nnn/.selection"
set -gx EDITOR nvim

# ---- Couleurs Dracula ----
set -gx NNN_FCOLORS "D4DEB778E79F9F67D2E5E5D2"

set -gx NNN_TMPFILE "$HOME/.config/nnn/.lastd" # fichier de sauvegarde pour pouvoir quitter et revenir plus tard

# ===== Lancement de nnn =========
function n
    nnn -e $argv
    if test -f "$NNN_TMPFILE"
        source "$NNN_TMPFILE"
        rm -f "$NNN_TMPFILE"
    end
end
