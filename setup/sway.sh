#!/usr/bin/env bash
S="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

COMPOSITOR_PKGS=(
    sway
    xdg-desktop-portal-wlr
)

configure_greeter() {
    step "Configuring SDDM"
    sudo pacman -S --needed --noconfirm sddm
    sudo systemctl enable sddm
    "$R/update" sddm
}

source "$S/lib/common.sh"
