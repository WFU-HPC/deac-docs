# where you want the software
export TARGET=/home/anderss/hdeac
mkdir -p $TARGET

################################################################################
# bgen
################################################################################

# gcc compiler
module purge && module load compilers/gcc/12.3.0

# Get BGEN and unpack
wget http://code.enkre.net/bgen/tarball/release/bgen.tgz -O /tmp/bgen.tgz
tar -xvf ~/bgen.tgz -C ${TARGET}
mv ${TARGET}/bgen.tgz ${TARGET}/bgen
cd ${TARGET}/bgen

# Modify BGEN to fix obsolete stuff
sed -i -e 's|-Wno-c++11-long-long||g' ${TARGET}/bgen/3rd_party/boost_1_55_0/wscript
sed -i -e 's|-Wno-c++11-long-long||g' ${TARGET}/bgen/wscript
sed -i -e 's|std::ios::streampos|std::streampos|g' ${TARGET}/bgen/src/View.cpp

# Configure and build
./waf configure
./waf

# test it
./build/test/unit/test_bgen
./build/apps/bgenix -g example/example.16bits.bgen -list

################################################################################
# regenie
################################################################################

# compiler and libs
module purge && module load compilers/gcc/12.3.0 libs/intel/mkl/2023.2.0

# get the software
git clone git@github.com:rgcgithub/regenie.git /tmp/regenie
cd /tmp/regenie

# configure, make, and install
mkdir -p /tmp/regenie/build && cd /tmp/regenie/build
BGEN_PATH="${TARGET}/bgen" cmake .. -DCMAKE_INSTALL_PREFIX=${TARGET}/regenie
make -j8
make install

################################################################################
# cleanup
################################################################################

rm -rf /tmp/bgen.tgz
rm -rf /tmp/regenie
