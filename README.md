# mandb-ondemand
A pacman hook and systemd timer to handle periodic rebuilds of mandb cache.

## Purpose
Prolonged run times when triggering either the man-db.hook or man-db-purge.hook are the primary reason users might like this software.

With the deployment of [pacman hooks](https://wiki.archlinux.org/index.php/User:Allan/Pacman_Hooks), the task of updating and purging mandb's cache has been integrated into pacman operations.  Anytime any package writes a file to `/usr/share/man/*` on an install or remove operation, either of the aforementioned hooks will be triggered.  These events can happen each time the user triggers an update (thus multiple times per day depending on the user's level of OCD.)  As mentioned above, the process of rebuilding the cache can be slow.  Really slow particularly on low powered devices such as Arch ARM PCs which can be annoying as the pacman database remains locked while the rebuild is underway.

## Installation
### AUR Package for Arch Linux (including Arch ARM)
AUR Package: https://aur.archlinux.org/packages/mandb-ondemand

### Manual install
Read the included INSTALL document manually install.
