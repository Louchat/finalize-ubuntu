#!/bin/bash

set -e

echo "🌌 Starting Finalize Ubuntu script..."

# ----------------------------
# User confirmation
# ----------------------------
read -rp "Do you want to start the installation? [Y/N] " choice
if [[ ! $choice =~ ^[YyOo]$ ]]; then
    echo "❌ Installation cancelled."
    exit 0
fi

# ----------------------------
# Functions
# ----------------------------

install_apt_packages() {
    echo "📦 Installing required APT packages..."
    sudo apt update
    sudo apt install -y \
        flatpak \
        git \
        cmatrix \
        cava \
        fastfetch \
        neofetch \
        ani-cli
    echo "✅ APT packages installed"
}

add_flathub() {
    if ! flatpak remotes | grep -q flathub; then
        echo "🛰️ Adding Flathub repository..."
        sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    else
        echo "✅ Flathub already configured"
    fi
}

install_flatpak_apps() {
    echo "⬇️ Installing Flatpak applications..."
    apps=(
        "org.prismlauncher.PrismLauncher"
        "org.DolphinEmu.dolphin-emu"
        "org.citra_emu.citra"
        "org.vinegarhq.Sober"
    )
    for app in "${apps[@]}"; do
        if flatpak list | grep -q "$app"; then
            echo "   ✅ $app already installed"
        else
            echo "   ⬇️ Installing $app..."
            flatpak install -y flathub "$app"
        fi
    done
}

install_snap_apps() {
    echo "⬇️ Installing Snap applications..."
    snaps=(
        "opera"
        "spotify"
        "discord"
        "steam"
        "mc-installer" # Official Minecraft launcher
    )
    for snap_app in "${snaps[@]}"; do
        if snap list | grep -q "^$snap_app "; then
            echo "   ✅ $snap_app already installed"
        else
            echo "   ⬇️ Installing $snap_app..."
            sudo snap install "$snap_app"
        fi
    done
}

set_grub_timeout() {
    grub_file="/etc/default/grub"
    if grep -q 'GRUB_TIMEOUT=-1' "$grub_file"; then
        echo "✅ GRUB timeout already set to -1"
    else
        echo "⏳ Setting GRUB timeout to -1..."
        sudo sed -i 's/^GRUB_TIMEOUT=.*/GRUB_TIMEOUT=-1/' "$grub_file"
        sudo update-grub
    fi
}

install_grub_theme() {
    theme_dir="/boot/grub/themes/Cipher"
    if [ -d "$theme_dir" ]; then
        echo "✅ GRUB theme 'Cipher' already installed"
    else
        echo "🎨 Installing GRUB theme 'Cipher'..."
        git clone https://github.com/voidlhf/StarRailGrubThemes.git /tmp/StarRailGrubThemes
        sudo mkdir -p /boot/grub/themes
        sudo cp -r /tmp/StarRailGrubThemes/assets/themes/Cipher /boot/grub/themes/
        sudo sed -i 's|^GRUB_THEME=.*|GRUB_THEME="/boot/grub/themes/Cipher/theme.txt"|' /etc/default/grub
        sudo update-grub
        rm -rf /tmp/StarRailGrubThemes
    fi
}

set_wallpaper() {
    wallpaper_path="$(pwd)/wallpeper/wallpeper.jpg"
    if [ -f "$wallpaper_path" ]; then
        echo "🖼️ Wallpaper found: $wallpaper_path"
        # Example for GNOME (uncomment to apply automatically):
        # gsettings set org.gnome.desktop.background picture-uri "file://$wallpaper_path"
    else
        echo "⚠️ Wallpaper not found at $wallpaper_path"
    fi
}

# ----------------------------
# Execution
# ----------------------------

install_apt_packages
add_flathub
install_flatpak_apps
install_snap_apps
set_grub_timeout
install_grub_theme
set_wallpaper
sudo update-grub

echo "🌟 Finalize Ubuntu script completed! Enjoy your setup 🚀"
read -n 1 -s -r -p "Press any key to exit..."
echo

