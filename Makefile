# This application is released under the GNU General Public License 
# v3 (or, at your option, any later version). You can find the full 
# text of the license under http://www.gnu.org/licenses/gpl.txt. 
# By using, editing and/or distributing this software you agree to 
# the terms and conditions of this license. 
# Thank you for using free software!
#
#(c) QB89Dragon 2007/8 <hughescih@hotmail.com>
#(c) Whise 2009 <helderfraga@gmail.com>
#
# A simple makefile to allow installing/uninstalling 
# Part of the MateNu

PREFIX = /usr
AWNPREFIX = $(PREFIX)
CAIRODOCKPREFIX = $(PREFIX)
DOCKYPREFIX = $(PREFIX)
INSTALL_LOG = install.log
LIBDIR = $(PREFIX)/lib

.PHONY : install
.PHONY : uninstall

all:
	@echo "Makefile: Available actions: install, uninstall,"
	@echo "Makefile: Available variables: PREFIX, DESTDIR, AWNPREFIX, CAIRODOCKPREFIX"

# install
install:

	-install -d $(DESTDIR)/etc/matenu $(DESTDIR)$(PREFIX)/bin/ $(DESTDIR)$(LIBDIR) \
	$(DESTDIR)$(PREFIX)/share $(DESTDIR)$(LIBDIR)/matecomponent/servers $(DESTDIR)$(CAIRODOCKPREFIX)/share/cairo-dock/plug-ins/Dbus/third-party/MateNu $(DESTDIR)$(PREFIX)/share/kde4/apps/plasma
	@echo $(PREFIX) > $(DESTDIR)/etc/matenu/prefix
	python -u setup.py
	
	#-install src/bin/MateNu.py $(DESTDIR)$(PREFIX)/bin/
	-cp -r src/lib/matenu $(DESTDIR)$(LIBDIR)
	-cp -r src/share/matenu $(DESTDIR)$(PREFIX)/share
	-cp -r src/share/avant-window-navigator $(DESTDIR)$(AWNPREFIX)/share
	-install src/share/dockmanager/scripts/MateNu.py $(DESTDIR)$(DOCKYPREFIX)/share/dockmanager/scripts/
	-cp -r src/share/dockmanager/scripts/MateNu $(DESTDIR)$(DOCKYPREFIX)/share/dockmanager/scripts/
	#-cp -r src/share/xfce4 $(DESTDIR)$(PREFIX)/share
	-cp -r src/share/locale $(DESTDIR)$(PREFIX)/share
	#-cp -r src/share/plasma/plasmoids $(DESTDIR)$(PREFIX)/share/kde4/apps/plasma
	-install src/share/cairo-dock/third-party/MateNu/* $(DESTDIR)$(CAIRODOCKPREFIX)/share/cairo-dock/plug-ins/Dbus/third-party/MateNu/
	#-cp -r src/share/cairo-dock ~/.config/
	-install src/bin/MateNu.py $(DESTDIR)$(PREFIX)/bin/
	-install src/lib/matecomponent/MATE_MateNu.server $(DESTDIR)$(LIBDIR)/matecomponent/servers
	-plasmapkg -i src/share/plasma/plasmoids/MateNu.zip -p $(DESTDIR)$(PREFIX)/share/kde4/apps/plasma/plasmoids
	@echo "Makefile: MateNu installed."


# uninstall
uninstall:

	rm -rf $(LIBDIR)/matenu
	rm -rf $(PREFIX)/share/matenu
	rm -rf $(PREFIX)/share/avant-window-navigator/applets/MateNu.desktop
	rm -rf $(PREFIX)/share/avant-window-navigator/applets/MateNu
	#rm -rf $(PREFIX)/share/xfce4/panel-plugins/MateNu.desktop
	rm -rf $(PREFIX)/bin/MateNu.py
	rm -rf $(PREFIX)/share/kde4/apps/plasma/plasmoids/MateNu
	rm -rf $(LIBDIR)/matecomponent/servers/MATE_MateNu.server
	rm -rf /etc/matenu/prefix
	rm -rf ~/.matenu
	rm -rf ~/.config/cairo-dock/third-party/MateNu
	rm -rf $(PREFIX)/share/dockmanager/scripts/MateNu
	rm -rf $(PREFIX)/share/dockmanager/scripts/MateNu.py
	plasmapkg -r MateNu


