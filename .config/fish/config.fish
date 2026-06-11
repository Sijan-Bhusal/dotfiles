# ┌──────────────────────────────────────────────┐
# │ Entry Point                                  │
# └──────────────────────────────────────────────┘
source ~/.config/fish/aliases.fish
source ~/.config/fish/env.fish

# ┌──────────────────────────────────────────────┐
# │ Shell Settings                               │
# └──────────────────────────────────────────────┘
set -g fish_greeting ""
export EDITOR="nvim"
export SUDO_EDITOR="$EDITOR"
export VISUAL="nvim"
export TERMINAL="kitty"
export BROWSER="brave"
export DO_NOT_TRACK=1
export MANPAGER="nvim +Man!"

# ┌──────────────────────────────────────────────┐
# │ Key Bindings                                 │
# └──────────────────────────────────────────────┘
fish_default_key_bindings

# ┌──────────────────────────────────────────────┐
# │ Tool Integrations                            │
# └──────────────────────────────────────────────┘
fzf --fish | source
zoxide init fish | source
starship init fish | source

# ┌──────────────────────────────────────────────┐
# │ User Paths                                   │
# └──────────────────────────────────────────────┘
fish_add_path ~/.local/bin


# Added by Antigravity CLI installer
set -gx PATH "$HOME/.local/bin" $PATH
