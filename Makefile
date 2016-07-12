VERSION = 1.11
PN = mandb-ondemand

PREFIX ?= /usr
PACMANHOOKDIR = /etc/pacman.d/hooks
BINDIR = $(PREFIX)/bin
INITDIR_SYSTEMD = /usr/lib/systemd/system
LIVEDIR_SYSTEMD = $(INITDIR_SYSTEMD)/multi-user.target.wants
HOOKDIR = $(PREFIX)/share/libalpm/hooks

RM = rm
SED = sed
INSTALL = install -p
INSTALL_PROGRAM = $(INSTALL) -m755
INSTALL_DATA = $(INSTALL) -m644
INSTALL_DIR = $(INSTALL) -d
LINK = ln -s
Q = @

common/$(PN): bin/$(PN).in
	$(Q)echo -e '\033[1;32mSetting version\033[0m'
	$(Q)$(SED) 's/@VERSION@/'$(VERSION)'/' bin/$(PN).in > bin/$(PN)

install-bin: bin/$(PN)
	$(Q)echo -e '\033[1;32mInstalling bin and hooks...\033[0m'
	$(INSTALL_DIR) "$(DESTDIR)$(BINDIR)"
	$(INSTALL_PROGRAM) bin/$(PN) "$(DESTDIR)$(BINDIR)/$(PN)"
	
	$(INSTALL_DIR) "$(DESTDIR)$(HOOKDIR)"
	$(INSTALL_DATA) hooks/$(PN).hook "$(DESTDIR)$(HOOKDIR)/$(PN).hook"
	
	$(INSTALL_DIR) "$(DESTDIR)$(PACMANHOOKDIR)"
	$(LINK) /dev/null "$(DESTDIR)$(PACMANHOOKDIR)/man-db.hook"
	$(LINK) /dev/null "$(DESTDIR)$(PACMANHOOKDIR)/man-db-purge.hook"

install-systemd:
	$(Q)echo -e '\033[1;32mInstalling systemd files...\033[0m'

	$(INSTALL_DIR) "$(DESTDIR)$(LIVEDIR_SYSTEMD)"
	$(INSTALL_DATA) init/$(PN).service "$(DESTDIR)$(INITDIR_SYSTEMD)/$(PN).service"
	$(INSTALL_DATA) init/$(PN).timer "$(DESTDIR)$(INITDIR_SYSTEMD)/$(PN).timer"
	$(LINK) ../$(PN).service "$(DESTDIR)$(LIVEDIR_SYSTEMD)/$(PN).service"
	$(LINK) ../$(PN).timer "$(DESTDIR)$(LIVEDIR_SYSTEMD)/$(PN).timer"

install: install-bin install-systemd

uninstall-bin:
	$(RM) "$(DESTDIR)$(BINDIR)/$(PN)"
	$(RM) "$(DESTDIR)$(HOOKDIR)/$(PN).hook"
	$(RM) "$(DESTDIR)$(PACMANHOOKDIR)/man-db.hook"
	$(RM) "$(DESTDIR)$(PACMANHOOKDIR)/man-db-purge.hook"

uninstall-systemd:
	$(RM) "$(DESTDIR)$(INITDIR_SYSTEMD)/$(PN).service"
	$(RM) "$(DESTDIR)$(INITDIR_SYSTEMD)/$(PN).timer"
	$(RM) "$(DESTDIR)$(LIVEDIR_SYSTEMD)/$(PN).service"
	$(RM) "$(DESTDIR)$(LIVEDIR_SYSTEMD)/$(PN).timer"

uninstall: uninstall-bin uninstall-systemd

clean:
	$(RM) -f bin/$(PN)

.PHONY: install-bin install-systemd install uninstall-bin uninstall-systemd uninstall clean
