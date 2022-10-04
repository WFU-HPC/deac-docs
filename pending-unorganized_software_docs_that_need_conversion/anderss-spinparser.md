```sh
module load python/3.8.13 \
            libs/hdf5/gcc/10.2.0 \
            libs/boost/1.80.0/gcc/10.2.0 \
            compilers/gcc/10.2.0 \
            mpi/openmpi/4.1.1/gcc/10.2.0

cd $TMPDIR
mkdir -p SpinParser && cd SpinParser
git clone https://github.com/fbuessen/SpinParser.git SpinParserSource
mkdir -p build && cd build
# cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=../install ../SpinParserSource
cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/deac/opt/rhel7/spinparser/ -DBOOST_ROOT=$BOOST_ROOT -DPYTHON_EXECUTABLE=$(which python3) ../SpinParserSource
make -j6
make test # false errors caused by `python` and `env` commands
make install
````
