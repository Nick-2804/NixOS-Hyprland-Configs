#!/bin/bash

echo "Before using this script make sure you installed all the needed pkgs"
echo "Those pkgs are: hyprland, kitty, starship, fish, dunst, waybar, yazi, and walker"

required=(
    hyprland
    kitty
    fish
    dunst
    waybar
    yazi
    walker
    starship
)

missing=0

for pkg in "${required[@]}"; do
    if ! command -v "$pkg" &>/dev/null; then
        echo "Missing: $pkg"
        missing=1
    fi
done

if [[ $missing -eq 1 ]]; then
    echo "Install the missing packages before running this script."
    exit 1
fi

for dir in hypr kitty fish dunst waybar walker yazi environment.d; do
    if [[ -e ~/.config/$dir ]]; then
        mv ~/.config/$dir "$backup/"
    fi
done

mkdir -p ~/Pictures
mkdir -p ~/.config

mv Wallpapers ~/Pictures

mv colorschemes ~/.config
mv dunst ~/.config
mv environment.d ~/.config
mv fish ~/.config
mv hypr ~/.config
mv kitty ~/.config
mv scripts ~/.config
mv walker ~/.config
mv waybar ~/.config
mv yazi ~/.config


