# WIEN2k (Updated for 2023)

```sh
mkdir -p /deac/opt/rhel7/wien2k/23.2
tar -xvf ~/WIEN2k_23.2.tar -C /deac/opt/rhel7/wien2k/23.2
cp $RESEARCHPATH/tarballs/wien2k/* /deac/opt/rhel7/wien2k/23.2
cd /deac/opt/rhel7/wien2k/23.2
for file in ./*; do gunzip $file; done

module load compilers/gcc/10.2.0 \
            compilers/intel/2021.2 \
            mpi/intel/2021.2 \
            libs/intel/mkl/2021.2 \
            libs/fftw/3.3.10/intel/2021.2_impi
            
# libs/libxc/5.2.3/intel/2021.2 \

# ./check_minimal_software_requirements.sh # stupid fftw find
echo "y" | ./expand_lapw
# cp ~/trials/WIEN2k_* ${SCRATCH}/wien2k
./siteconfig_lapw # uuughhhh

# /deac/opt/rhel7/libxc/5.2.3-intel_impi_2021.2_static
# /deac/opt/rhel7/fftw/3.3.10-intel_impi_2021.2
# NMATMAX 116000
# NUME 11600
```
