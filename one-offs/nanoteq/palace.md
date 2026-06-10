```sh
module load compilers/gcc/12.3.0 mpi/openmpi/4.1.6 libs/intel/mkl/2023.2.0

# git clone https://github.com/awslabs/palace.git /tmp/palace

wget https://github.com/awslabs/palace/archive/refs/tags/v0.16.1.tar.gz -O /tmp/palace-0.16.1.tar.gz
tar -xvf /tmp/palace-0.16.1.tar.gz -C /tmp

mkdir /tmp/palace-0.16.1/build && cd /tmp/palace-0.16.1/build
cmake .. -DCMAKE_INSTALL_PREFIX=/deac/opt/rocky9-noarch/palace/0.16.1
make -j32

cd && rm -rf /tmp/palace-*


mkdir -p $(dirname /deac/opt/modulefiles/rocky9-noarch/apps/palace/0.16.1)
cat << EOF > /deac/opt/modulefiles/rocky9-noarch/apps/palace/0.16.1
#%Module1.0
##
## palace
##

proc ModulesHelp { } {
    puts stderr {AWS Palace}
}

module-whatis {AWS Palace}

module load compilers/gcc/12.3.0 mpi/openmpi/4.1.6 libs/intel/mkl/2023.2.0

set basedir     "/deac/opt/rocky9-noarch/palace/0.16.1"

################################################################################
################################################################################

prepend-path    PATH                           \$basedir/bin
prepend-path    INCLUDE                        \$basedir/include
prepend-path    LD_LIBRARY_PATH                \$basedir/lib
prepend-path    LIBRARY_PATH                   \$basedir/lib
prepend-path    LD_LIBRARY_PATH                \$basedir/lib64
prepend-path    LIBRARY_PATH                   \$basedir/lib64

setenv          PALACE_ROOT                    \$basedir
EOF
```
