set -g fish_greeting ''

#Starship Theme
starship init fish | source
#Zoxide
zoxide init fish | source

#Vi Mode
set fish_cursor_insert line
set fish_cursor_default block
set fish_cursor_replace_one underscore
set fish_cursor_replace underscore
set fish_cursor_external line
set fish_cursor_visual block
set -g fish_escape_delay_ms 100
bind -M insert -m default jk cancel repaint-mode

# Tmux auto-start
if not set -q TMUX
    if not tmux has-session -t workspace 2>/dev/null
        tmux new-session -d -s workspace
    else if tmux list-sessions | grep -q "^workspace.*(attached)"
    else
        tmux attach-session -t workspace
    end
end

#Yazi requirement
function y
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    yazi $argv --cwd-file="$tmp"
    if set cwd (command cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
        builtin cd -- "$cwd"
    end
    rm -f -- "$tmp"
end

#Alias
alias nv="nvim"
alias lg="lazygit"
alias yy="yazi"
alias work="cd ~/dev-projects && ls"
alias run="~/.config/hypr/Scripts/run-program.sh"

#Nefetch for First fish instance
if not test -f /tmp/neofetch_first_terminal.txt
    echo " "
    neofetch
    touch /tmp/neofetch_first_terminal.txt
end

set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

