# export TARGET=/scratch/anderss/software
export TARGET=/deac/bio/lackGrp/sofware

module load compilers/gcc/12.3.0 apps/python/3.11.8

python3 -m venv ${TARGET}/env-mixer
. ${TARGET}/env-mixer/bin/activate
python3 -m pip install numpy pandas scipy numdifftools
git clone --recurse-submodules -j8 https://github.com/precimed/mixer.git ${TARGET}/mixer
mkdir -p ${TARGET}/mixer/src/build
cd ${TARGET}/mixer/src/build
cmake ..
make bgmg -j16

mkdir -p ${TARGET}/data

python3 ${TARGET}/mixer/precimed/mixer.py ld \
   --lib ${TARGET}/mixer/src/build/lib/libbgmg.so \
   --bfile LDSR/1000G_EUR_Phase3_plink/1000G.EUR.QC.2 \
   --out LDSR/1000G_EUR_Phase3_plink/1000G.EUR.QC.2.run4.ld \
   --r2min 0.05 --ldscore-r2min 0.05 --ld-window-kb 30000
