wget https://sourceforge.net/projects/gnuplot/files/gnuplot/6.0.5/gnuplot-6.0.5.tar.gz/download -O /tmp/gnuplot-6.0.5.tar.gz

tar -xvf /tmp/gnuplot-6.0.5.tar.gz -C /tmp
cd /tmp/gnuplot-6.0.5

./configure --prefix=/deac/opt/rocky9-noarch/gnuplot/6.0.5 --with-qt=qt5 --with-readline=gnu --without-latex
make -j16
make install


mkdir -p $(dirname /deac/opt/modulefiles/rocky9-noarch/apps/gnuplot/6.0.5)
cat << EOF > /deac/opt/modulefiles/rocky9-noarch/apps/gnuplot/6.0.5
#%Module1.0#####################################################################
##
## Gnuplot 6.0.5 Modulefile
##
proc ModulesHelp { } {
    puts stderr "Loads environment variables for Gnuplot 6.0.5."
}

module-whatis "Gnuplot 6.0.5 - Data and function plotting utility"

set basedir /deac/opt/rocky9-noarch/gnuplot/6.0.5
################################################################################
################################################################################

prepend-path PATH            \$basedir/libexec/gnuplot/6.0
prepend-path PATH            \$basedir/bin
prepend-path MANPATH         \$basedir/share/man

setenv GNUPLOT_ROOT         \$basedir
EOF

rm -rf /tmp/gnuplot-6.0.5*
