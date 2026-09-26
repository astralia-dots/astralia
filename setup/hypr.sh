#!/usr/bin/env bash
S="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

COMPOSITOR_PKGS=(
    hyprland
    hyprshot
    xdg-desktop-portal-hyprland
)

configure_greeter() {
    step "Machine type"
    read -r -p "Is this a PC? [y/N] " is_pc

    if [[ "$is_pc" =~ ^[Yy]$ ]]; then
        step "Configuring autologin"
        sudo pacman -S --needed --noconfirm greetd
        sudo "$S/lib/autologin.sh" start-hyprland
    else
        step "Configuring SDDM"
        sudo pacman -S --needed --noconfirm sddm
        sudo systemctl enable sddm
        "$R/update" sddm
    fi
}

source "$S/lib/common.sh"
