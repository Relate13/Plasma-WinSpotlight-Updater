# Plasma-WinSpotlight-Updater

This script automatically downloads and sets wallpapers from Windows Spotlight in KDE Plasma.

## Dependencies

**update-wallpaper-kde.sh**:

- KDE Plasma 5/6
- mono (required for running Spotlight-DL)

Use the following command to install mono on Ubuntu:

```bash
sudo apt install mono-complete
```

Use the following command to install mono on Arch Linux:

```bash
sudo pacman -Syu mono
```

If you are using a different distribution, refer to the [mono website](https://www.mono-project.com/download/stable/) for installation instructions.

**install-Spotlight-DL.sh**:

- curl
- wget
- unzip

## Installation

1. Clone the repository to your preferred directory:

```bash
git clone git@github.com:Relate13/Plasma-WinSpotlight-Updater.git
```

2. Navigate to the repository directory:

```bash
cd Plasma-WinSpotlight-Updater
```

3. Run the installation script for Spotlight-Downloader:

```bash
./install-Spotlight-DL.sh
```

4. Run the wallpaper updater script to download and set the Windows Spotlight wallpaper:

```bash
./update-wallpaper-kde.sh
```

## Configuration

You can change the wallpaper download directory and the maximum number of wallpapers to keep by editing these lines in `update-wallpaper-kde.sh`:

```bash
#!/bin/bash
WALLPAPER_CACHE=~/SpotlightWallpapers # Directory to store downloaded wallpapers
CACHE_NUM=10 # Maximum wallpapers to keep
```

To have the script run at startup, add `update-wallpaper-kde.sh` to the autostart list in KDE Plasma.

## Credits

- [Spotlight-Downloader](https://github.com/ORelio/Spotlight-Downloader) by ORelio
