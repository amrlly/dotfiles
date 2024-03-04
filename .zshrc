#!/bin/zsh

# Histrory
HISTFILE=~/.zhistory
HISTSIZE=1000
SAVEHIST=1000

# Disable beep
unsetopt beep

# Vi mode
bindkey -v
KEYTIMEOUT=1

# Keybindings
bindkey "^?" backward-delete-char
bindkey "^H" backward-delete-word

bindkey "^[[3~" delete-char
bindkey "^[[3;5~" delete-word

bindkey "^[[1;5D" backward-word
bindkey "^[[1;5C" forward-word

bindkey "^[[1~" beginning-of-line
bindkey "^[[H" beginning-of-line

bindkey "^[[4~" end-of-line
bindkey "^[[F" end-of-line

# Completions
autoload -U compinit
zstyle ":completion:*" menu select
compinit

# Prompt
autoload -U colors && colors
setopt promptsubst

PROMPT="%{$fg[blue]%}%~ %{$fg[yellow]%}%n %{$fg[green]%}%#%{$reset_color%} "

# Alises
alias dot="git --git-dir=$HOME/.dotfiles --work-tree=$HOME"
alias ls='ls --color=auto'
alias la='ls -lavh --color=auto --group-directories-first'
alias tree='tree -C'
alias sush='sudo --preserve-env=HOME --shell'
alias bless='bat --paging=always --style=plain'

# Zoxide
eval "$(zoxide init zsh)"
