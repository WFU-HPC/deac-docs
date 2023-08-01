# VTK

## Pending tests

```sh
srun -p gpu -w usb-gpu-03 -n 32 --pty /bin/bash

export SCRATCH="/scratch/$SLURM_JOB_ID"
cd $SCRATCH
wget https://www.vtk.org/files/release/9.2/VTK-9.2.6.tar.gz
tar -xvf VTK-9.2.6.tar.gz
mkdir -p ${SCRATCH}/VTK-9.2.6/build
cd ${SCRATCH}/VTK-9.2.6/build

module purge && module load compilers/gcc/10.2.0 \
                            python/3.8.13 \
                            libs/mesa/20.3.5 \
                            utils/git/2.36.1 \
                            utils/cmake/3.23.1

cmake \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/deac/opt/rhel7/vtk/9.2.6 \
    -DBUILD_SHARED_LIBS:BOOL=ON \
    -DVTK_GROUP_ENABLE_Qt:BOOL=YES \
    -DVTK_QT_VERSION:STRING=5 \
    -DVTK_MODULE_ENABLE_VTK_GUISupportQtQuick:BOOL=NO \
    -DVTK_BUILD_DOCUMENTATION:BOOL=ON \
    -DVTK_BUILD_EXAMPLES:BOOL=ON \
    -DVTK_BUILD_SCALED_SOA_ARRAYS:BOOL=ON \
    -DVTK_BUILD_TESTING:BOOL=OFF \
    -DVTK_GROUP_ENABLE_Imaging:BOOL=YES \
    -DVTK_GROUP_ENABLE_Rendering:BOOL=YES \
    -DVTK_GROUP_ENABLE_StandAlone:BOOL=YES \
    -DVTK_GROUP_ENABLE_Views:BOOL=YES \
    -DVTK_GROUP_ENABLE_Web:BOOL=YES \
    -DVTK_WRAP_PYTHON:BOOL=ON \
    -DVTK_SMP_IMPLEMENTATION_TYPE:STRING=OpenMP \
    ..

make -j32

# Clean and start over
cd ${SCRATCH}/VTK-9.2.6 && rm -rf ${SCRATCH}/VTK-9.2.6/build && mkdir -p ${SCRATCH}/VTK-9.2.6/build && cd ${SCRATCH}/VTK-9.2.6/build
```


## Unexplored options

```sh
    -DVTK_USE_CUDA:BOOL=ON \
    -DVTK_USE_MPI:BOOL=ON \
    -DVTK_GROUP_ENABLE_MPI:BOOL=YES \
```
