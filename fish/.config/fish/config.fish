
# Greeting
set -g fish_greeting ''

# Exported Variables
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

# Starship Prompt
starship init fish | source
# Zoxide Initialization
zoxide init fish | source

# Vi Mode Configuration
set fish_cursor_insert line
set fish_cursor_default block
set fish_cursor_replace_one underscore
set fish_cursor_replace underscore
set fish_cursor_external line
set fish_cursor_visual block
set -g fish_escape_delay_ms 100
bind -M insert -m default jk cancel repaint-mode

if status is-interactive
  if not set -q TMUX
    if not tmux has-session -t workspace 2>/dev/null
      tmux new-session -d -s workspace
    end
    if not tmux list-sessions | grep -q "^workspace.*(attached)"
      tmux attach-session -t workspace
    end
  end
end

# Aliases
alias nv="nvim"
alias cl="clear"
alias lg="lazygit"
alias yy="yazi"
alias et="exit"
alias run="~/.config/hypr/Scripts/run-program.sh"

# Yazi Function
function y
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    yazi $argv --cwd-file="$tmp"
    if set cwd (command cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
        builtin cd -- "$cwd"
    end
    rm -f -- "$tmp"
end

# Fish Startup Logic (neofetch display only once per reboot)
if status is-interactive
  if not test -f /tmp/fish_statup
    neofetch
    touch /tmp/fish_statup
  end
end
