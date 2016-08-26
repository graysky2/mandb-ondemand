VERSION = 2.06
PN = mandb-ondemand

PREFIX ?= /usr
PACMANHOOKDIR = /etc/pacman.d/hooks
INITDIR_SYSTEMD = /usr/lib/systemd/system
HOOKDIR = $(PREFIX)/share/libalpm/hooks

RM = rm
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

install-systemd:
	$(Q)echo -e '\033[1;32mInstalling systemd units...\033[0m'

	$(INSTALL_DIR) "$(DESTDIR)$(INITDIR_SYSTEMD)"
	$(INSTALL_DATA) init/$(PN).service "$(DESTDIR)$(INITDIR_SYSTEMD)/$(PN).service"

install: install-hook install-systemd

uninstall-hook:
	$(RM) "$(DESTDIR)$(HOOKDIR)/$(PN).hook"

uninstall-systemd:
	$(RM) "$(DESTDIR)$(INITDIR_SYSTEMD)/$(PN).service"

uninstall: uninstall-hook uninstall-systemd

.PHONY: install-hook install-systemd install uninstall-hook uninstall-systemd uninstall
