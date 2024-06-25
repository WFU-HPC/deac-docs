```sh
# module load python/3.8.13 \
#             libs/hdf5/gcc/10.2.0 \
#             libs/boost/1.80.0/gcc/10.2.0 \
#             compilers/gcc/10.2.0 \
#             mpi/openmpi/4.1.1/gcc/10.2.0

module load compilers/gcc/12.3.0 mpi/openmpi/4.1.6_gcc libs/hdf5/1.14.3_gcc apps/python/3.11.8

mkdir -p SpinParser && cd SpinParser
git clone https://github.com/fbuessen/SpinParser.git SpinParserSource

find . -type f | xargs sed -i  's/TEST\_EVAL\=\"python/TEST\_EVAL\=\"python3/g'

mkdir -p build && cd build
cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=../install ../SpinParserSource
# cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/tmp/SpinParser/aspinparser/ -DBOOST_ROOT=$BOOST_ROOT -DPYTHON_EXECUTABLE=$(which python3) ../SpinParserSource
cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=../install -DPYTHON_EXECUTABLE=$(which python3) ../SpinParserSource

make -j6
make test # false errors caused by `python` and `env` commands
make install
````
