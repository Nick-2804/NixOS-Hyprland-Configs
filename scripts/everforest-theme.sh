#!bin/bash

awww img ~/Pictures/Wallpapers/Paper2.jpg

cp ~/.config/colorschemes/everforest/hypr/themepath.lua ~/.config/hypr/hyprland/

cp ~/.config/colorschemes/everforest/kitty/themepath.conf ~/.config/kitty/colors

cp ~/.config/colorschemes/everforest/waybar/themepath.css ~/.config/waybar/colors

pkill waybar
waybar & 

cp ~/.config/colorschemes/everforest/walker/style.css ~/.config/walker/themes/default
pkill walker walker --gapplication-service
walker --gapplication-service &

echo "Theme switched to: EVERFOREST"
