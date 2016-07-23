VERSION = 2.00
PN = mandb-ondemand

PREFIX ?= /usr
PACMANHOOKDIR = /etc/pacman.d/hooks
INITDIR_SYSTEMD = /usr/lib/systemd/system
LIVEDIR_SYSTEMD = $(INITDIR_SYSTEMD)/multi-user.target.wants
HOOKDIR = $(PREFIX)/share/libalpm/hooks

RM = rm
SED = sed
INSTALL = install -p
INSTALL_PROGRAM = $(INSTALL) -m755
INSTALL_DATA = $(INSTALL) -m644
INSTALL_DIR = $(INSTALL) -d
LINK = ln -sf
Q = @

install-hook:
	$(Q)echo -e '\033[1;32mInstalling hooks and masks...\033[0m'
	$(INSTALL_DIR) "$(DESTDIR)$(HOOKDIR)"
	$(INSTALL_DATA) hooks/$(PN).hook "$(DESTDIR)$(HOOKDIR)/$(PN).hook"
	$(INSTALL_DATA) hooks/$(PN)-purge.hook "$(DESTDIR)$(HOOKDIR)/$(PN)-purge.hook"
	
	$(INSTALL_DIR) "$(DESTDIR)$(PACMANHOOKDIR)"
	$(LINK) /dev/null "$(DESTDIR)$(PACMANHOOKDIR)/man-db.hook"
	$(LINK) /dev/null "$(DESTDIR)$(PACMANHOOKDIR)/man-db-purge.hook"

install-systemd:
	$(Q)echo -e '\033[1;32mInstalling systemd files...\033[0m'

	$(INSTALL_DIR) "$(DESTDIR)$(LIVEDIR_SYSTEMD)"
	$(INSTALL_DATA) init/$(PN).service "$(DESTDIR)$(INITDIR_SYSTEMD)/$(PN).service"
	$(INSTALL_DATA) init/$(PN)-purge.service "$(DESTDIR)$(INITDIR_SYSTEMD)/$(PN)-purge.service"
	$(INSTALL_DATA) init/$(PN).path "$(DESTDIR)$(INITDIR_SYSTEMD)/$(PN).path"
	$(INSTALL_DATA) init/$(PN)-purge.path "$(DESTDIR)$(INITDIR_SYSTEMD)/$(PN)-purge.path"
	$(LINK) ../$(PN).path "$(DESTDIR)$(LIVEDIR_SYSTEMD)/$(PN).path"
	$(LINK) ../$(PN)-purge.path "$(DESTDIR)$(LIVEDIR_SYSTEMD)/$(PN)-purge.path"

install: install-hook install-systemd

uninstall-hook:
	$(RM) "$(DESTDIR)$(HOOKDIR)/$(PN).hook"
	$(RM) "$(DESTDIR)$(HOOKDIR)/$(PN)-purge.hook"
	$(RM) "$(DESTDIR)$(PACMANHOOKDIR)/man-db.hook"
	$(RM) "$(DESTDIR)$(PACMANHOOKDIR)/man-db-purge.hook"

uninstall-systemd:
	$(RM) "$(DESTDIR)$(INITDIR_SYSTEMD)/$(PN).service"
	$(RM) "$(DESTDIR)$(INITDIR_SYSTEMD)/$(PN)-purge.service"
	$(RM) "$(DESTDIR)$(INITDIR_SYSTEMD)/$(PN).path"
	$(RM) "$(DESTDIR)$(INITDIR_SYSTEMD)/$(PN)-purge.path"
	$(RM) "$(DESTDIR)$(LIVEDIR_SYSTEMD)/$(PN).path"
	$(RM) "$(DESTDIR)$(LIVEDIR_SYSTEMD)/$(PN)-purge.path"

uninstall: uninstall-hook uninstall-systemd

.PHONY: install-hook install-systemd install uninstall-hook uninstall-systemd uninstall
