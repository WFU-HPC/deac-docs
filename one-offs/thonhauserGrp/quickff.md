```sh
## Download and install Anaconda2 (ONLY ONCE)
wget https://repo.anaconda.com/archive/Anaconda2-2019.10-Linux-x86_64.sh -O /deac/phy/thonhauserGrp/grahjw21/Anaconda2-2019.10-Linux-x86_64.sh
bash /deac/phy/thonhauserGrp/grahjw21/Anaconda2-2019.10-Linux-x86_64.sh -b -p /deac/phy/thonhauserGrp/grahjw21/anaconda2

## Source the new installation
. /deac/phy/thonhauserGrp/grahjw21/anaconda2/etc/profile.d/conda.sh

## Activate the base environment
conda activate

## Install the necessary pip packages in the base environment (ONLY ONCE)
python2 -m pip install importlib-resources molmod yaff

## Download and install QuickFF (ONLY ONCE)
wget https://github.com/molmod/QuickFF/archive/refs/tags/v2.2.8.tar.gz -O /deac/phy/thonhauserGrp/grahjw21/QuickFF-2.2.8.tar.gz
tar -xf /deac/phy/thonhauserGrp/grahjw21/QuickFF-2.2.8.tar.gz -C /deac/phy/thonhauserGrp/grahjw21/
cd /deac/phy/thonhauserGrp/grahjw21/QuickFF-2.2.8
python2 setup.py install

## Clean up spurious files and directories (ONLY ONCE)
cd $HOME
rm -f /deac/phy/thonhauserGrp/grahjw21/Anaconda2-2019.10-Linux-x86_64.sh
rm -f /deac/phy/thonhauserGrp/grahjw21/QuickFF-2.2.8.tar.gz
rm -rf /deac/phy/thonhauserGrp/grahjw21/QuickFF-2.2.8
```

```sh
## To actually use the software in subsequent log ins:

. /deac/phy/thonhauserGrp/grahjw21/anaconda2/etc/profile.d/conda.sh
conda activate
python2
```
