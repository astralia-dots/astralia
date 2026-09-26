set -euo pipefail

[[ "$EUID" -ne 0 ]] || { echo "Run as your regular user, not root."; exit 1; }

R="$(cd "$S/.." && pwd)"

die() { echo "error: $*" >&2; exit 1; }

[[ "$(dirname "$R")" == "$HOME" ]] || die "Project must be cloned directly into \$HOME (found: $R)"
step() { echo; echo "==> $*"; }

source "$R/setup/lib/gpu.sh"
source "$S/lib/packages.sh"

sudo -v
echo "$USER ALL=(ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/99-keqing-setup >/dev/null
trap 'sudo rm -f /etc/sudoers.d/99-keqing-setup' EXIT

# 1. paru
step "Installing paru"
if ! command -v paru &>/dev/null; then
    sudo pacman -S --needed --noconfirm base-devel git
    tmp=$(mktemp -d)
    git clone https://aur.archlinux.org/paru.git "$tmp/paru"
    (cd "$tmp/paru" && makepkg -si --noconfirm)
    rm -rf "$tmp"
else
    echo "paru already installed"
fi

# 2. Dependencies
for group in CORE SESSION COMPOSITOR AUDIO CONNECTIVITY INPUT FONT DESKTOP CLI DEV AUR; do
    step "Installing $group packages"
    ref="${group}_PKGS[@]"
    paru -S --needed --noconfirm "${!ref}"
done

# 3. GPU drivers
step "Installing GPU drivers"
[[ "$(uname -r)" =~ -arch[0-9] ]] && dkms_suffix="" || dkms_suffix="-dkms"
_detect_gpu

if $has_nvidia; then
    chip=$(echo "$_gpu_gpus" | grep -i nvidia | grep -oP '\b(TU|GA|AD|GB)\d+' | head -1)
    [[ -n "$chip" ]] \
        && paru -S --needed --noconfirm "nvidia-open${dkms_suffix}" nvidia-utils egl-wayland \
        || paru -S --needed --noconfirm "nvidia${dkms_suffix}" nvidia-utils egl-wayland
fi
$has_amd   && paru -S --needed --noconfirm mesa vulkan-radeon libva-mesa-driver
$has_intel && paru -S --needed --noconfirm mesa vulkan-intel intel-media-driver
! $has_nvidia && ! $has_amd && ! $has_intel && echo "GPU not detected, skipping driver installation"

# 4. Enable services
step "Enabling services"
sudo systemctl enable NetworkManager bluetooth # network, bluetooth
systemctl --user enable pipewire pipewire-pulse wireplumber syncthing # audio, sync

step "Masking dunst"
systemctl --user mask dunst.service 2>/dev/null || true
sudo systemctl mask dunst.service 2>/dev/null || true

# 5. GRUB install
mountpoint -q /boot/efi && efi_dir=/boot/efi || efi_dir=/boot
sudo mkdir -p /boot/grub
sudo grub-install --target=x86_64-efi --efi-directory="$efi_dir" --bootloader-id=GRUB
sudo grub-mkconfig -o /boot/grub/grub.cfg

# 6. update (skip: sddm, grub)
step "Running update modules"
sudo ln -sf "$R/update" /usr/local/bin/update
"$R/update" all

step "Installing VS Code extensions"
xargs -L1 code --install-extension < "$S/extensions.txt"

# 7. Git
step "Configuring git"
git config --global pull.rebase true
git config --global push.autoSetupRemote true

# 8. Greeter
configure_greeter

cd "$HOME"
echo
echo "Setup complete. Reboot now: sudo reboot"
