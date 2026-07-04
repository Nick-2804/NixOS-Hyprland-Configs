#!/bin/bash

THEMES_DIR="$HOME/.config/scripts"

theme=$(
    find "$THEMES_DIR" -maxdepth 1 -type f -name "*.sh" \
    -printf "%f\n" |
    sed 's/\.sh$//' |
    sort |
    walker --dmenu
)

[ -n "$theme" ] && bash "$THEMES_DIR/$theme.sh"
