# Building GCC

```sh
export VERSION="9.4.0"
export WORKDIR="$TMPDIR"
export PREFIX="${TMPDIR}/gcc-temp"

wget -P $WORKDIR http://mirrors.concertpass.com/gcc/releases/gcc-${VERSION}/gcc-${VERSION}.tar.gz
tar -xvf ${WORKDIR}/gcc-${VERSION}.tar.gz -C $WORKDIR

cd ${WORKDIR}/gcc-${VERSION} && ./contrib/download_prerequisites
mkdir -p ${WORKDIR}/gcc-${VERSION}/build && cd ${WORKDIR}/gcc-${VERSION}/build

../configure --prefix=$PREFIX --enable-languages=c,c++,fortran
time make -j8
make install
```
