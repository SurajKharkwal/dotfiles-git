set -g fish_greeting ''

starship init fish | source

if not test -f /tmp/neofetch_flag.txt
    # Show Neofetch if the file does not exist
    neofetch
    # Create the file to indicate Neofetch has been shown
    touch /tmp/neofetch_flag.txt
end
alias nv="nvim"
alias lg="lazygit"
alias yy="yazi"

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH
