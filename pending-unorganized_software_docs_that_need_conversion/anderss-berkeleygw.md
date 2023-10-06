# BerkeleyGW (updated for 2023)

```sh
cd $SCRATCH
tar -xvf ~/BerkeleyGW-3.0.1.tar.gz
cd ${SCRATCH}/BerkeleyGW-3.0.1

cp $RESEARCHPATH/repos/deac-examples/berkeleygw/arch.mk .

module purge && module load compilers/gcc/10.2.0 \
                            compilers/intel/2021.2 \
                            mpi/intel/2021.2 \
                            libs/intel/mkl/2021.2 \
                            utils/cmake/3.23.1 \
                            utils/git/2.36.1

make all-flavors -j8
```
