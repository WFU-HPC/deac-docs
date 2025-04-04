#!/bin/bash

mkdir -p /deac/bus/nenovaGrp/r_libs

module load apps/r/4.3.3
R --vanilla -e 'Sys.setenv(GITHUB_PAT = "<your github token>"); remotes::install_github("kwb-r/kwb.ogre", lib="/deac/bus/nenovaGrp/r_libs", upgrade="never")'

export R_LIBS=/deac/bus/nenovaGrp/r_libs
