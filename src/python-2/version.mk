ifndef ROLLCOMPILER
  ROLLCOMPILER = gnu
endif
COMPILERNAME := $(firstword $(subst /, ,$(ROLLCOMPILER)))

NAME               = sdsc-python-27
VERSION            = 2.7.9
RELEASE            = 0
PKGROOT            = /opt/python

SRC_SUBDIR         = python-2

SOURCE_NAME        = Python
SOURCE_SUFFIX      = tgz
SOURCE_VERSION     = $(VERSION)
SOURCE_PKG         = $(SOURCE_NAME)-$(SOURCE_VERSION).$(SOURCE_SUFFIX)
SOURCE_DIR         = $(SOURCE_PKG:%.$(SOURCE_SUFFIX)=%)

DATEUTILS_NAME     = dateutils
DATEUTILS_SUFFIX   = tar.gz
DATEUTILS_VERSION  = 0.6.6
DATEUTILS_PKG      = $(DATEUTILS_NAME)-$(DATEUTILS_VERSION).$(DATEUTILS_SUFFIX)
DATEUTILS_DIR      = $(DATEUTILS_PKG:%.$(DATEUTILS_SUFFIX)=%)

NOSE_NAME          = nose
NOSE_SUFFIX        = tar.gz
NOSE_VERSION       = 1.3.4
NOSE_PKG           = $(NOSE_NAME)-$(NOSE_VERSION).$(NOSE_SUFFIX)
NOSE_DIR           = $(NOSE_PKG:%.$(NOSE_SUFFIX)=%)

NUMPY_NAME         = numpy
NUMPY_SUFFIX       = tar.gz
NUMPY_VERSION      = 1.9.1
NUMPY_PKG          = $(NUMPY_NAME)-$(NUMPY_VERSION).$(NUMPY_SUFFIX)
NUMPY_DIR          = $(NUMPY_PKG:%.$(NUMPY_SUFFIX)=%)

PIP_NAME           = pip
PIP_SUFFIX         = tar.gz
PIP_VERSION        = 1.5.6
PIP_PKG            = $(PIP_NAME)-$(PIP_VERSION).$(PIP_SUFFIX)
PIP_DIR            = $(PIP_PKG:%.$(PIP_SUFFIX)=%)

PYPARSING_NAME     = pyparsing
PYPARSING_SUFFIX   = tar.gz
PYPARSING_VERSION  = 2.0.3
PYPARSING_PKG      = $(PYPARSING_NAME)-$(PYPARSING_VERSION).$(PYPARSING_SUFFIX)
PYPARSING_DIR      = $(PYPARSING_PKG:%.$(PYPARSING_SUFFIX)=%)

PYTZ_NAME          = pytz
PYTZ_SUFFIX        = tar.gz
PYTZ_VERSION       = 2014.7
PYTZ_PKG           = $(PYTZ_NAME)-$(PYTZ_VERSION).$(PYTZ_SUFFIX)
PYTZ_DIR           = $(PYTZ_PKG:%.$(PYTZ_SUFFIX)=%)

SETUPTOOLS_NAME    = setuptools
SETUPTOOLS_SUFFIX  = tar.gz
SETUPTOOLS_VERSION = 7.0
SETUPTOOLS_PKG     = $(SETUPTOOLS_NAME)-$(SETUPTOOLS_VERSION).$(SETUPTOOLS_SUFFIX)
SETUPTOOLS_DIR     = $(SETUPTOOLS_PKG:%.$(SETUPTOOLS_SUFFIX)=%)

SIX_NAME           = six
SIX_SUFFIX         = tar.gz
SIX_VERSION        = 1.8.0
SIX_PKG            = $(SIX_NAME)-$(SIX_VERSION).$(SIX_SUFFIX)
SIX_DIR            = $(SIX_PKG:%.$(SIX_SUFFIX)=%)

CYTHON_NAME        = Cython
CYTHON_SUFFIX      = tar.gz
CYTHON_VERSION     = 0.21
CYTHON_PKG         = $(CYTHON_NAME)-$(CYTHON_VERSION).$(CYTHON_SUFFIX)
CYTHON_DIR         = $(CYTHON_PKG:%.$(CYTHON_SUFFIX)=%)

TGZ_PKGS           = $(SOURCE_PKG)
TAR_GZ_PKGS        = $(DATEUTILS_PKG) $(NOSE_PKG) $(NUMPY_PKG) $(PIP_PKG) $(PYPARSING_PKG) $(PYTZ_PKG) $(SETUPTOOLS_PKG) $(SIX_PKG) $(CYTHON_PKG)

RPM.EXTRAS         = AutoReq:No
