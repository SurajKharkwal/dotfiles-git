
#!/bin/bash

# Directory containing wallpapers
WALLPAPER_DIR=~/Wallpapers

# Get the list of image files
wallpapers=$(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \))

# Get the current wallpaper name (modify this to get the actual current wallpaper)
current_wallpaper_name=$(swww query)  # Adjust this command based on how you retrieve the current wallpaper

# Style and directory for Rofi theme
style="style-7"
dir="$HOME/.config/rofi/launchers/type-6"

# Generate the Rofi menu with icons
rofi_list=""
while IFS= read -r a; do
    # Extract the filename
    filename=$(basename "$a")
    
    # Check if the current wallpaper matches
    if [[ "$filename" == "$current_wallpaper_name" ]]; then
        # Add current wallpaper indication
        rofi_list+="${filename} (current)\0icon\x1f$a\n"
    else
        # Just add the wallpaper name
        rofi_list+="${filename}\0icon\x1f$a\n"
    fi
done <<< "$wallpapers"

# Launch Rofi with the list of wallpapers
selected_wallpaper=$(echo -e "$rofi_list" | rofi -dmenu -p "Select Wallpaper:" -theme "${dir}/${style}" -markup-rows)

# Check if a wallpaper was chosen
if [ -n "$selected_wallpaper" ]; then
    # Remove " (current)" from the selected wallpaper
    final_wallpaper=$(echo "$selected_wallpaper" | sed "s/ (current)//")

    # Set the wallpaper using swww
    swww img "$WALLPAPER_DIR/$final_wallpaper"
fi
