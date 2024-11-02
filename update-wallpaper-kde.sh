#!/bin/bash
WALLPAPER_CACHE=~/SpotlightWallpapers # Directory to store downloaded wallpapers
CACHE_NUM=10 # Maximum wallpapers to keep

# Check current plasma version
if command -v qdbus &> /dev/null; then
    QDBUS_CMD="qdbus"
elif command -v qdbus6 &> /dev/null; then
    QDBUS_CMD="qdbus6"
else
    echo "Error: could not find qdbus or kdbus6 command"
    exit 1
fi

SCRIPT_DIR=$(dirname "$(realpath "$0")")
cd "$SCRIPT_DIR" || {
    echo "Cannot enter the working directory $SCRIPT_DIR, aborted"
    exit 1
}

# Create cache dir if not exist
mkdir -p "$WALLPAPER_CACHE"

# Prune old wallpapers if they exist
cd "$WALLPAPER_CACHE" || {
    echo "Cannot enter $WALLPAPER_CACHE, aborted"
    exit 1
}

if ls -t *.jpg 1> /dev/null 2>&1; then
    ls -t *.jpg | tail -n +$CACHE_NUM | xargs -r rm
fi

cd "$SCRIPT_DIR" || {
    echo "Cannot go back to working directory $SCRIPT_DIR, aborted"
    exit 1
}

# Download a new wallpaper using the SpotlightDownloader
wallpaper_path=$(mono SpotlightDownloader.exe download --single --outname $(date +"%s%3N") --outdir "$WALLPAPER_CACHE")
return_value=$?

if [ $return_value -ne 0 ]; then
    echo "Failed to fetch wallpaper using SpotlightDownloader, return value: $return_value"
    exit 1
fi

wallpaper_path=$(realpath "$wallpaper_path")
echo "New wallpaper saved at $wallpaper_path"

# Set the new wallpaper in KDE Plasma
$QDBUS_CMD org.kde.plasmashell /PlasmaShell org.kde.PlasmaShell.evaluateScript "
    var allDesktops = desktops();
    for (i=0;i<allDesktops.length;i++)
    {
        d = allDesktops[i];
        d.wallpaperPlugin = \"org.kde.image\";
        d.currentConfigGroup = Array(\"Wallpaper\", \"org.kde.image\", \"General\");
        d.writeConfig(\"Image\", \"file://$wallpaper_path\")
    }
"

exit 0
