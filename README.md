# mandb-ondemand
## Note
On 26-Aug-2016, Heftig has reverted back to the pure timer in [man-db-2.7.5-4](https://git.archlinux.org/svntogit/packages.git/commit/trunk?h=packages/man-db&id=3cc9b65d0e2d69f1735c15e58a1391a14f696472) which removes the pacman hook and the delay described below. Therefore, the only advantage using this software provides post man-db-2.7.5-4 is a real-time update of the cache after new package is installed. The upstream timer is still used to purge the cache upon a removal of a package.

## Summary
Makes any pacman updates to the manpage index database much faster.

## Purpose
With the deployment of [pacman hooks](https://wiki.archlinux.org/index.php/User:Allan/Pacman_Hooks), maintenance of the manpage index database (/var/cache/man/index.db) has been integrated into pacman operations.  Anytime a package writes or removes files to `/usr/share/man`, a hook triggers the rebuild of the index database which can be slow -- really slow.  This is particularly noticeable on low powered devices such as Arch ARM PCs.  The delay can be annoying as the terminal (more likely the ssh window) remains locked while the rebuild is in progress.

mandb-ondemand rebuilds the databse via a pacman hook that triggers a systemd unit to do the dirty work while pacman happily finishes thus leaving the shell free of the dreaded pause.

### Without mandb-ondemand
```
root@box # pacman -S foo bar
...
:: Running post-transaction hooks...
(1/1) Updating manpage index...
 <<<WAIT>>>    <<<WAIT>>>    <<<WAIT>>>
root@box #
```
### With mandb-ondemand
```
root@box # pacman -S foo bar
...
:: Running post-transaction hooks...
(1/1) Asking for an update to mandb's database...
root@box #
```

## Installation
### AUR Package for Arch Linux (including Arch ARM)
AUR Package: https://aur.archlinux.org/packages/mandb-ondemand

Note that no user action is required to get this working if installing from the AUR package (a post_install scriptet assures that the needed mandb-ondemand.path unit is active).

