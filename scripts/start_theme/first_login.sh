#!/bin/bash

FLAG="$HOME/.first-login"

[[ -f "$FLAG" ]] || exit 0

rm "$FLAG"
sleep 3
bash ~/.config/scripts/electric-theme.sh
