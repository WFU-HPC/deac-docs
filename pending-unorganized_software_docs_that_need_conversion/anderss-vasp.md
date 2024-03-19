# VASP 6+ (CONVERTED TO DSS)

## CPU Version with Intel Toolchain

```sh
module purge
module load compilers/gcc/10.2.0 compilers/intel/2021.2 mpi/intel/2021.2 libs/intel/mkl/2021.2


tar -xf /deac/opt/tarballs/vasp/vasp.6.4.2.tgz -C /tmp
cd /tmp/vasp.6.4.2

# cp $RESEARCHPATH/repos/deac-config/vasp/makefile.include.intel_impi_omp_mkl makefile.include
cat <<EOF > makefile.include
# Default precompiler options
CPP_OPTIONS = -DHOST=\"LinuxIFC\" \\
              -DMPI -DMPI_BLOCK=8000 -Duse_collective \\
              -DscaLAPACK \\
              -DCACHE_SIZE=4000 \\
              -Davoidalloc \\
              -Dvasp6 \\
              -Duse_bse_te \\
              -Dtbdyn \\
              -Dfock_dblbuf \\
              -D_OPENMP

CPP         = fpp -f_com=no -free -w0  \$*\$(FUFFIX) \$*\$(SUFFIX) \$(CPP_OPTIONS)

FC          = mpiifort -qopenmp
FCL         = mpiifort

FREE        = -free -names lowercase

FFLAGS      = -assume byterecl -w

OFLAG       = -O3
OFLAG_IN    = \$(OFLAG)
DEBUG       = -O0

OBJECTS     = fftmpiw.o fftmpi_map.o fftw3d.o fft3dlib.o
OBJECTS_O1 += fftw3d.o fftmpi.o fftmpiw.o
OBJECTS_O2 += fft3dlib.o

# For what used to be vasp.5.lib
CPP_LIB     = \$(CPP)
FC_LIB      = \$(FC)
CC_LIB      = icc
CFLAGS_LIB  = -O
FFLAGS_LIB  = -O1
FREE_LIB    = \$(FREE)

OBJECTS_LIB = linpack_double.o

# For the parser library
CXX_PARS    = icpc
LLIBS       = -lstdc++

##
## Customize as of this point! Of course you may change the preceding
## part of this file as well if you like, but it should rarely be
## necessary ...
##

# When compiling on the target machine itself, change this to the
# relevant target when cross-compiling for another architecture
# VASP_TARGET_CPU ?= -xHOST
VASP_TARGET_CPU ?= -march=cascadelake -mtune=cascadelake
FFLAGS     += \$(VASP_TARGET_CPU)

# For the VASP-2-Wannier90 interface (optional)
CPP_OPTIONS    += -DVASP2WANNIER90
WANNIER90_ROOT ?= /deac/opt/rhel7-cascadelake/wannier90/3.1.0/usr
# LLIBS          += -L\$(WANNIER90_ROOT)/lib -lwannier
LLIBS          += \$(WANNIER90_ROOT)/lib/libwannier.a

# Intel MKL (FFTW, BLAS, LAPACK, and scaLAPACK)
# (Note: for Intel Parallel Studio's MKL use -mkl instead of -qmkl)
# FCL        += -qmkl
# FCL        += -mkl
MKLROOT    ?= /deac/opt/rhel7/intel/oneapi/mkl/2021.2.0
LLIBS      +=   \${MKLROOT}/lib/intel64/libmkl_scalapack_lp64.a \\
                -Wl,--start-group \\
                \${MKLROOT}/lib/intel64/libmkl_intel_lp64.a \\
                \${MKLROOT}/lib/intel64/libmkl_intel_thread.a \\
                \${MKLROOT}/lib/intel64/libmkl_core.a \\
                \${MKLROOT}/lib/intel64/libmkl_blacs_intelmpi_lp64.a \\
                -Wl,--end-group -liomp5 -lpthread -lm -ldl
INCS        = -I\$(MKLROOT)/include/fftw

# HDF5-support (optional but strongly recommended)
CPP_OPTIONS+= -DVASP_HDF5
HDF5_ROOT  ?= /deac/opt/rhel7/hdf5/1.12.2-intel_impi_2021.2_static
# LLIBS      += -L\$(HDF5_ROOT)/lib -lhdf5_fortran
LLIBS      += \$(HDF5_ROOT)/lib/libhdf5_fortran.a \$(HDF5_ROOT)/lib/libhdf5.a -lz
INCS       += -I\$(HDF5_ROOT)/include

# For the fftlib library (hardly any benefit in combination with MKL's FFTs)
#FCL         = mpiifort fftlib.o -qmkl
#CXX_FFTLIB  = icpc -qopenmp -std=c++11 -DFFTLIB_USE_MKL -DFFTLIB_THREADSAFE
#INCS_FFTLIB = -I./include -I\$(MKLROOT)/include/fftw
#LIBS       += fftlib
EOF

time make DEPS=1 -j8 all # 11m35.859s

cd testsuite/
export OMP_NUM_THREADS=1
time ./runtest -f               2> test1.e 1> test1.o # 42m13.496s w/4 cores
time ./runtest -f impi+omp.conf 2> test2.e 1> test2.o # 33m23.328s w/4 cores,2 threads
time ./runtest -f impi+omp.conf 2> test3.e 1> test3.o # 29m52.853s w/4 cores,4 threads
make cleantest

cd /tmp/vasp.6.4.2
rm -r /tmp/vasp.6.4.2/build

cp -r /tmp/vasp.6.4.2 /deac/opt/rhel7/vasp/6.4.2wannier-intel_2021.2
```


## GPU (OpenACC) Version with NVHPC Toolchain

We should consider rolling our own Open MPI. Intel MPI does not seem to be a
viable option for CUDA. Need to check Intel vs. NVHPC threading with regards to
Intel MKL.

```sh
srun -p gpu -n 8 --mem=16G --gres=gpu:4 --time=00-06:00:00 --pty /bin/bash
export SCRATCH="/scratch/$SLURM_JOB_ID"
cd $SCRATCH

module purge
module load compilers/gcc/10.2.0 \
            cuda/nvhpc/23.3 \
            libs/intel/mkl/2021.2 

tar -xvf /deac/inf/adminGrp/anderss/tarballs/vasp.6.4.2.tgz
cd ${SCRATCH}/vasp.6.4.2/
cp $RESEARCHPATH/repos/deac-config/vasp/makefile.include.nvhpc_ompi_mkl_omp_acc makefile.include
time make DEPS=1 -j8 all

cd ${SCRATCH}/vasp.6.4.2/testsuite/
export OMPI_MCA_btl="smcuda,tcp,vader,self"
export NO_STOP_MESSAGE=yes
# export OMPI_MCA_mpi_cuda_support=0 # WHEN NOT ON GPU NODE AT ALL NO GPUS I SAID!!!
time ./runtest -f ompi+omp.conf # 4 mpi->gpu + 2 threads
make cleantest

cd ${SCRATCH}/vasp.6.4.2
rm -r ${SCRATCH}/vasp.6.4.2/build

cp -r ${SCRATCH}/vasp.6.4.2 /deac/opt/rhel7/vasp/6.4.2-nvhpc_23.3
```
