# VASP 6+ (Updated for 2023)

## CPU Version with Intel Toolchain

```sh
cd $SCRATCH

module purge
module load compilers/gcc/10.2.0 \
            compilers/intel/2021.2 \
            mpi/intel/2021.2 \
            libs/intel/mkl/2021.2

tar -xvf /deac/inf/adminGrp/anderss/tarballs/vasp.6.4.2.tgz
cd ${SCRATCH}/vasp.6.4.2/
cp $RESEARCHPATH/repos/deac-config/vasp/makefile.include.intel_impi_omp_mkl makefile.include
time make DEPS=1 -j8 all # 11m35.859s

cd testsuite/
export OMP_NUM_THREADS=1
time ./runtest -f               2> test1.e 1> test1.o # 42m13.496s w/4 cores
time ./runtest -f impi+omp.conf 2> test2.e 1> test2.o # 33m23.328s w/4 cores,2 threads
time ./runtest -f impi+omp.conf 2> test3.e 1> test3.o # 29m52.853s w/4 cores,4 threads
make cleantest

cd ${SCRATCH}/vasp.6.4.2
rm -r ${SCRATCH}/vasp.6.4.2/build

cp -r ${SCRATCH}/vasp.6.4.2 /deac/opt/rhel7/vasp/6.4.2-intel_2021.2
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
