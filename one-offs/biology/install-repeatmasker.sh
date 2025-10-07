#!/bin/bash

module load compilers/gcc/12.3.0 apps/perl/5.38.2 apps/python/3.11.8

export TARGET="/deac/bio/shogrenGrp/programs"

# mkdir -p $SCRATCH
cd $TARGET

################################################################################
## hmmer
################################################################################

wget --no-check-certificate http://eddylab.org/software/hmmer/hmmer-3.4.tar.gz -O /tmp/hmmer-3.4.tar.gz
tar -zxvf /tmp/hmmer-3.4.tar.gz -C /tmp

cd /tmp/hmmer-3.4
./configure --prefix ${TARGET}/hmmer-3.4
make -j8 && make install

cd /tmp/hmmer-3.4/easel
make install

cd $TARGET
rm -rf /tmp/hmmer-3.4
rm -rf /tmp/hmmer-3.4.tar.gz

################################################################################
## rmblast
################################################################################

wget --no-check-certificate https://ftp.ncbi.nlm.nih.gov/blast/executables/blast+/2.14.1/ncbi-blast-2.14.1+-src.tar.gz -O /tmp/ncbi-blast-2.14.1+-src.tar.gz
wget --no-check-certificate https://www.repeatmasker.org/rmblast/isb-2.14.1+-rmblast.patch.gz -O /tmp/isb-2.14.1+-rmblast.patch.gz

tar -zxvf /tmp/ncbi-blast-2.14.1+-src.tar.gz -C /tmp
gunzip -k /tmp/isb-2.14.1+-rmblast.patch.gz -c > /tmp/isb-2.14.1+-rmblast.patch

cd /tmp/ncbi-blast-2.14.1+-src
patch -p1 < /tmp/isb-2.14.1+-rmblast.patch

cd /tmp/ncbi-blast-2.14.1+-src/c++
./configure --with-mt --without-debug --without-krb5 --without-openssl --with-projects=scripts/projects/rmblastn/project.lst --prefix=${TARGET}/rmblast-2.14.1 AR="gcc-ar -rcs"

time make -j60 # 30 minutes
make check
make install

cd $TARGET
rm -rf /tmp/isb-2.14.1+-rmblast.patch
rm -rf /tmp/isb-2.14.1+-rmblast.patch.gz
rm -rf /tmp/ncbi-blast-2.14.1+-src
rm -rf /tmp/ncbi-blast-2.14.1+-src.tar.gz

################################################################################
## trf
################################################################################

git clone https://github.com/Benson-Genomics-Lab/TRF.git /tmp/TRF

mkdir -p /tmp/TRF/build
cd /tmp/TRF/build

../configure --prefix=${TARGET}/TRF
make

cd /tmp/TRF/t/
/tmp/TRF/build/src/trf test_seqs.fasta 2 5 7 80 10 50 2000 -l 10

cd /tmp/TRF/build
make install

cd $TARGET
rm -rf /tmp/TRF

################################################################################
## repeatmasker
################################################################################

wget --no-check-certificate https://www.repeatmasker.org/RepeatMasker/RepeatMasker-4.2.0.tar.gz -O /tmp/RepeatMasker-4.2.0.tar.gz

tar -xvf /tmp/RepeatMasker-4.2.0.tar.gz -C $TARGET
cd ${TARGET}/RepeatMasker

#/deac/bio/shogrenGrp/programs/TRF/bin/trf
#/deac/bio/shogrenGrp/programs/rmblast-2.14.1/bin
#/deac/bio/shogrenGrp/programs/hmmer-3.4/bin
