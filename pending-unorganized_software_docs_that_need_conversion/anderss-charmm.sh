cd /home/anderss ; tar -xvf /home/anderss/c51b1.tar.gz

################################################################################
################################################################################

ssh artemis

module purge && module load compilers/gcc/14.3.0 libs/intel/mkl/2023.2.0 mpi/openmpi/5.0.10 apps/python/3.14.5

mkdir -p /home/anderss/charmm/build/deac_cpu ; cd /home/anderss/charmm/build/deac_cpu

../../configure --prefix=/deac/opt/rocky9-noarch/charmm/51b1_cpu --without-opencl --without-openmm --without-cuda

make -j8 && make install

mkdir -p $(dirname /deac/opt/modulefiles/rocky9-noarch/apps/charmm/51b1_cpu)
cat << EOF > /deac/opt/modulefiles/rocky9-noarch/apps/charmm/51b1_cpu
#%Module1.0#####################################################################
##
## charmm 51b1 Modulefile
##
proc ModulesHelp { } {
    puts stderr "Loads environment variables for charmm 51b1 CPU."
}

module-whatis "charmm 51b1 CPU"

module load compilers/gcc/14.3.0 libs/intel/mkl/2023.2.0 mpi/openmpi/5.0.10

set basedir /deac/opt/rocky9-noarch/charmm/51b1_cpu

################################################################################
################################################################################

prepend-path PATH            \$basedir/bin
prepend-path PATH            \$basedir/tools
prepend-path LD_LIBRARY_PATH \$basedir/lib
EOF

exit

################################################################################
################################################################################

ssh gpu-h200-02.deac.wfu.edu

module purge && module load compilers/gcc/14.3.0 libs/intel/mkl/2023.2.0 mpi/openmpi/5.0.10_cuda13 apps/python/3.14.5
export CUDACXX="/deac/opt/rocky9-noarch/deac-envs/natalieGrp/nvhpc/Linux_x86_64/26.9/cuda/13.3/bin/nvcc"
export CUDAToolkit_ROOT="/deac/opt/rocky9-noarch/deac-envs/natalieGrp/nvhpc/Linux_x86_64/26.9/cuda/13.3"

mkdir -p /home/anderss/charmm/build/deac_gpu ; cd /home/anderss/charmm/build/deac_gpu

../../configure --prefix=/deac/opt/rocky9-noarch/charmm/51b1_gpu --without-opencl --without-openmm

mkdir -p $(dirname /deac/opt/modulefiles/rocky9-noarch/apps/charmm/51b1_gpu)
cat << EOF > /deac/opt/modulefiles/rocky9-noarch/apps/charmm/51b1_gpu
#%Module1.0#####################################################################
##
## charmm 51b1 Modulefile
##
proc ModulesHelp { } {
    puts stderr "Loads environment variables for charmm 51b1 GPU."
}

module-whatis "charmm 51b1 GPU"

module load compilers/gcc/14.3.0 libs/intel/mkl/2023.2.0 mpi/openmpi/5.0.10_cuda13

set basedir /deac/opt/rocky9-noarch/charmm/51b1_gpu

################################################################################
################################################################################

prepend-path PATH            \$basedir/bin
prepend-path PATH            \$basedir/tools
prepend-path LD_LIBRARY_PATH \$basedir/lib
EOF

exit
