############################ -*- Mode: Makefile -*- ###########################
## local.mk --- 
## Author           : Manoj Srivastava ( srivasta@glaurung.green-gryphon.com ) 
## Created On       : Sat Nov 15 10:42:10 2003
## Created On Node  : glaurung.green-gryphon.com
## Last Modified By : Manoj Srivastava
## Last Modified On : Thu Apr  3 01:22:17 2008
## Last Machine Used: anzu.internal.golden-gryphon.com
## Update Count     : 24
## Status           : Unknown, Use with caution!
## HISTORY          : 
## Description      : 
## 
## arch-tag: b07b1015-30ba-4b46-915f-78c776a808f4
## 
###############################################################################

testdir:
	$(testdir)
debian/stamp/conf/pre-config-common: debian/stamp/conf/python-sepolgen
debian/stamp/INST/python-sepolgen:   debian/stamp/install/python-sepolgen
debian/stamp/BIN/python-sepolgen:    debian/stamp/binary/python-sepolgen

CLN-common::
	$(checkdir)
	$(REASON)
	-test ! -f Makefile || $(MAKE) clean

CLEAN/python-sepolgen::
	test ! -d $(TMPTOP) || rm -rf $(TMPTOP)

debian/stamp/conf/python-sepolgen:
	$(REASON)
	touch src/sepolgen/__init__.py

debian/stamp/install/python-sepolgen:
	$(checkdir)
	$(REASON)
	$(TESTROOT)
	@test -d debian/stamp/install || mkdir -p debian/stamp/install
	rm -rf              $(TMPTOP)
	$(make_directory)   $(TMPTOP)
	$(make_directory)   $(DOCDIR)
	$(make_directory)   $(MAPDIR)
	$(MAKE) DESTDIR=$(TMPTOP) PACKAGEDIR=$(MODULES_DIR)/sepolgen install
	$(install_file)     debian/changelog      $(DOCDIR)/changelog.Debian
	$(install_file)     ChangeLog             $(DOCDIR)/changelog
	gzip -9fqr          $(DOCDIR)/
# Make sure the copyright file is not compressed
	$(install_file)      debian/copyright     $(DOCDIR)/copyright
	@echo done > $@

debian/stamp/binary/python-sepolgen:
	$(checkdir)
	$(REASON)
	$(TESTROOT)
	@test -d debian/stamp/binary || mkdir -p debian/stamp/binary
	$(make_directory)    $(TMPTOP)/DEBIAN
	$(install_script)    debian/prerm          $(TMPTOP)/DEBIAN/prerm
	$(install_script)    debian/postinst       $(TMPTOP)/DEBIAN/postinst
	dpkg-gencontrol      -p$(package) -isp   -P$(TMPTOP)
	$(create_md5sum)     $(TMPTOP)
	chown -R root        $(TMPTOP)
	chmod -R u+w,go=rX   $(TMPTOP)
	dpkg --build         $(TMPTOP) ..
	@echo done > $@

#Local variables:
#mode: makefile
#End:
