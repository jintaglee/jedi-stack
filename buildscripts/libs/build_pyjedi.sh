#!/bin/bash

# These are python tools for use with JEDI

set -ex

name="pyjedi"

[[ $USE_SUDO =~ [yYtT] ]] || ! $MODULES && prefix=${PYJEDI_ROOT:-"/usr/local"} \
	                  || prefix="$HOME/.local"

#####################################################################
# Python Package installs
#####################################################################

## Python 2
$SUDO python -m pip install -U pip
$SUDO python -m pip install -U setuptools
$SUDO python -m pip install -U wheel
$SUDO python -m pip install -U numpy
$SUDO python -m pip install -U netCDF4
$SUDO python -m pip install -U matplotlib

## Python 3 - General packages
$SUDO python3 -m pip install -U pip
$SUDO python3 -m pip install -U setuptools
$SUDO python3 -m pip install -U wheel
$SUDO python3 -m pip install -U pycodestyle
$SUDO python3 -m pip install -U autopep8
$SUDO python3 -m pip install -U cffi
$SUDO python3 -m pip install -U pycparser
$SUDO python3 -m pip install -U pytest

## Python 3 - Numerical packages
$SUDO python3 -m pip install -U numpy
$SUDO python3 -m pip install -U netCDF4
$SUDO python3 -m pip install -U matplotlib
$SUDO python3 -m pip install -U pandas
$SUDO python3 -m pip install -U xarray

## Python 3 - Workflow packages
$SUDO python3 -m pip install -U click
$SUDO python3 -m pip install -U ruamel.yaml
$SUDO python3 -m pip install -U jinja2
$SUDO python3 -m pip install -U boto3
$SUDO python3 -m pip install -U progressbar2


#####################################################################
# ncepbufr for python
#####################################################################

cd ${JEDI_STACK_ROOT}/${PKGDIR:-"pkg"}
git clone https://github.com/JCSDA/py-ncepbufr.git 
cd py-ncepbufr 

CC=gcc python setup.py build 
$SUDO python setup.py install 

CC=gcc python3 setup.py build 
$SUDO python3 setup.py install 

exit 0
