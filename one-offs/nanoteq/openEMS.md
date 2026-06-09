# dnf install tinyxml-devel CGAL-devel libharu-devel

module load compilers/gcc/12.3.0 libs/hdf5/1.14.6-serial

wget https://vtk.org/files/release/9.6/VTK-9.6.2.tar.gz -O /tmp/VTK-9.6.2.tar.gz
tar -xvf /tmp/VTK-9.6.2.tar.gz -C /tmp

mkdir -p /tmp/vtk-build && cd /tmp/vtk-build

cmake -GNinja /tmp/VTK-9.6.2 -DCMAKE_INSTALL_PREFIX=/deac/opt/rocky9-noarch/vtk/9.6.2 -DVTK_MODULE_ENABLE_VTK_GuiSupportQt=YES -DVTK_MODULE_ENABLE_VTK_ViewsQt=YES

cmake --build /tmp/vtk-build
cmake --install .

cd && rm -rf /tmp/vtk* /tmp/VTK*

cat << EOF > /deac/opt/modulefiles/rocky9-noarch/apps/vtk/9.6.2
#%Module1.0
##
## vtk
##

proc ModulesHelp { } {
    puts stderr {VTK (Visualization Toolkit)}
}

module-whatis {VTK (Visualization Toolkit) is an open-source software system used primarily for 3D computer graphics, image processing, and scientific visualization.}

module load compilers/gcc/12.3.0 libs/hdf5/1.14.6-serial

set version     "9.6.2"
set basedir     "/deac/opt/rocky9-noarch/vtk/9.6.2"

################################################################################
################################################################################

prepend-path    PATH                           \$basedir/bin
prepend-path    LD_LIBRARY_PATH                \$basedir/lib64
prepend-path    LIBRARY_PATH                   \$basedir/lib64
prepend-path    INCLUDE                        \$basedir/include
EOF

################################################################################
################################################################################

module load compilers/gcc/12.3.0 libs/hdf5/1.14.6-serial apps/vtk/9.6.2

git clone --recursive https://github.com/thliebig/openEMS-Project.git /tmp/openEMS-Project
cd /tmp/openEMS-Project
./update_openEMS.sh /deac/opt/rocky9-noarch/openEMS --with-CTB --python

cd && rm -rf /tmp/openEMS-Project

cat << EOF > /deac/opt/modulefiles/rocky9-noarch/apps/openEMS
#%Module1.0
##
## openEMS
##

proc ModulesHelp { } {
    puts stderr {openEMS}
}

module-whatis {openEMS}

module load compilers/gcc/12.3.0 apps/vtk/9.6.2

set basedir     "/deac/opt/rocky9-noarch/openEMS"

################################################################################
################################################################################

prepend-path    PATH                           \$basedir/bin
prepend-path    PATH                           \$basedir/venv/bin
prepend-path    LD_LIBRARY_PATH                \$basedir/lib64
prepend-path    LIBRARY_PATH                   \$basedir/lib64
prepend-path    INCLUDE                        \$basedir/include

setenv          OPENEMS_PYTHON_PATH            \$basedir/venv/bin/python3
setenv          VIRTUAL_ENV                    \$basedir/venv
EOF
