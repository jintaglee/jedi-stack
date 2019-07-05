#!/bin/bash

set -ex

name="lapack"
version=$1

# Hyphenated version used for install prefix
compiler=$(echo $COMPILER | sed 's/\//-/g')

# manage package dependencies here
if $MODULES; then
    set +x
    source $MODULESHOME/init/bash
    module load jedi-$COMPILER
    module list
    set -x

    prefix="${PREFIX:-"/opt/modules"}/$compiler/$name/$version"
    if [[ -d $prefix ]]; then
	[[ $OVERWRITE =~ [yYtT] ]] && ( echo "WARNING: $prefix EXISTS: OVERWRITING!";$SUDO rm -rf $prefix ) \
                                   || ( echo "WARNING: $prefix EXISTS, SKIPPING"; exit 1 )
    fi

else
    prefix="/usr/local"
fi

export FC=$SERIAL_FC
export CC=$SERIAL_CC
export CXX=$SERIAL_CXX

export CFLAGS="-fPIC"
export CXXFLAGS="-fPIC"
export FCFLAGS="-fPIC"

cd ${JEDI_STACK_ROOT}/${PKGDIR:-"pkg"}

software=$name-$version
srctar=${software}.tar.gz
url="http://www.netlib.org/lapack/${srctar}"
[[ -d $software ]] || ( wget $url && tar -xf ${srctar} ) \
    || ( echo "URL '$url' for tarball '${srctar}' for '$software' does not exist, ABORT!"; exit 1 )
[[ -d $software ]] && cd $software || ( echo "Directory $software does not exist, ABORT!"; exit 1 )
[[ -d build ]] && rm -rf build
mkdir -p build && cd build

# Add CMAKE_INSTALL_LIBDIR to make sure it will be installed under lib not lib64
cmake -DCMAKE_INSTALL_PREFIX=$prefix -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_LIBDIR:PATH=$prefix/lib \
      -DCMAKE_Fortran_COMPILER=$SERIAL_FC -DCMAKE_Fortran_FLAGS=$FCFLAGS ..

make -j${NTHREADS:-4} 
[[ $MAKE_CHECK =~ [yYtT] ]] && make check
$SUDO make install

# generate modulefile from template
$MODULES && update_modules compiler $name $version

exit 0
