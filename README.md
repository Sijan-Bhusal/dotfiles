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

Copy the limine config from this repo and update the PARTUUID:

```bash
# Get your root partition UUID
blkid /dev/sda2 -s PARTUUID -o value

# Edit the placeholder in the repo file, then copy
sudo cp ~/dotfiles/.config/system/limine.conf /boot/limine/limine.conf
```

### fstab

Copy the fstab template and update the UUIDs:

```bash
# Get your partition UUIDs
blkid /dev/sda1 -s UUID -o value   # boot
blkid /dev/sda2 -s UUID -o value   # root
blkid /dev/sdb  -s UUID -o value   # storage

# Edit .config/system/fstab and replace each <CHANGE-ME-*> placeholder,
# then copy to /etc/
sudo cp ~/dotfiles/.config/system/fstab /etc/fstab
```

## Adding packages

Add package names (one per line) to the appropriate `.txt` file in `.config/setup/packages/`. Lines starting with `#` are ignored.
