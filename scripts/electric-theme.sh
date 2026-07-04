#!bin/bash

awww img ~/Pictures/Wallpapers/Paper1.jpg --transition-type center

cp ~/.config/colorschemes/electric/hypr/themepath.lua ~/.config/hypr/hyprland

cp ~/.config/colorschemes/electric/kitty/themepath.conf ~/.config/kitty/colors

cp ~/.config/colorschemes/electric/waybar/themepath.css ~/.config/waybar/colors

pkill waybar
waybar &

cp ~/.config/colorschemes/electric/walker/style.css ~/.config/walker/themes/default/
pkill -f "walker --gapplication-service"
walker --gapplication-service &


echo "Theme switched to: ELECTRIC"
