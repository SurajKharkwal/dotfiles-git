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
# Only proceed if not already inside a tmux session
if not set -q TMUX
    # Check if the "workspace" session exists and if it's detached
    if not tmux has-session -t workspace 2>/dev/null
        # Create the "workspace" session if it doesn't exist
        tmux new-session -d -s workspace
    else if tmux list-sessions | grep -q "^workspace.*(attached)"
        # Do nothing if the "workspace" session is already attached elsewhere
    else
        # Attach to "workspace" if it's detached
        tmux attach-session -t workspace
    end
end

alias nv="nvim"
alias lg="lazygit"
alias yy="yazi"

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH
