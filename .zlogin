#!/bin/zsh

if [ "$(tty)" = "/dev/tty1" ] && which startx &> /dev/null; then
	config="$XDG_CONFIG_HOME"
	if [ -z "$config" ]; then
		config="$HOME/.config"
	fi
	mkdir --parents "$config/x11"

	data="$XDG_DATA_HOME"
	if [ -z "$data" ]; then
		data="$HOME/.local"
	fi
	mkdir --parents "$data/share/x11"

	exec startx "$config/x11/xinitrc" &> "$data/share/x11/startx.log"
fi
