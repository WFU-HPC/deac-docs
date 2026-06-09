export TARGET="/deac/opt/rocky9-noarch/dynare/7.1"

module load compilers/gcc/14.3.0 apps/python/3.14.5 apps/matlab/2024a

# python3 -m venv ${HOME}/myenv

. ${HOME}/myenv/bin/activate
# python3 -m pip install meson ninja

################################################################################
## slicot
################################################################################

mkdir -p /tmp/dynare/slicot/lib

wget https://github.com/SLICOT/SLICOT-Reference/archive/refs/tags/v5.9.1.tar.gz -O /tmp/dynare/slicot/slicot-5.9.1.tar.gz
tar -xvf /tmp/dynare/slicot/slicot-5.9.1.tar.gz -C /tmp/dynare/slicot

cd /tmp/dynare/slicot/SLICOT-Reference-5.9.1
sed -i 's/FIND_PACKAGE(\(.*\) REQUIRED)/FIND_PACKAGE(\1)/g' CMakeLists.txt

cmake -B build -DCMAKE_BUILD_TYPE=Release -DBUILD_SHARED_LIBS=OFF -DSLICOT_TESTING=OFF -DSLICOT_INTEGER8=ON
cmake --build build

cp build/lib/libslicot64.a /tmp/dynare/slicot/lib/libslicot64_pic.a

################################################################################
## x13as
################################################################################

mkdir -p /tmp/dynare/x13as

## this POS held me up for 2 f*3king days
# wget https://www2.census.gov/software/x-13arima-seats/x13as/unix-linux/program-archives/x13as_asciisrc-v1-1-b62.tar.gz
tar -xvf /deac/opt/tarballs/x13as/x13as_asciisrc-v1-1-b62.tar.gz -C /tmp/dynare/x13as

cd /tmp/dynare/x13as/x13as_asciisrc-v1-1-b62
sed -i "s|-static| |" makefile.gf
make -f makefile.gf FFLAGS="-O2 -std=legacy" PROGRAM=x13as

mkdir -p ${TARGET}/usr/local/bin
cp x13as ${TARGET}/usr/local/bin/.

export PATH="${TARGET}/usr/local/bin:$PATH"

################################################################################
## dynare
################################################################################

git clone --recurse-submodules https://git.dynare.org/Dynare/dynare.git --single-branch --branch 7.1 /tmp/dynare/repo
cd /tmp/dynare/repo

meson setup -Dmatlab_path=$USE_MATLAB_DIR --buildtype=debugoptimized -Dfortran_args="['-B','/tmp/dynare/slicot/lib']" build-matlab
meson compile -C build-matlab

# meson test -C build-matlab --num-processes=32 # these fail, but I think that it clears the environment which leads to missing libs

DESTDIR=$TARGET meson install -C build-matlab

################################################################################
# post
################################################################################

cd && rm -rf /tmp/dynare

## This is fugly and I hate it. What alternatives?
# MATLAB_LIB=/usr/local/MATLAB/R2025b/sys/os/glnxa64
# for f in $MATLAB_LIB/libgcc_s.so.1 \
#          $MATLAB_LIB/libstdc++.so.6 \
#          $MATLAB_LIB/libgfortran.so.5 \
#          $MATLAB_LIB/libquadmath.so.0; do
#     [ -e "$f" ] && sudo mv "$f" "$f.bak" && echo "Renamed $f to $f.bak"
# done

mkdir -p /deac/opt/modulefiles/rocky9-noarch/apps/dynare
cat << EOF > /deac/opt/modulefiles/rocky9-noarch/apps/dynare/7.1
#%Module
##

proc ModulesHelp { } {
    puts stderr "\tSets up environment for using Dynare."
}

module-whatis   "Sets up environment for using Dynare"

module load compilers/gcc/14.3.0 apps/matlab/2024a

set version  "7.1"
set basedir  "$TARGET"

################################################################################
################################################################################

prepend-path    PATH                \${basedir}/usr/local/bin
prepend-path    MATLABPATH          \${basedir}/usr/local/lib/dynare/matlab

setenv      DYNAREROOT              \$basedir
EOF

################################################################################
################################################################################

cat << EOF > /home/anderss/mymodel.mod
// 1. Variables and Parameters Declaration
var y, c, k, a; 
varexo e;
parameters delta, rho, beta, alpha;

delta = 0.025; // Depreciation rate
rho   = 0.9;   // Shock persistence
beta  = 0.99;  // Discount factor
alpha = 0.3;   // Capital share of output

// 2. The Model Equations (4 variables = 4 equations)
model;
  // Equation 1: Technology process driven by shock 'e'
  a = rho*a(-1) + e; 
  
  // Equation 2: Production function
  y = exp(a) * k(-1)^alpha; 
  
  // Equation 3: Budget / Resource constraint
  c + k = y + (1-delta)*k(-1); 
  
  // Equation 4: Euler Equation (The missing piece!)
  1/c = beta * (1/c(+1)) * (alpha * y(+1)/k + (1-delta));
end;

// 3. Steady State Initial Values
initval;
  a = 0;
  k = 21.3;
  y = 2.5;
  c = 1.97;
end;
steady;

// 4. Shocks and Simulation Commands
shocks;
  var e; stderr 0.01;
end;

stoch_simul(periods=200);
EOF

## once you are in matlab, here's how to test:
dynare mymodel
