#!/usr/bin/env bash

sleep 5

waybar &

# initializing wallpaper daemon
wpaperd &

sleep 5

maestral_qt &

cryptomator &

dunst
