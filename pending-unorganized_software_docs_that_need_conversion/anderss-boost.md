# Boost

## Regular Boost done right

```sh
cd $TMPDIR
module load utils/cmake/3.23.1 compilers/gcc/10.2.0
wget https://boostorg.jfrog.io/artifactory/main/release/1.80.0/source/boost_1_80_0.tar.bz2
tar -xvf boost_1_80_0.tar.bz2
cd boost_1_80_0
./bootstrap.sh --prefix=/deac/opt/rhel7/boost/1.80.0
./b2 link=static,shared install
```

## Old Boost with MPI Stuff (originally for libdmet)

```sh
cd $TMPDIR
module load utils/cmake/3.23.1 compilers/gcc/10.2.0 mpi/openmpi/4.1.1/gcc/10.2.0
wget --no-check-certificate http://sourceforge.net/projects/boost/files/boost/1.55.0/boost_1_55_0.tar.bz2
tar -xvf boost_1_55_0.tar.bz2
cd boost_1_55_0
./bootstrap.sh --prefix=/deac/opt/rhel7/boost/1.55.0
echo "using mpi ;" >> project-config.jam
./b2 link=static,shared threading=multi define=_GLIBCXX_USE_CXX11_ABI=0 install
# ./b2 link=static,shared define=_GLIBCXX_USE_CXX11_ABI=0 install
# ./b2 --layout=tagged cxxflags="-std=c++11" link=static,shared threading=multi install
```
