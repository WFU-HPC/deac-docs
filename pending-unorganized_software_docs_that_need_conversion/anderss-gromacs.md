# Gromacs


## Preamble

```sh
srun -p gpu -w usb-gpu-01 --pty -n 8 --mem=16G --time=00-02:00:00 /bin/bash
```

```sh
module load python/3.8.13 \
       utils/cmake/3.23.1 \
       utils/hwloc/2.4.1 \
       compilers/gcc/10.2.0 \
       compilers/oneapi/2021.2 \
       mpi/openmpi/4.1.1/oneapi/2021.2 \
       libs/intel/mkl/2021.2
```

```sh
export SCRATCHDIR="/scratch/$SLURM_JOB_ID"
cd $SCRATCHDIR
wget https://ftp.gromacs.org/gromacs/gromacs-2022.3.tar.gz
tar -xvf gromacs-2022.3.tar.gz
```


## CPU+GPU Version

```sh
cd $SCRATCHDIR/gromacs-2022.3
mkdir -p $SCRATCHDIR/gromacs-2022.3/build
cd $SCRATCHDIR/gromacs-2022.3/build
cmake .. -DGMX_FFT_LIBRARY=mkl \
         -DMKL_INCLUDE_DIR="$MKLROOT/include" \
         -DMKL_LIBRARIES="$MKL_SCALAPACK_SEQUENTIAL" \
         -DGMX_THREAD_MPI=ON \
         -DGMX_HWLOC=ON \
         -DCMAKE_INSTALL_PREFIX=/deac/opt/rhel7/gromacs/2022.3_gpu \
         -DGMX_GPU=cuda \
         -DNVCC_HAS_GENCODE_COMPUTE_AND_SM_60=ON \
         -DNVCC_HAS_GENCODE_COMPUTE_AND_SM_70=ON \
         -DNVCC_HAS_GENCODE_COMPUTE_AND_SM_80=ON \
         -DNVCC_HAS_GENCODE_COMPUTE_80=ON
make -j8 && make -j8 check && make install
```


## CPU-Only Version

```sh
cd $SCRATCHDIR/gromacs-2022.3 && rm -rf $SCRATCHDIR/gromacs-2022.3/build
mkdir -p $SCRATCHDIR/gromacs-2022.3/build
cd $SCRATCHDIR/gromacs-2022.3/build
cmake .. -DGMX_FFT_LIBRARY=mkl \
         -DMKL_INCLUDE_DIR="$MKLROOT/include" \
         -DMKL_LIBRARIES="$MKL_SCALAPACK_SEQUENTIAL" \
         -DGMX_THREAD_MPI=ON \
         -DGMX_HWLOC=ON \
         -DCMAKE_INSTALL_PREFIX=/deac/opt/rhel7/gromacs/2022.3
make -j8 && make -j8 check && make install
```


## Running Gromacs

```sh
module load compilers/gcc/10.2.0 \
            compilers/oneapi/2021.2 \
            mpi/openmpi/4.1.1/oneapi/2021.2 \
            libs/intel/mkl/2021.2 \
            utils/hwloc/2.4.1

cd $RESEARCHPATH/

/deac/csc/classes/csc191/2022_spring/data/benchMEM.tpr

gmx mdrun -pin on -s benchMEM.tpr -nsteps 100000 -ntmpi 4 -ntomp 8
```
