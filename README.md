# dotfiles — sijan

Personal dotfiles for niri + DMS on Arch Linux.

## Fresh install workflow

```bash
# 1. Install minimal Arch with NetworkManager
# 2. Install DMS with niri + kitty
curl -fsSL https://install.danklinux.com | sh

# 3. Clone and run personal setup
git clone https://github.com/sijan/dotfiles ~/dotfiles
cd ~/dotfiles
./setup-personal.sh

# 4. Reboot
reboot
```

`setup-personal.sh` will:
- Install packages not included in DMS (per category selection)
- Backup DMS-generated configs
- Deploy personal dotfiles
- Enable services (docker, bluetooth, etc.)
- Run a full system update

## Manual steps after setup

### Plymouth theme

Install the `cuts` theme from [adi1090x/plymouth-themes](https://github.com/adi1090x/plymouth-themes).

```bash
# After downloading:
sudo cp -r cuts /usr/share/plymouth/themes/
sudo plymouth-set-default-theme cuts
sudo mkinitcpio -P
```

### Limine bootloader

Copy the limine config from this repo:

```bash
sudo cp ~/dotfiles/.config/system/limine.conf /boot/limine/limine.conf
```

## Adding packages

Add package names (one per line) to the appropriate `.txt` file in `.config/setup/packages/`. Lines starting with `#` are ignored.
