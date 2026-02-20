# Finalize Ubuntu

Finalize Ubuntu is an automated post-installation script for Ubuntu and Ubuntu-based distributions.  
It installs and configures common components such as Flatpak, Snap applications, essential software, a custom GRUB theme, and an optional wallpaper setup.

---

## Features

- Installs and configures Flatpak with Flathub
- Installs popular Snap applications:
  - Spotify
  - Discord
  - Steam
  - Opera
  - Minecraft Launcher
- Installs the following Flatpak applications:
  - PrismLauncher
  - Dolphin Emulator
  - Citra
  - Sober
- Applies a custom GRUB theme
- Optionally sets a custom wallpaper from the `wallpeper/` folder

---

## Requirements

- Ubuntu 22.04+ or Ubuntu-based distribution
- `sudo` privileges
- Active internet connection

---

## Installation

Clone the repository and run the script:

```bash
git clone https://github.com/Louchat/finalize-ubuntu.git
```

## 2. Enter the project directory

```bash
cd finalize-ubuntu
```

## 3. Make the script executable

```bash
chmod +x finalize.sh
```

## 4. Run the script

```bash
./finalize.sh
```

---

## Wallpaper

Place your wallpapers inside the `wallpeper/` folder.

By default, the script will attempt to apply:

```bash
$(pwd)/wallpeper/wallpeper.jpg
```

If you are using GNOME, you can enable automatic wallpaper setting by uncommenting this line in the script:

```bash
gsettings set org.gnome.desktop.background picture-uri "file://$wallpaper_path"
```

---
