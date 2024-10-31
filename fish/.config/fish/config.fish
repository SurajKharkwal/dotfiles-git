set -g fish_greeting ''

starship init fish | source

if not test -f /tmp/neofetch_shown
    # Show Neofetch if the file does not exist
    neofetch
    # Create the file to indicate Neofetch has been shown
    touch /tmp/neofetch_shown
end
alias nv="nvim"
alias lg="lazygit"

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH
