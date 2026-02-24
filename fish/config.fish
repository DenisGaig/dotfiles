if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Propmt stylisé du terminal
starship init fish | source

# alias
alias ll="eza -lha --icons=auto --sort=name --group-directories-first"
alias ls="eza --icons=auto"
alias zed='zeditor'
alias code='code --enable-features=UseOzonePlatform --ozone-platform=wayland'

if not string match -q '*MX*' (cat /etc/os-release 2>/dev/null)
    and type -q neofetch      # s’assure que la commande existe
    neofetch
end

