#!/bin/sh

if [ "$(envycontrol --query)" = "nvidia" ]; then
	xrandr --setprovideroutputsource modesetting NVIDIA-0
	xrandr --auto
fi
