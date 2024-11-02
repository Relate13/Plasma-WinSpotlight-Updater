#!/bin/bash

SCRIPT_DIR=$(dirname "$(realpath "$0")")
cd "$SCRIPT_DIR" || {
    echo "Cannot enter the working directory $SCRIPT_DIR, aborted"
    exit 1
}

# Download the latest version of Spotlight-DL
download_url=$(curl -s https://api.github.com/repos/ORelio/Spotlight-Downloader/releases/latest | grep "browser_download_url.*zip" | cut -d : -f 2,3 | tr -d \")
if [ -z "$download_url" ]; then
    echo "Failed to retrieve the download URL."
    exit 1
fi

wget $download_url -O latest.zip
if [ $? -ne 0 ]; then
    echo "Failed to download the ZIP file."
    exit 1
fi

# Extract the downloaded ZIP file
unzip -o latest.zip -d .
if [ $? -eq 0 ]; then
    echo "Successfully extracted latest.zip."
    rm latest.zip
    echo "Deleted ZIP file: latest.zip"
    exit 0
else
    echo "Failed to extract latest.zip."
    exit 1
fi
