# This if the Jennifer Erway stuff (does NOT require Matlab 2016 and below)

```sh
module load apps/matlab/2024a

# if this is in her directory, just locate "share" within her research path

export SHARE="/home/anderss/share"
export ARCHDEFS="${SHARE}/archdefs-mirror-0.1"
export SIFDECODE="${SHARE}/sifdecode-mirror-0.3"
export CUTEST="${SHARE}/cutest-mirror-0.2"
export MYMATLAB="$USE_MATLAB_DIR"
export MYMATLABBIN="${USE_MATLAB_DIR}/bin/matlab"
export PATH="${SIFDECODE}/bin:${PATH}"
export PATH="${SIFDECODE}/sif:${PATH}"
export PATH="${CUTEST}/bin:${PATH}"
export PATH="${SHARE}/Ipopt-3.12.6/build/bin:${PATH}"
export MANPATH="${SIFDECODE}/man:${MANPATH}"
export MANPATH="${CUTEST}/man:${MANPATH}"
export MASTSIF="${SHARE}/sifdecode-mirror-0.3/sif"
export MYARCH="pc64.lnx.gfo"

# sifdecode has a dependency on libgfortran.so.3, you just need to recompile
cd $SIFDECODE
./install_sifdecode
# answers:
# 6
# 2
# 2
# y
# n
# n
# y

# now you can test as normal, see adjoining matlab script or just copy-paste:
matlab -nojvm -nosplash
```

This is the matlab code:

```matlab
addpath('${SHARE}/cutest-mirror-0.2/src/matlab');
problem = 'BDQRTIC';
eval(['!runcutest -p matlab -D ' problem]);
prob = cutest_setup();
prob
```
