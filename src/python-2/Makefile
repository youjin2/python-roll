#
# $Id$
#
# @Copyright@
#
# 				Rocks(r)
# 		         www.rocksclusters.org
# 		         version 7.0 (Manzinita)
#
# Copyright (c) 2000 - 2017 The Regents of the University of California.
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are
# met:
#
# 1. Redistributions of source code must retain the above copyright
# notice, this list of conditions and the following disclaimer.
#
# 2. Redistributions in binary form must reproduce the above copyright
# notice unmodified and in its entirety, this list of conditions and the
# following disclaimer in the documentation and/or other materials provided
# with the distribution.
#
# 3. All advertising and press materials, printed or electronic, mentioning
# features or use of this software must display the following acknowledgement:
#
# 	"This product includes software developed by the Rocks(r)
# 	Cluster Group at the San Diego Supercomputer Center at the
# 	University of California, San Diego and its contributors."
#
# 4. Except as permitted for the purposes of acknowledgment in paragraph 3,
# neither the name or logo of this software nor the names of its
# authors may be used to endorse or promote products derived from this
# software without specific prior written permission.  The name of the
# software includes the following terms, and any derivatives thereof:
# "Rocks", "Rocks Clusters", and "Avalanche Installer".  For licensing of
# the associated name, interested parties should contact Technology
# Transfer & Intellectual Property Services, University of California,
# San Diego, 9500 Gilman Drive, Mail Code 0910, La Jolla, CA 92093-0910,
# Ph: (858) 534-5815, FAX: (858) 534-7345, E-MAIL:invent@ucsd.edu
#
# THIS SOFTWARE IS PROVIDED BY THE REGENTS AND CONTRIBUTORS ``AS IS''
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
# THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
# PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE REGENTS OR CONTRIBUTORS
# BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
# SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
# BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
# WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
# OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN
# IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
# @Copyright@
REDHAT.ROOT = $(CURDIR)/../../

-include $(ROCKSROOT)/etc/Rules.mk
include Rules.mk
include $(SDSCDEVEL)/Pull.mk
include $(SDSCDEVEL)/Rules.mk

SETUPOPTS =
ifeq ("$(COMPILERNAME)", "intel")
  SETUPOPTS = --compiler=intelem --fcompiler=intelem
endif

$(NAME).spec: DESCRIPTION LICENSE

DESCRIPTION:
	$(MODULE_LOAD_CC); \
	( \
	  $(DESCRIBE_PKG); \
	  $(DESCRIBE_CC); \
	  $(DESCRIBE_MKL) \
	) > $@

LICENSE: $(SRC_DIRS)
	for F in $(ADDED_MODULES); do \
	  cp $$F*/PKG-INFO $(SOURCE_DIR)/$$F-PKG-INFO; \
	done
	cp python-dateutil*/LICENSE $(SOURCE_DIR)/python-dateutil-LICENSE
	$(CHECK_LICENSE_FILES)
	echo Python and LGPL and BSD and MIT and PSF > $@

build: $(SRC_DIRS)
	patch -o $(NUMPY_DIR)/site.cfg $(NUMPY_DIR)/site.cfg.example patch-files/site.cfg.example.patch
	$(MODULE_LOAD_MKL); \
	export MKLLIB=$${MKLHOME}/lib/intel64; \
	perl -pi -e "s!ROLL_COMMENTMKL\\s*!!; s!ROLL_MKLLIB!$${MKLLIB}!; s!ROLL_MKLROOT!$${MKL_ROOT}!" $(NUMPY_DIR)/site.cfg
	patch $(NUMPY_DIR)/numpy/distutils/intelccompiler.py patch-files/intelccompiler.py.patch
	patch $(NUMPY_DIR)/numpy/distutils/fcompiler/intel.py patch-files/intel.py.patch
	patch $(NUMPY_DIR)/numpy/distutils/system_info.py patch-files/system_info.py.patch
	( \
	  $(MODULE_LOAD_CC); \
	  cd $(SOURCE_DIR); \
	  ./configure --enable-shared --prefix=$(PKGROOT); \
	  $(MAKE) \
	)
	
install::
	mkdir -p -m 755 $(ROOT)/$(PKGROOT)
	$(PKGROOT_BIND_MOUNT)
	( \
	  $(MODULE_LOAD_CC); \
	  $(MODULE_LOAD_MKL); \
	  cd $(SOURCE_DIR); \
	  $(MAKE) DESTDIR=/ install; \
	  export PATH=$(PKGROOT)/bin:$${PATH}; \
	  export LD_LIBRARY_PATH=$(PKGROOT)/lib:$${LD_LIBRARY_PATH}; \
	  export LIBPATH=$(PKGROOT)/lib:$${LIBPATH}; \
	  export PYTHONPATH=$(PKGROOT)/lib/python$(MAJOR.MINOR)/site-packages; \
	  for module in $(ADDED_MODULES); do \
	    echo === Building $$module; \
	    cd ../$$module*; \
	    if test "$$module" = "Cython"; then \
	      python$(MAJOR.MINOR) setup.py install --prefix=$(PKGROOT) --root=/ --single-version-externally-managed; \
	    elif test "$$module" = "numpy"; then \
	      python$(MAJOR.MINOR) setup.py build_src \
	                                    config $(SETUPOPTS) \
	                                    build_clib $(SETUPOPTS) \
	                                    build_ext $(SETUPOPTS); \
	      python$(MAJOR.MINOR) setup.py install --prefix=$(PKGROOT); \
	    else \
	      python$(MAJOR.MINOR) setup.py install --prefix=$(PKGROOT); \
	    fi; \
	  done \
	)
	$(PKGROOT_BIND_UMOUNT)
	$(INSTALL_LICENSE_FILES)

clean::
	rm -rf $(SOURCE_DIR) DESCRIPTION LICENSE
