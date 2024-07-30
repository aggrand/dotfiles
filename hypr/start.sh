#!/usr/bin/env bash
waybar &

# initializing wallpaper daemon
wpaperd &

sleep 5

maestral_qt &

cryptomator &

dunst
