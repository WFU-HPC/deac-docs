#!/bin/bash

export TARGET="/home/anderss/hdeac/opt/helfem"
export TARGET_MODULE="/home/anderss/hdeac/opt/modulefiles/helfem"

module load compilers/gcc/12.3.0 \
            libs/armadillo/14.6.3 \
            libs/libxc/7.0.0 \
            libs/gsl/2.7.1 \
            libs/hdf5/1.14.6-serial

git clone git@github.com:susilehtola/HelFEM.git /tmp/HelFEM
cd /tmp/HelFEM

sed -i -e 's|CMAKE_CXX_STANDARD 11|CMAKE_CXX_STANDARD 14|g' /tmp/HelFEM/CMakeLists.txt
# export CXXFLAGS="-g -Ofast -march=znver4 -mtune=znver4 -DARMA_NO_DEBUG -DARMA_DONT_USE_WRAPPER"

mkdir -p /tmp/HelFEM/build && cd /tmp/HelFEM/build

cmake .. -DCMAKE_INSTALL_PREFIX=$TARGET \
         -DCMAKE_BUILD_TYPE=Release \
         -DHELFEM_FIND_DEPS=true \
         -DUSE_OPENMP=ON

time make -j8 && make install

rm -rf /tmp/HelFEM

################################################################################
################################################################################

mkdir -p $(dirname ${TARGET_MODULE})

cat <<EOF > ${TARGET_MODULE}
#%Module
##

proc ModulesHelp { } {
    puts stderr "\tSets up environment for using Armadillo."
}

module-whatis   "Sets up environment for using Armadillo"

module load compilers/gcc/12.3.0 \
            libs/armadillo/14.6.3 \
            libs/libxc/7.0.0 \
            libs/gsl/2.7.1 \
            libs/hdf5/1.14.6-serial

set basedir  "$TARGET"

################################################################################
################################################################################

prepend-path    PATH                \$basedir/bin
prepend-path    LD_LIBRARY_PATH     \$basedir/lib
prepend-path    LIBRARY_PATH        \$basedir/lib
prepend-path    C_INCLUDE_PATH      \$basedir/include
prepend-path    CPLUS_INCLUDE_PATH  \$basedir/include
prepend-path    INCLUDE             \$basedir/include

setenv  HELFEMROOT   \$basedir
EOF
