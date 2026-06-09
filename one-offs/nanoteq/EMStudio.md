module load compilers/gcc/12.3.0

git clone git@github.com:IHP-GmbH/EMStudio.git /deac/opt/rocky9-noarch/EMStudio

cd /deac/opt/rocky9-noarch/EMStudio
qmake-qt5 EMStudio.pro
make -j16

rm /deac/opt/rocky9-noarch/EMStudio/qt.conf

cat << EOF > /deac/opt/modulefiles/rocky9-noarch/apps/EMStudio
#%Module1.0
##
## EMStudio
##

proc ModulesHelp { } {
    puts stderr {EMStudio}
}

module-whatis {EMStudio}

module load compilers/gcc/12.3.0 apps/openEMS

set basedir     "/deac/opt/rocky9-noarch/EMStudio"

################################################################################
################################################################################

prepend-path    PATH                           \$basedir

setenv          EMSTUDIO_ROOT                  \$basedir/EMStudio
EOF
