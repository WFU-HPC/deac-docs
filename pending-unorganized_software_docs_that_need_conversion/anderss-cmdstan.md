```sh
#!/bin/bash

export TARGET=/deac/sta/classes/sta720/software/cmdstan/2.37.0
export MODULE=/deac/sta/classes/sta720/software/modulefiles/cmdstan/2.37.0

## build
module load compilers/gcc/12.3.0

mkdir -p $(dirname $TARGET)
git clone https://github.com/stan-dev/cmdstan.git --recursive --branch v2.37.0 $TARGET
cd $TARGET
make build -j16

## testing
make examples/bernoulli/bernoulli
./examples/bernoulli/bernoulli sample data file=examples/bernoulli/bernoulli.data.json
wc -l output.csv
bin/stansummary output.csv
rm output.csv

## module
mkdir -p $(dirname $MODULE)
cat << EOF > $MODULE
#%Module
##
## cmdstan

proc ModulesHelp { } {
    puts stderr "\tcmdstan"
}

module-whatis   "cmdstan"

module load compilers/gcc/12.3.0

set basedir         "$TARGET"

################################################################################
################################################################################

prepend-path    PATH                "\${basedir}/bin"

setenv CMDSTANROOT                  "\$basedir"
EOF
```

## cmdstanr

```sh
module purge
module load apps/cmdstan/2.37.0 apps/r/4.3.3
```

```R
# we recommend running this is a fresh R session or restarting your current session
install.packages("cmdstanr", repos = c('https://stan-dev.r-universe.dev', getOption("repos")))

library(cmdstanr)
set_cmdstan_path(Sys.getenv(c("CMDSTANROOT")))
```
