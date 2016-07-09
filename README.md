# man-db-systemd
The former Arch Linux systemd files to handle man-db cache updates

## Purpose
With the deployment of [pacman hooks](https://wiki.archlinux.org/index.php/User:Allan/Pacman_Hooks), the task of updating man-db's cache has been integrated into pacman operations.  Anytime any package writes a file to `/usr/share/man/*` the rebuild hook is trigger.  A side effect of this which is particularly true for low powered devices such as Arch ARM PCs is slow updates which can be annoying.

This repo holds the official Arch Linux Systemd service and timer to automate this process.

## Installation
### AUR Package for Arch Linux (including Arch ARM)
AUR Package: https://aur.archlinux.org/packages/man-db-systemd

### Manual install
The PKGBUILD in the AUR package linked above simply provides the two files in this repo and creates a symlink to the mute pacman hook.
