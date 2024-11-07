#!/bin/bash

# Directory containing wallpapers
WALLPAPER_DIR=~/Wallpapers

# Find all image files in the directory
wallpapers=$(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \))

# Randomly select a wallpaper
random_wallpaper=$(echo "$wallpapers" | shuf -n 1)

# Define the list of possible animations
ANIMATION_TYPES=("simple" "fade" "left" "right" "top" "bottom" "wipe" "grow" "center" "outer" "random" "wave")

# Randomly select an animation type
random_animation=$(echo "${ANIMATION_TYPES[@]}" | tr ' ' '\n' | shuf -n 1)

# Set wallpaper with the random animation type
swww img "$random_wallpaper" --transition-type "$random_animation" --transition-duration 1
