if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Remove the gretting message.
set -U fish_greeting

# Color theme.
fish_config theme choose "Dracula Official"

# Propmt stylisé du terminal
starship init fish | source

# alias
alias ll="eza -lha --icons=auto --sort=name --group-directories-first"
alias ls="eza --icons=auto"
alias zed='zeditor'
alias nv="nvim"
alias ks="~/.dotfiles/kitty/scripts/ks.sh"
alias wall='~/.dotfiles/hypr/scripts/random-wallpaper.sh'
alias ya="yazi"

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

# NEOFETCH n'est plus maintenu: script perso pour le remplacer
#if status is-interactive && test -z "$FZF_PREVIEW_COLUMNS"
#    /usr/local/bin/motd
#end

# ============ FZF ===========

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
