PYTHONLIBDIR ?= $(shell  python -c "from distutils.sysconfig import *; print get_python_lib(1)")
PACKAGEDIR ?= $(DESTDIR)/$(PYTHONLIBDIR)/sepolgen

install:
	-mkdir -p $(PACKAGEDIR)
	install -m 644 *.py $(PACKAGEDIR)

clean:
	rm -f parser.out parsetab.py
	rm -f *~ *.pyc


