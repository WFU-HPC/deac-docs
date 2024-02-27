# SMOG

```sh
module load compilers/gcc/10.2.0 utils/perl/5.38.2

wget --no-check-certificate https://smog-server.org/smog2/code/smog-2.4.5.tgz -O /tmp/smog-2.4.5.tgz

mkdir -p /deac/opt/rhel7-noarch/smog/
tar -xf /tmp/smog-2.4.5.tgz -C /tmp
mv /tmp/smog-2.4.5 /deac/opt/rhel7-noarch/smog/2.4.5
cd /deac/opt/rhel7-noarch/smog/2.4.5
perl4smog=/deac/opt/rhel7-noarch/perl/5.38.2/bin/perl source configure.smog2
cd /deac/opt/rhel7-noarch/smog/2.4.5/SMOG-CHECK
./smog-check

rm -rf /tmp/smog-2.4.5.tgz
```
