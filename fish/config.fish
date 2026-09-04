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

# alias de sécurité
alias rm="rm -I --preserve-root"
alias chown="chown --preserve-root"
alias chmod="chmod --preserve-root"
alias chgrp="chgrp --preserve-root"

alias nv="nvim"
alias za="zathura"
#alias nvim-pack="NVIM_APPNAME=nvim-pack nvim" # variable pour changer les chemins XDG pour nvim-pack

# Git alias
alias g="git"
alias gl="git log"
alias gs="git status"
alias ga="git add"
alias gc="git commit"
alias gpu="git push"
alias gpl="git pull"
alias gd="git diff"
alias gco="git checkout"
alias gb="git branch"
alias gf="git fetch"
alias gm="git merge"


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
bind --erase \cr # désactive la commande par défaut Ctrl+R pour cellede Atuin
bind --erase -M insert \cr

# Options globales SANS preview
set -gx FZF_DEFAULT_OPTS "--preview-window 'right:50%:wrap'"

# -- fd comme source --
set -gx FZF_DEFAULT_COMMAND "fd --type f --hidden --exclude .git"
set -gx FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"

# -- Previews spécifiques: eza pour dossiers, bat pour fichiers --
set show_file_or_dir_preview "if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi"

set -gx FZF_CTRL_T_OPTS "--preview 'bash -c \"$show_file_or_dir_preview\"'"
set -gx FZF_ALT_C_OPTS "--preview 'eza --tree --color=always {} | head -200'"

# ==== ZOXIDE ET ATUIN ==========
zoxide init fish | source
atuin init fish | source

# ======= PATH NPM ET PNPM ==========
# pnpm
set -gx PNPM_HOME "/home/denis/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end
set -x PATH ~/.npm-global/bin $PATH

# ===== MISE (gestionnaire de version node, pnpm...) =====
mise activate fish | source

# ===== CONFIG DE LIBVIRT pour les VMs ======
set -gx LIBVIRT_DEFAULT_URI qemu:///system
