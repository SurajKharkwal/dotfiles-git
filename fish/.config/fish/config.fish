set -g fish_greeting ''

starship init fish | source

# Check if the flag file exists
if not test -f /tmp/neofetch_first_terminal.txt
    # Run Neofetch on the first terminal session after reboot or login
    neofetch
    # Create a flag file to track that Neofetch has been shown
    touch /tmp/neofetch_first_terminal.txt
end
function y
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    yazi $argv --cwd-file="$tmp"
    if set cwd (command cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
        builtin cd -- "$cwd"
    end
    rm -f -- "$tmp"
end
alias nv="nvim"
alias lg="lazygit"
alias yy="yazi"

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH
