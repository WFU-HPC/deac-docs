# Building GCC (Updated for 2023)

```sh
export VERSION="12.2.0"
export WORKDIR="$SCRATCH"
export PREFIX="/deac/opt/rhel7/gcc/12.2.0"

wget -P $WORKDIR https://ftp.gnu.org/gnu/gcc/gcc-${VERSION}/gcc-${VERSION}.tar.gz
tar -xvf ${WORKDIR}/gcc-${VERSION}.tar.gz -C $WORKDIR

cd ${WORKDIR}/gcc-${VERSION} && ./contrib/download_prerequisites
mkdir -p ${WORKDIR}/gcc-${VERSION}/build && cd ${WORKDIR}/gcc-${VERSION}/build

../configure --prefix=$PREFIX --enable-languages=c,c++,fortran
time make -j8
make install
```
