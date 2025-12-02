## Sources

* https://www.cs.virginia.edu/stream/
* https://www.amd.com/en/developer/zen-software-studio/applications/spack/stream-benchmark.html
* https://nvidia.github.io/grace-cpu-benchmarking-guide/foundations/STREAM/index.html


## Building STREAM

```sh
#!/bin/bash
git clone https://github.com/jeffhammond/STREAM.git /opt/STREAM

module load compilers/gcc

cat << EOF > /opt/STREAM/Makefile
CC = gcc
CFLAGS = -Ofast -march=znver3 -mtune=znver3 -fopenmp -mcmodel=large -fno-PIC -DSTREAM_ARRAY_SIZE=430080000 -DNTIMES=100

FC = gfortran
FFLAGS = -O3 -march=znver3 -mtune=znver3 -fopenmp -mcmodel=large -fno-PIC -DSTREAM_ARRAY_SIZE=430080000 -DNTIMES=100

all: stream_f.exe stream_c.exe

stream_f.exe: stream.f mysecond.o
    $(CC) $(CFLAGS) -c mysecond.c
    $(FC) $(FFLAGS) -c stream.f
    $(FC) $(FFLAGS) stream.o mysecond.o -o stream_f.exe

stream_c.exe: stream.c
    $(CC) $(CFLAGS) stream.c -o stream_c.exe

clean:
    rm -f stream_f.exe stream_c.exe *.o

# an example of a more complex build line for the Intel icc compiler
stream.icc: stream.c
    icc -O3 -xCORE-AVX2 -ffreestanding -qopenmp -DSTREAM_ARRAY_SIZE=80000000 -DNTIMES=20 stream.c -o stream.omp.AVX2.80M.20x.icc
EOF

cd /opt/STREAM
make
```


## Running STREAM

```sh
# Optimize OpenMP performance behaviour
export OMP_SCHEDULE=static  # Disable dynamic loop scheduling
export OMP_PROC_BIND=TRUE   # Bind threads to specific resources
export OMP_DYNAMIC=false    # Disable dynamic thread pool sizing

# OMP_PLACES is used for binding OpenMP threads to cores
# See: https://www.openmp.org/spec-html/5.0/openmpse53.html

############# FOR AMD EPYC™ 9654 ##################
# For example, a dual socket AMD 4th Gen EPYC™ Processor with 192 (96x2) cores,
# with 4 threads per L3 cache: 96 total places, stride by 2 cores:
export OMP_PLACES=0:96:2
export OMP_NUM_THREADS=96

############# FOR AMD EPYC™ 9755 ##################
# For example, a dual socket AMD 5th Gen EPYC™ Processor with 256 (128x2) cores,
# with 1 thread per L3 cache: 32 total places, stride by 8 cores:
export OMP_PLACES=0:32:8
export OMP_NUM_THREADS=32

# Running stream
/opt/STREAM/stream_c.exe
```
