#!/usr/bin/env bash

INITIAL_CLASS=$(hyprctl activewindow -j | jq -r '.initialClass')

if [[ "$INITIAL_CLASS" == steam_app_* ]]; then
    exit 0
fi

hyprctl dispatch killactive
