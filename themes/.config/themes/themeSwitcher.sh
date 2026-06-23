#!/usr/bin/env bash

# --- CONFIGURATION ---
THEMES_DIR="$HOME/.config/themes"
TARGET_DIR="$HOME/.config"
THEME=""

# --- 1. PARSE FLAGS ---
while [[ $# -gt 0 ]]; do
  case "$1" in
    -t|--theme) THEME="$2"; shift 2 ;;
    -h|--help)
      echo "Usage: switch-theme [-t theme_name]"
      exit 0
      ;;
    *) echo "Unknown option: $1"; exit 1 ;;
  esac
done

# --- 2. INTERACTIVE MENU FALLBACK ---
if [[ -z "$THEME" ]]; then
  if command -v fzf &> /dev/null; then
    THEME=$(basename -a "$THEMES_DIR"/* | fzf --prompt="Select Theme: " --height=40% --reverse)
  else
    echo "Select a theme:"
    options=($(basename -a "$THEMES_DIR"/*))
    select choice in "${options[@]}" "Cancel"; do
      [[ "$choice" == "Cancel" ]] && exit 0
      [[ -n "$choice" ]] && THEME="$choice" && break
      echo "Invalid choice."
    done
  fi
fi

[[ -z "$THEME" ]] && echo "No theme selected. Exiting." && exit 0

# --- 3. THE SMART FILE OVERWRITE ---
SOURCE_DIR="$THEMES_DIR/$THEME"

if [[ -d "$SOURCE_DIR" ]]; then
  echo "Applying theme: $THEME"
  
  # Move into the theme directory to handle relative paths easily
  cd "$SOURCE_DIR" || exit 1

  # Find every file inside the selected theme folder
  find . -type f | while read -r file; do
    relative_path="${file#./}"
    final_dest="$TARGET_DIR/$relative_path"
    
    # SAFETY CHECK: Only delete the target if it is a SYMLINK.
    # This snaps the Git connection for this file ONLY, leaving sibling files safe.
    if [[ -L "$final_dest" ]]; then
      echo "  -> Unlinking symlink: $final_dest"
      rm "$final_dest"
    fi
    
    # Ensure the parent directory exists (just in case)
    mkdir -p "$(dirname "$final_dest")"
    
    # Copy the real file over
    cp "$relative_path" "$final_dest"
    echo "  -> Applied: $relative_path"
  done
  
  echo "Theme successfully applied without disrupting other configurations."
else
  echo "Error: Theme '$THEME' not found at $THEMES_DIR"
  exit 1
fi
