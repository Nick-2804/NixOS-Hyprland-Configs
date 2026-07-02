#!bin/bash

awww img ~/Pictures/Wallpapers/Paper3.jpg

cp ~/.config/colorschemes/tokyonight/hypr/themepath.lua ~/.config/hypr/hyprland/

cp ~/.config/colorschemes/tokyonight/kitty/themepath.conf ~/.config/kitty/colors

cp ~/.config/colorschemes/tokyonight/waybar/themepath.css ~/.config/waybar/colors

pkill waybar
waybar & 

cp ~/.config/colorschemes/tokyonight/walker/style.css ~/.config/walker/themes/default
pkill walker --gapplication-service
walker --gapplication-service &

echo "Theme switched to: TOKYONIGHT"
