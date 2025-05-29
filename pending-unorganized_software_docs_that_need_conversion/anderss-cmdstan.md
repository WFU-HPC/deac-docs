```sh
#!/bin/bash

## build
module load compilers/gcc/12.3.0

mkdir -p /deac/opt/rocky9-noarch/cmdstan
git clone https://github.com/stan-dev/cmdstan.git --recursive --branch v2.36.0 /deac/opt/rocky9-noarch/cmdstan/2.36.0
cd /deac/opt/rocky9-noarch/cmdstan/2.36.0
make build -j16

## testing
make examples/bernoulli/bernoulli
./examples/bernoulli/bernoulli sample data file=examples/bernoulli/bernoulli.data.json
wc -l output.csv
bin/stansummary output.csv
rm output.csv

## module
mkdir -p /deac/opt/modulefiles/rocky9-noarch/apps/cmdstan
cat << EOF > /deac/opt/modulefiles/rocky9-noarch/apps/cmdstan/2.36.0
#%Module
##
## cmdstan

proc ModulesHelp { } {
    puts stderr "\tcmdstan"
}

module-whatis   "cmdstan"

module load compilers/gcc/12.3.0

set basedir         "/deac/opt/rocky9-noarch/cmdstan/2.36.0"

################################################################################
################################################################################

prepend-path    PATH                "\${basedir}/bin"

setenv CMDSTANROOT                  "\$basedir"
EOF

## cmdstanr
module purge
module load apps/cmdstan/2.36.0 apps/r/4.3.3
```

```R
# we recommend running this is a fresh R session or restarting your current session
install.packages("cmdstanr", repos = c('https://stan-dev.r-universe.dev', getOption("repos")))

library(cmdstanr)
set_cmdstan_path(Sys.getenv(c("CMDSTANROOT")))
```
