############################ -*- Mode: Makefile -*- ###########################
## local-vars.mk --- 
## Author           : Manoj Srivastava ( srivasta@glaurung.green-gryphon.com ) 
## Created On       : Sat Nov 15 10:43:00 2003
## Created On Node  : glaurung.green-gryphon.com
## Last Modified By : Manoj Srivastava
## Last Modified On : Fri Apr 20 08:58:24 2007
## Last Machine Used: glaurung.internal.golden-gryphon.com
## Update Count     : 21
## Status           : Unknown, Use with caution!
## HISTORY          : 
## Description      : 
## 
## arch-tag: 1a76a87e-7af5-424a-a30d-61660c8f243e
## 
###############################################################################

FILES_TO_CLEAN  = debian/files debian/buildinfo debian/substvars substvars.utils
STAMPS_TO_CLEAN = 
DIRS_TO_CLEAN   = debian/stamp

# Location of the source dir
SRCTOP    := $(shell if [ "$$PWD" != "" ]; then echo $$PWD; else pwd; fi)
TMPTOP     = $(SRCTOP)/debian/$(package)

PREFIX    = /usr

# Man Pages
MANDIR    = $(TMPTOP)/usr/share/man
MAN1DIR   = $(MANDIR)/man1
MAN3DIR   = $(MANDIR)/man3
MAN5DIR   = $(MANDIR)/man5
MAN6DIR   = $(MANDIR)/man6
MAN7DIR   = $(MANDIR)/man7
MAN8DIR   = $(MANDIR)/man8

DOCTOP  = $(TMPTOP)/usr/share/doc
DOCDIR  = $(DOCTOP)/$(package)

BINDIR  = $(TMPTOP)$(PREFIX)/bin
LIBDIR  = $(TMPTOP)$(PREFIX)/lib
ETCDIR  = $(TMPTOP)/etc
MAPDIR  = $(TMPTOP)/var/lib/$(package)

PY_VERSIONS    =>= 2.3
PYDEFAULT      =$(strip $(shell pyversions -vd))
ALL_PY_VERSIONS=$(sort $(shell pyversions -vr))
MIN_PY_VERSIONS=$(firstword $(sort $(shell pyversions -vr)))
MAX_PY_VERSIONS=$(lastword  $(sort $(shell pyversions -vr)))
STOP_VERSION   :=$(shell perl -e '$$ARGV[0] =~ m/^(\d)\.(\d)/;$$maj=$$1;$$min=$$2 +1; print "$$maj.$$min\n";' $(MAX_PY_VERSIONS))

MODULES_DIR=$(TMPTOP)/usr/share/python-support/$(package)
EXTENSIONS_DIR=$(TMPTOP)/usr/lib/python-support/$(package)
PYTHONLIBDIRTOP=/usr/lib/python-support/$(package)/


define checkdir
	@test -f debian/rules -a -f src/sepolgen/policygen.py || \
          (echo Not in correct source directory; exit 1)
endef

define checkroot
	@test $$(id -u) = 0 || (echo need root priviledges; exit 1)
endef
