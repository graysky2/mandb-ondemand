# mandb-ondemand
Rebuilds the manpage index database on-demand to speed-up pacman operations.

## Purpose
With the deployment of [pacman hooks](https://wiki.archlinux.org/index.php/User:Allan/Pacman_Hooks), maintenance of the manapge index database (/var/cache/man/index.db) has been integrated into pacman operations.  Anytime a package writes or removes a file to/from `/usr/share/man`, a hook triggers a rebuild which can be slow.  Really slow.  This is particularly noticeable on low powered devices such as Arch ARM PCs.  These delays can be annoying as the terminal (more likely the ssh window) remains locked while the rebuild is in progress.

This software simply flags the index database for a rebuild via a hook and allows systemd to do the dirty work on a timer much like the [pre-hook way](https://git.archlinux.org/svntogit/packages.git/commit/trunk?h=packages/man-db&id=a045e47b13b5a0d4acee6e505d7f5c8e80bcd943) the distro handled it.

## Installation
### AUR Package for Arch Linux (including Arch ARM)
AUR Package: https://aur.archlinux.org/packages/mandb-ondemand
