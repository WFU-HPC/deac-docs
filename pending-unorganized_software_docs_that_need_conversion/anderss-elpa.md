# ELPA (IN PROGRESS CONVERTING TO DSS BUT LEADING TO INSANITY)


### Building

```sh
cd $TMPDIR/elpa-2022.05.001
rm -rf build; mkdir -p build && cd build
module purge && module load compilers/gcc/10.2.0 compilers/intel/2021.2 mpi/openmpi/4.1.1/intel/2021.2 libs/intel/mkl/2021.2
../configure \
    FCFLAGS="-O3 -xCORE-AVX512" \
    CFLAGS="-O3 -march=skylake-avx512 -mfma" \
    SCALAPACK_LDFLAGS="${MKL_SCALAPACK_SEQUENTIAL}" \
    SCALAPACK_FCFLAGS="-I${MKLROOT}/include/intel64/lp64" \
    --prefix=/deac/opt/rhel7/elpa/2022.05.001-intel_2021.2 \
    --enable-avx2 \
    --enable-avx512 \
    --enable-option-checking=fatal \
    --enable-scalapack-tests
time make -j8 && make check && make install

    SCALAPACK_FCFLAGS="-I${MKLROOT}/include/intel64/lp64" \
time make -j8 && make check && make install
```


## Useful guides

* https://gitlab.mpcdf.mpg.de/elpa/elpa/-/wikis/INSTALL
* https://github.com/hfp/xconfigure/blob/master/config/elpa/configure-elpa-skx.sh
