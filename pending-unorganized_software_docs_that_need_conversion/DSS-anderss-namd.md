# NAMD on the DEAC Cluster (CONVERTED TO DSS)

```sh
module use /deac/opt/modulefiles/rocky9-noarch /deac/opt/modulefiles/rocky9-zen4
module load compilers/gcc/12.3.0 libs/intel/mkl/2023.2.0

```

```sh
wget --no-check-certificate https://www.ks.uiuc.edu/Research/namd/3.0b6/download/120834/NAMD_3.0b6_Source.tar.gz -O /tmp/NAMD_3.0b6_Source.tar.gz
tar -xf /tmp/NAMD_3.0b6_Source.tar.gz -C /tmp

cd /tmp/NAMD_3.0b6_Source
tar -xf /tmp/NAMD_3.0b6_Source/charm-7.0.0.tar
cd /tmp/NAMD_3.0b6_Source/charm-v7.0.0

# ./build charm++ mpi-linux-x86_64 mpicxx --with-production -j64
./build charm++ multicore-linux-x86_64 gcc --with-production

# Testing
cd /tmp/NAMD_3.0b6_Source/charm-v7.0.0/multicore-linux-x86_64-gcc/tests/charm++/megatest
make test
P=32 make testp
# make smptest

cd /tmp/NAMD_3.0b6_Source/charm-v7.0.0/multicore-linux-x86_64-gcc/examples/charm++/NQueen
make
./charmrun +p32 ./nqueen 18 6
```

```sh
# ## nonthreaded
# wget http://www.ks.uiuc.edu/Research/namd/libraries/tcl8.5.9-linux-x86_64.tar.gz -O /tmp/tcl8.5.9-linux-x86_64.tar.gz
# tar -xf /tmp/tcl8.5.9-linux-x86_64.tar.gz -C /tmp/NAMD_3.0b6_Source
# rm -f /tmp/tcl8.5.9-linux-x86_64.tar.gz

## threaded ftw
wget http://www.ks.uiuc.edu/Research/namd/libraries/tcl8.5.9-linux-x86_64-threaded.tar.gz -O /tmp/tcl8.5.9-linux-x86_64-threaded.tar.gz
tar -xf /tmp/tcl8.5.9-linux-x86_64-threaded.tar.gz -C /tmp/NAMD_3.0b6_Source
rm -f /tmp/tcl8.5.9-linux-x86_64-threaded.tar.gz
```

```sh
cd /tmp/NAMD_3.0b6_Source

touch /tmp/NAMD_3.0b6_Source/arch/DEAC.base

cat << EOF > /tmp/NAMD_3.0b6_Source/arch/DEAC.arch
NAMD_ARCH = DEAC
CHARMARCH = multicore-linux-x86_64-gcc

CXX = g++ -m64 -std=c++11
CXXOPTS = -O3 -fexpensive-optimizations -ffast-math -mavx512f -mavx512dq #-march=znver4 -mtune=znver4 #-DNAMD_AVXTILES
CC = gcc -m64
COPTS = -O3 -fexpensive-optimizations -ffast-math -mavx512f -mavx512dq #-march=znver4 -mtune=znver4 #-DNAMD_AVXTILES
EOF

cat << EOF > /tmp/NAMD_3.0b6_Source/arch/DEAC.fftw
# FFTINCL=-I\$(MKLROOT)/include/fftw
# FFTLIB="-L\$(MKLROOT)/lib/intel64 -lmkl_gf_lp64 -lmkl_sequential -lmkl_core"
# FFTLIB=-Wl,--start-group \$(MKLROOT)/lib/intel64/libmkl_gf_lp64.a \$(MKLROOT)/lib/intel64/libmkl_sequential.a \$(MKLROOT)/lib/intel64/libmkl_core.a -Wl,--end-group
# FFTLIB="-m64 -Wl,--start-group \$(MKLROOT)/lib/intel64/libmkl_cdft_core.a \$(MKLROOT)/lib/intel64/libmkl_gf_lp64.a \$(MKLROOT)/lib/intel64/libmkl_sequential.a \$(MKLROOT)/lib/intel64/libmkl_core.a -Wl,--end-group -lpthread -lm -ldl"

FFTINCL=-I/deac/opt/rocky9-zen4/fftw/3.3.10/include/
FFTLIB="/deac/opt/rocky9-zen4/fftw/3.3.10/lib/libfftw3f.a /deac/opt/rocky9-zen4/fftw/3.3.10/lib/libfftw3.a"

FFTFLAGS=-DNAMD_FFTW -DNAMD_FFTW_3
FFT=\$(FFTINCL) \$(FFTFLAGS)
EOF

cat << EOF > /tmp/NAMD_3.0b6_Source/arch/DEAC.tcl
#TCLDIR=/tmp/NAMD_3.0b6_Source/tcl8.5.9-linux-x86_64
TCLDIR=/tmp/NAMD_3.0b6_Source/tcl8.5.9-linux-x86_64-threaded
TCLINCL=-I\$(TCLDIR)/include
#TCLLIB=-L\$(TCLDIR)/lib -ltcl8.5 -ldl
TCLLIB=-L\$(TCLDIR)/lib -ltcl8.6 -ldl -lpthread
TCLFLAGS=-DNAMD_TCL
TCL=\$(TCLINCL) \$(TCLFLAGS)
EOF

cat << EOF > /tmp/NAMD_3.0b6_Source/arch/DEAC.cuda
# set CUDA base build definitions here
# must also include *.cuda# file for major version #

CUDADIR=/deac/opt/rocky9-noarch/cuda/12.3
CUDAINCL=-I\$(CUDADIR)/include
CUBDIR=.rootdir/cub
CUBINCL=-I\$(CUBDIR)
CUDALIB=-L\$(CUDADIR)/lib64 -lcurand_static -lcufft_static -lculibos -lcudart_static -lrt
CUDASODIR=\$(CUDADIR)/lib64
LIBCUDARTSO=
CUDAFLAGS=-DNAMD_CUDA
CUDAOBJS=\$(CUDAOBJSRAWSTATIC)
CUDA=\$(CUDAFLAGS) -I. \$(CUBINCL) \$(CUDAINCL)
CUDACC=\$(CUDADIR)/bin/nvcc -Xcompiler "-m64"

CUDACCOPTS=-O3 --maxrregcount 48 \$(CUDAGENCODE) \$(CUDA) -use_fast_math
EOF

cat << EOF > /tmp/NAMD_3.0b6_Source/arch/DEAC.cuda12
# CUDA 11 has deprecated compute capability 3.x and 5.x
# limit CUDADLINKOPTS to architectures available in libcufft_static

CUDADLINKOPTS = \
  -gencode arch=compute_70,code=sm_70 \
  -gencode arch=compute_80,code=sm_80 \
  -gencode arch=compute_80,code=compute_80

CUDAGENCODE = \
  -gencode arch=compute_70,code=sm_70 \
  -gencode arch=compute_80,code=sm_80 \
  -gencode arch=compute_80,code=compute_80
EOF
```


```sh
rm -rf /tmp/NAMD_3.0b6_Source/DEAC ; ./config DEAC --with-cuda --cuda-prefix /deac/opt/rocky9-noarch/cuda/12.3 && cd /tmp/NAMD_3.0b6_Source/DEAC && make -j8
```

and lastly, test your new build by running a simple test case,

```sh
./namd3 src/alanin
./charmrun +p2 ./namd3 src/alanin
```

```sh
mkdir -p /deac/opt/rocky9-zen4/namd/
make release
tar -xvf NAMD_3.0b6_DEAC-multicore-CUDA.tar.gz -C /deac/opt/rocky9-zen4/namd/
cd && rm -rf /tmp/NAMD_3.0b6_Source && rm -rf /tmp/NAMD_3.0b6_Source.tar.gz
```
