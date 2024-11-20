#!/bin/bash

USER_INPUT=$1
WALLPAPER_DIR=~/Wallpapers/
WALLPAPERS=$(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \))
ANIMATION_TYPES=("simple" "fade" "left" "right" "top" "bottom" "wipe" "grow" "center" "outer" "random" "wave")

WallpaperSlideshow() {
  while true; do
    WALLPAPER=$(echo "$WALLPAPERS" | shuf -n 1)
    random_animation=$(echo "${ANIMATION_TYPES[@]}" | tr ' ' '\n' | shuf -n 1)
    swww img "$WALLPAPER" --transition-type "$random_animation" --transition-duration 1
    sleep 1200
  done
}

RandWallpaper() {
  WALLPAPER=$(echo "$WALLPAPERS" | shuf -n 1)
  random_animation=$(echo "${ANIMATION_TYPES[@]}" | tr ' ' '\n' | shuf -n 1)
  swww img "$WALLPAPER" --transition-type "$random_animation" --transition-duration 1
}

WallpaperSelector() {
  current_wallpaper_name=$(basename "$(swww query)")

  # Style and directory for Rofi theme
  style="style-13"
  dir="$HOME/.config/rofi/launchers/type-2"

  # Generate the Rofi menu with icons
  rofi_list=""
  while IFS= read -r a; do
    filename=$(basename "$a")
    if [[ "$filename" == "$current_wallpaper_name" ]]; then
      rofi_list+="${filename} (current)\0icon\x1f$a\n"
    else
      rofi_list+="${filename}\0icon\x1f$a\n"
    fi
  done <<<"$WALLPAPERS"

  selected_wallpaper=$(echo -e "$rofi_list" | rofi -dmenu -p "Select Wallpaper:" -theme "${dir}/${style}" -markup-rows)

  # Check if a wallpaper was chosen
  if [[ -n "$selected_wallpaper" ]]; then
    final_wallpaper=$(echo "$selected_wallpaper" | sed "s/ (current)//")
    random_animation=$(echo "${ANIMATION_TYPES[@]}" | tr ' ' '\n' | shuf -n 1)
    swww img "$WALLPAPER_DIR/$final_wallpaper" --transition-type "$random_animation" --transition-duration 1
  fi
}

case $USER_INPUT in
  slideshow)
    WallpaperSlideshow
    ;;
  random)
    RandWallpaper
    ;;
  select)
    WallpaperSelector
    ;;
  *)
    echo "Usage: $0 {slideshow|random|select}"
    ;;
esac

