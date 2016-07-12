# mandb-ondemand
Rebuild man-db cache/purge ondemand and speed up pacman operations.

## Purpose
With the deployment of [pacman hooks](https://wiki.archlinux.org/index.php/User:Allan/Pacman_Hooks), the task of updating and purging mandb's cache has been integrated into pacman operations.  Anytime a package writes or removes a file to `/usr/share/man`, a hook that triggers a rebuild of mandb's cache database is trigger.  The process of rebuilding the cache can be slow.  Really slow.  Particularly on low powered devices such as Arch ARM PCs.  These delays can be annoying as the terminal (more likely the ssh window) remains locked while the rebuild is in progress.

This software simply flags the mandb database for a rebuild and allows systemd to do the dirty work on a timer much like the pre-hook way the distro handled it.

## Installation
### AUR Package for Arch Linux (including Arch ARM)
AUR Package: https://aur.archlinux.org/packages/mandb-ondemand
