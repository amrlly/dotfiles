#!/bin/zsh

# Variables
export EDITOR=/usr/bin/nvim
export VISUAL=/usr/bin/nvim
export PAGER=/usr/bin/less
export BROWSER=/usr/bin/librewolf
export TERMINAL=/usr/bin/alacritty

# Xdg
export XDG_CURRENT_DESKTOP=AWESOME
export DE=awesome

# Qt
export QT_QPA_PLATFORMTHEME=qt5ct
export QT_STYLE_OVERRIDE=kvantum

# User dirs
if [ -f "$HOME/.config/user-dirs.dirs" ]; then
	export $(cut -d = -f 1 "$HOME/.config/user-dirs.dirs")
fi

# Path
if [ -d "$HOME/.local/bin" ]; then
	export PATH="$HOME/.local/bin:$PATH"
fi

# Scripts
if [ -d "$XDG_SCRIPTS_DIR" ]; then
	export PATH="$XDG_SCRIPTS_DIR:$PATH"
fi

# Fzf theme
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
    --color=fg:#e5e9f0,bg:#3b4252,hl:#81a1c1
    --color=fg+:#e5e9f0,bg+:#3b4252,hl+:#81a1c1
    --color=info:#eacb8a,prompt:#bf6069,pointer:#b48dac
    --color=marker:#a3be8b,spinner:#b48dac,header:#a3be8b'
