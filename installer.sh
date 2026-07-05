#!/bin/bash

echo "Welcome to the Coruscant Dotfiles"

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR"

echo "Your old configfiles will be backed up"

backup="$HOME/.config-backup-$(date +%Y%m%d-%H%M%S)"
mkdir -p "$backup"

for dir in colorschemes dunst environment.d fish hypr kitty scripts walker waybar yazi; do
    if [[ -e "$HOME/.config/$dir" ]]; then
        mv "$HOME/.config/$dir" "$backup/"
    fi
done

if [[ -f "$HOME/.config/starship.toml" ]]; then
    mv "$HOME/.config/starship.toml" "$backup/"
fi

echo "Your old configfiles are backed up"
echo "We are installing the new configfiles now!"

mkdir -p "$HOME/.config"
mkdir -p "$HOME/Pictures"
mkdir -p "$HOME/Pictures/Screenshots"

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

echo "The new configfiles are installed"
echo "The system will be installed NOW! DO not shut your Pc down"

sudo rm -rf /etc/nixos/configuration.nix
sudo cp -r "$SCRIPT_DIR/etc/nixos/"* /etc/nixos/
sudo nixos-rebuild switch --flake /etc/nixos

echo "System is installed, applying a theme and then restarting"

start-hyprland
awww-daemon

bash "$HOME/.config/scripts/electric-theme.sh"

sudo reboot now

