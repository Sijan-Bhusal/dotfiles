#!/usr/bin/env bash
set -euo pipefail

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
PACKAGES_DIR="$REPO_DIR/.config/setup/packages"
BACKUP_SUFFIX=".dms-backup"

log()  { printf "%b%s%b\n" "$GREEN" "==> $*" "$NC"; }
warn() { printf "%b%s%b\n" "$YELLOW" "==> $*" "$NC"; }
error() { printf "%b%s%b\n" "$RED" "==> $*" "$NC" >&2; }

preflight_check() {
  log "Running pre-flight checks..."

  if [ "$(uname)" != "Linux" ]; then
    error "This script only supports Linux."
    exit 1
  fi

  if ! command -v paru &>/dev/null; then
    error "paru is not installed. Please install paru first."
    exit 1
  fi

  if ! command -v dms &>/dev/null; then
    error "DMS is not installed. Run 'curl -fsSL https://install.danklinux.com | sh' first."
    exit 1
  fi

  if [ ! -d "$REPO_DIR/.config/niri" ]; then
    error "Script must be run from the dotfiles repo root (missing .config/niri)."
    exit 1
  fi

  if ! command -v gum &>/dev/null; then
    log "Installing gum..."
    sudo pacman -S --needed --noconfirm gum
  fi

  log "All pre-flight checks passed."
}

select_categories() {
  local categories=()
  for f in "$PACKAGES_DIR"/*.txt; do
    categories+=("$(basename "$f" .txt)")
  done

  local choices
  choices=$(printf "%s\n" "${categories[@]}" | gum choose --no-limit --header "Select categories to install:" --cursor "> " --selected.foreground "#0f0")

  if [ -z "$choices" ]; then
    warn "No categories selected. Nothing to install."
    exit 0
  fi

  SELECTED_CATEGORIES=()
  while IFS= read -r line; do
    SELECTED_CATEGORIES+=("$line")
  done <<< "$choices"

  log "Selected: ${SELECTED_CATEGORIES[*]}"
}

install_packages() {
  local category=$1
  local pkg_file="$PACKAGES_DIR/$category.txt"

  if [ ! -f "$pkg_file" ]; then
    warn "Package file not found: $pkg_file"
    return
  fi

  local packages
  packages=$(grep -v '^#' "$pkg_file" | grep -v '^$' | tr '\n' ' ')

  if [ -z "$packages" ]; then
    warn "No packages listed in $category"
    return
  fi

  log "Installing $category packages..."
  gum spin --title "Installing $category packages..." -- paru -S --needed --noconfirm $packages
}

backup_config() {
  local src="$1"
  local backup="${src}${BACKUP_SUFFIX}"

  if [ ! -e "$src" ]; then
    return
  fi

  if [ -e "$backup" ]; then
    warn "Backup already exists: $backup (skipping)"
    return
  fi

  log "Backing up $src -> $backup"
  cp -r "$src" "$backup"
}

deploy_dotfiles() {
  log "Backing up DMS configs..."
  backup_config "$HOME/.config/niri"
  backup_config "$HOME/.config/kitty"
  backup_config "$HOME/.config/environment.d"
  backup_config "$HOME/.config/quickshell"

  log "Deploying personal dotfiles..."
  gum spin --title "Copying .config/..." -- cp -r "$REPO_DIR/.config/." "$HOME/.config/"
  gum spin --title "Copying .local/..." -- cp -r "$REPO_DIR/.local/." "$HOME/.local/"

  log "Dotfiles deployed."
}

post_install_hooks() {
  log "Running post-install hooks..."

  if command -v docker &>/dev/null; then
    gum spin --title "Enabling Docker..." -- sudo systemctl enable --now docker 2>/dev/null || warn "Docker enable failed"
  fi

  if command -v bluetoothctl &>/dev/null; then
    gum spin --title "Enabling Bluetooth..." -- sudo systemctl enable --now bluetooth 2>/dev/null || warn "Bluetooth enable failed"
  fi

  if systemctl list-unit-files plymouth.service &>/dev/null; then
    sudo systemctl enable plymouth 2>/dev/null || warn "Plymouth enable failed"
  fi

  if systemctl list-unit-files systemd-zram-setup@zram0 &>/dev/null; then
    sudo systemctl enable --now systemd-zram-setup@zram0 2>/dev/null || warn "zram enable failed"
  fi

  gum spin --title "Running system update..." -- paru -Syu --noconfirm
}

print_summary() {
  log "Setup complete!"
  echo ""
  echo "  Categories installed: ${SELECTED_CATEGORIES[*]}"
  echo "  Backup locations:      ~/.config/*${BACKUP_SUFFIX}/"
  echo ""
  echo "  Next steps:"
  echo "    1. Log out and log back in to apply environment changes"
  echo "    2. If using plymouth, run:"
  echo "       sudo mkinitcpio -P"
  echo "    3. If using limine, copy limine.conf manually:"
  echo "       sudo cp ~/dotfiles/.config/system/limine.conf /boot/limine/limine.conf"
  echo "    4. Plymouth theme: https://github.com/adi1090x/plymouth-themes"
  echo ""
}

main() {
  preflight_check
  select_categories

  for cat in "${SELECTED_CATEGORIES[@]}"; do
    install_packages "$cat"
  done

  deploy_dotfiles
  post_install_hooks
  print_summary
}

main "$@"
