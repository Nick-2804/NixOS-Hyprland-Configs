#!/bin/bash

set -e

# Always use the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR"

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

# Create a timestamped backup directory
backup="$HOME/.config-backup-$(date +%Y%m%d-%H%M%S)"
mkdir -p "$backup"

# Backup existing configs
for dir in colorschemes dunst environment.d fish hypr kitty scripts walker waybar yazi; do
    if [[ -e "$HOME/.config/$dir" ]]; then
        mv "$HOME/.config/$dir" "$backup/"
    fi
done

# Backup starship config if it exists
if [[ -f "$HOME/.config/starship.toml" ]]; then
    mv "$HOME/.config/starship.toml" "$backup/"
fi

mkdir -p "$HOME/.config"
mkdir -p "$HOME/Pictures"

# Install configs
mv colorschemes "$HOME/.config/"
mv dunst "$HOME/.config/"
mv environment.d "$HOME/.config/"
mv fish "$HOME/.config/"
mv hypr "$HOME/.config/"
mv kitty "$HOME/.config/"
mv scripts "$HOME/.config/"
mv walker "$HOME/.config/"
mv waybar "$HOME/.config/"
mv yazi "$HOME/.config/"
mv starship.toml "$HOME/.config/"
mv Wallpapers "$HOME/Pictures/"
