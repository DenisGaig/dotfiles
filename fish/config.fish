if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Remove the gretting message.
set -U fish_greeting

# Color theme.
fish_config theme choose "Dracula Official"

# Propmt stylisé du terminal
starship init fish | source

# Couleurs dans man
set -gx GROFF_NO_SGR 1
set -gx MANPAGER "less -R --use-color -Dd+172 -Du+175"

# alias
alias ll="eza -lha --icons=auto --sort=name --group-directories-first"
alias ls="eza --icons=auto"
alias lt="eza --tree --level=2 --long --icons --git"
alias zed='zeditor'
alias ks="~/.dotfiles/kitty/scripts/ks.sh"
alias wall='~/.dotfiles/hypr/scripts/random-wallpaper.sh'
alias ya="yazi"
alias mkdir="mkdir -pv"
alias mv="mv -iv"
alias ln="ln -iv"
alias ..="cd .."
alias ...="cd ../../.."
alias ....="cd ../../../.."
alias cd..="cd .."
alias cp="cp -iv"

# alias pour le fuzzy finder tv
alias tvd='cd (tv dirs)'
alias tvf='nv (tv files)'
alias tvt='nv (tv text)'

# alias de sécurité
alias rm="rm -I --preserve-root"
alias chown="chown --preserve-root"
alias chmod="chmod --preserve-root"
alias chgrp="chgrp --preserve-root"

alias nv="nvim"
alias za="zathura"
#alias nvim-pack="NVIM_APPNAME=nvim-pack nvim" # variable pour changer les chemins XDG pour nvim-pack

# alias youtube à utilser avec ytmp3 'url'
alias yt='yt-dlp -x --audio-format mp3 --embed-metadata --embed-thumbnail --sleep-requests 1 --sleep-interval 5 --cookies-from-browser firefox -o "/data/storage/musique/%(title)s.%(ext)s"'

# Git alias
alias g="git"
alias gl="git log"
alias gs="git status"
alias ga="git add"
alias gc="git commit -m"
alias gpu="git push"
alias gpl="git pull"
alias gd="git diff"
alias gco="git checkout"
alias gb="git branch"
alias gf="git fetch"
alias gm="git merge"
alias gremo="git remote -v"

# Connexion ssh vers Dell ~/projets
function p
    ssh dell -t "cd ~/projets/$argv[1] && nvim"
end

abbr reload 'source ~/.dotfiles/fish/config.fish'

# NEOFETCH n'est plus maintenu: script perso pour le remplacer
#if status is-interactive && test -z "$FZF_PREVIEW_COLUMNS"
#    /usr/local/bin/motd
#end

# ============ FZF ===========
# Utilise CTRL+T pour rechercher des fichiers
# et ATL+C pour rechercher des dossiers et fait automatiquement cd dossier
# =================================

fzf --fish | source
bind --erase \cr # désactive la commande par défaut Ctrl+R pour celle de Atuin
bind --erase -M insert \cr

# => Suite de la configuration de fzf dans ~/.config/fish/conf.d/fzf.fish

# ==== ZOXIDE ET ATUIN ==========
zoxide init fish | source
atuin init fish | source

# tv init fish | source # active television tv (fuzzy finder) avec ctrl+t à la place de fzf

# ===== MISE (gestionnaire de version node, pnpm...) =====
mise activate fish | source

# ======= PATH NPM ET PNPM ==========
# pnpm
set -gx PNPM_HOME "/home/denis/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end
set -x PATH ~/.npm-global/bin $PATH

# ===== CONFIG DE LIBVIRT pour les VMs ======
set -gx LIBVIRT_DEFAULT_URI qemu:///system
