---
title: MPAS Tutorial using Lynx
author: Sean Anderson
date: today
---

# MPAS Tutorial Practice Guide using Lynx and the DEAC Cluster

This is a remastered version of the [MPAS tutorial practice
guide](https://www2.mmm.ucar.edu/projects/mpas/tutorial/Virtual2021/) adapted
for the DEAC Cluster. It has been tested directly on both head-nodes (Gemini and
Pegasus) and Lynx. It should also be adaptable to work via Slurm batch scripts,
but that is untested at the time of this writing. For ease of reference, this
entire guide assumes you are logged into Lynx and running the commands directly
there.

**Table of Contents**

<!-- MarkdownTOC -->

- [Guide Sections](#guide-sections)
    - [Section 0.0: Prerequisites and environment setup \(REQUIRED\)](#section-00-prerequisites-and-environment-setup-required)
    - [Section 1.1: Obtaining the MPAS-Model source code](#section-11-obtaining-the-mpas-model-source-code)
    - [Section 1.2: Compiling the MPAS `init_atmosphere` and `atmosphere` cores](#section-12-compiling-the-mpas-init_atmosphere-and-atmosphere-cores)
    - [Section 1.3: Static, terrestrial field processing](#section-13-static-terrestrial-field-processing)
    - [Section 1.4: Preparing idealized initial conditions](#section-14-preparing-idealized-initial-conditions)
    - [Section 2.1: Interpolating real-data initial conditions](#section-21-interpolating-real-data-initial-conditions)
    - [Section 2.2: Generating SST and sea-ice update files](#section-22-generating-sst-and-sea-ice-update-files)
    - [Section 2.3: Model integration](#section-23-model-integration)
    - [Section 2.4: Obtaining and compiling the `convert_mpas` program](#section-24-obtaining-and-compiling-the-convert_mpas-program)
    - [Section 3.0 and Beyond...](#section-30-and-beyond)
- [Reference: Additional Downloads and Utilities](#reference-additional-downloads-and-utilities)
    - [WPS Geographical Static Data Files](#wps-geographical-static-data-files)
    - [NCAR Python Packages](#ncar-python-packages)
    - [Combined view for NetCDF Libraries](#combined-view-for-netcdf-libraries)

<!-- /MarkdownTOC -->


## Guide Sections


### Section 0.0: Prerequisites and environment setup (REQUIRED)

**You must always do this section first, before continuing on to other sections!
If you want to continue your work at a later time, you can just start from where
you left off but only after repeating the steps in this section!**

You should first load all the necessary modules that will configure your
environment to properly run MPAS:

```sh
module load rhel7/gcc/7.5.0 \
            rhel7/compilers/intel-2018-lp64 \
            rhel7/openmpi/4.0.2-intel-2018 \
            rhel7/netcdf/4.7.4-intel \
            rhel7/netcdf-fortran/4.5.3-intel \
            rhel7/pnetcdf/1.12.1-intel \
            rhel7/pio/2.5.4-intel \
            rhel7/metis/5.1.0-intel \
            rhel7/ncl/6.6.2
```

These modules take advantage of the Intel compiler toolchain, which tends to
produce slightly more optimized (faster) executables. The first two modules are
the GNU Compiler Collection 7.5.0 and the Intel Parallel Suite XE 2018.1, that
provide the necessary C and FORTRAN compilers. The next few modules include
OpenMPI version 4.0.2, NetCDF-C 4.7.4, NetCDF-Fortran 4.5.3, Parallel-NetCDF
1.12.1, ParallelIO (pio) 2.5.4, and Metis 5.1.0; there were all compiled with
the aforementioned Intel toolchain. The last module provides the most recent
version of the NCAR Command Language (NCL), for visualizing and processing
results.

Next, let's set some convenient environment variables that will be used
throughout the remainder of this guide:

```sh
export PATH="/data/convert_mpas:$PATH"                  # convert_mpas to PATH
export NETCDF="/deac/opt/rhel7/mpas-model/view-netcdf"  # Path to NetCDF libs 
export LOWMANGRP="/deac/generalGrp/lowmanGrp"           # Path to lowmanGrp
export MPASORIG="${LOWMANGRP}/mpas_tutorial"            # Example tutorial files
export MPASGEOG="/data/WPS_GEOG/"                       # WPS_GEOG data path
export MPASTOOL="/data/MPAS-Tools"                      # MPAS Tools repo
export MPASTUTO="/data/${USER}/mpas_tutorial"           # Overarching tutorial dir
export MPASROOT="${MPASTUTO}/MPAS-Model"                # MPAS install root
export MPASCASE="${MPASTUTO}/240km_uniform"             # MPAS example dir
export MPASMESH="10242"                                 # MPAS example mesh size
```

These environment variables will make it much easier (and safer) to run the
different parts of this guide. As long as they are set, you should be able to
copy and paste most commands directly. You are encouraged to re-use and modify
these for future simulations.

Lastly, we need to set up a Python environment with the NCAR analysis scripts
that make extensive use of the `PyNGL` and `PyNIO` packages:

```sh
. "/data/anaconda3/etc/profile.d/conda.sh"
export PATH="/data/anaconda3/bin:$PATH"
conda activate pyn_env
```

These packages have already been installed for you within the Anaconda3
Scientific Python distribution. This is a safe and convenient way to have a full
scientific Python stack in your local environment.


### Section 1.1: Obtaining the MPAS-Model source code

Obtaining the software is easy enough; simply create your overarching work
directory, and clone the MPAS-Model repo to the selected location:

```sh
mkdir -p $MPASTUTO
git clone -b develop https://github.com/MPAS-Dev/MPAS-Model.git $MPASROOT
```

**Note**: the `-b develop` flag clones the `develop` branch directly, as this is
the latest version of the software. If you want to use the `master` branch,
simply omit this option.


### Section 1.2: Compiling the MPAS `init_atmosphere` and `atmosphere` cores

We are now ready to compile the two atmosphere cores from the MPAS source code.
Your environment will be properly configured thanks to the modules and
environment variables that were enabled in the preceeding section. You can now
issue the `make` commands as follows:

```sh
cd $MPASROOT

make -j4 ifort CORE=init_atmosphere USE_PIO2=true PRECISION=single AUTOCLEAN=true # 7 min
make clean CORE=atmosphere
make -j4 ifort CORE=atmosphere USE_PIO2=true PRECISION=single # 10 min

cd $MPASTUTO
```

These commands will compile the `init_atmosphere` core, clean the MPAS
infrastructure, and then compile the main `atmosphere` core. The processes will
use 4 CPU cores which greatly accelerates the process. The total time for this
procedure should be around 20 minutes. You can change or add to the build
options as you see fit.


### Section 1.3: Static, terrestrial field processing

Our first example case will use a mesh that needs to be downloaded first. Create
your example directory, download the mesh, and uncompress it:

```sh
mkdir -p $MPASCASE
wget -P $MPASCASE http://www2.mmm.ucar.edu/projects/mpas/atmosphere_meshes/x1.${MPASMESH}.tar.gz
tar -xvf ${MPASCASE}/x1.${MPASMESH}.tar.gz -C ${MPASCASE}/ && rm ${MPASCASE}/x1.${MPASMESH}.tar.gz
```

You obviously can change the `$MPASMESH` variable if you want to experiment with
different mesh sizes. For ease of typing, create a symbolic link to the newly
compiled `init_atomosphere` core into the directory:

```sh
ln -sf ${MPASROOT}/init_atmosphere_model $MPASCASE
```

Rather than copying and modifying the configuration files, we will simply
generate them from scratch as follows:

```sh
cat >${MPASCASE}/namelist.init_atmosphere <<EOL
&nhyd_model
    config_init_case = 7
/
&data_sources
    config_geog_data_path = '${MPASGEOG}'
    config_landuse_data = 'MODIFIED_IGBP_MODIS_NOAH'
    config_topo_data = 'GMTED2010'
    config_vegfrac_data = 'MODIS'
    config_albedo_data = 'MODIS'
    config_maxsnowalbedo_data = 'MODIS'
    config_supersample_factor = 3
/
&preproc_stages
    config_static_interp = true
    config_native_gwd_static = true
    config_vertical_grid = false
    config_met_interp = false
    config_input_sst = false
    config_frac_seaice = false
/
EOL

cat >${MPASCASE}/streams.init_atmosphere <<EOL
<streams>
<immutable_stream name="input"
                  type="input"
                  filename_template="x1.${MPASMESH}.grid.nc"
                  input_interval="initial_only" />

<immutable_stream name="output"
                  type="output"
                  filename_template="x1.${MPASMESH}.static.nc"
                  packages="initial_conds"
                  output_interval="initial_only" />

<immutable_stream name="surface"
                  type="output"
                  filename_template="x1.${MPASMESH}.sfc_update.nc"
                  filename_interval="none"
                  packages="sfc_update"
                  output_interval="86400" />

<immutable_stream name="lbc"
                  type="output"
                  filename_template="lbc.\$Y-\$M-\$D_\$h.\$m.\$s.nc"
                  filename_interval="output_interval"
                  packages="lbcs"
                  output_interval="3:00:00" />

</streams>
EOL
```

This allows us to use some of our convenient environment variables to
dynamically populate the files. This approach can be easily reused in a
BASH/Slurm script, and dramatically reduces typos and other common mistakes.

We are now prepared to run the initialization; this process uses only one CPU
core and is thus perfect for being run in parallel with other cases. Enter your
example case directory and run the model:

```sh
# Takes around 25 min (see ${MPASORIG}/job_scripts/init_real.pbs)
cd $MPASCASE && ./init_atmosphere_model
```

The path to the NCAR-provided scheduler script is provided for reference.
**Note**: You will get a series of `GPTL` warnings as your simulation is
running. These are related to a specific "feature" of the PIO library, and can
be safely ignored.


### Section 1.4: Preparing idealized initial conditions

Idealized initial conditions need to be calculated with configuration files that
are downloaded from the MPAS website,

```sh
wget -P $MPASTUTO http://www2.mmm.ucar.edu/projects/mpas/test_cases/v7.0/supercell.tar.gz
tar -xvf ${MPASTUTO}/supercell.tar.gz -C ${MPASTUTO} && rm ${MPASTUTO}/supercell.tar.gz
```

and like before, creating symbolic links for the compiled cores will make things
easier for us:

```sh
ln -s ${MPASROOT}/init_atmosphere_model ${MPASTUTO}/supercell
ln -s ${MPASROOT}/atmosphere_model ${MPASTUTO}/supercell
```

We are now ready to calculate the idealized model. Enter the newly created
`supercell` directory, and execute both parts of the simulation:

```sh
# Takes around 11 min (see ${MPASORIG}/job_scripts/supercell.pbs)
cd ${MPASTUTO}/supercell && ./init_atmosphere_model && mpirun -np 8 ./atmosphere_model
```

Again, note that the initialization only utilizes a single CPU core while the
`atmosphere` core can be parallelized via MPI; running on 8 cores takes around
10 minutes. As above, the path to the NCAR-provided scheduler script is provided
for reference.

You may visualize your results by running the `supercell.ncl` NCL script, that
should produce time-dependent plots of several model fields,

```sh
cd ${MPASTUTO}/supercell && ncl ${MPASTUTO}/supercell/supercell.ncl
```

and will generate a `supercell.pdf` file that can be reviewed on your personal
computer.


### Section 2.1: Interpolating real-data initial conditions

Use the `plot_terrain.py` Python script to generate a terrain plot `terrain.png`
from the newly generated static fields,

```sh
python3 ${MPASORIG}/python_scripts/plot_terrain.py ${MPASCASE}/x1.${MPASMESH}.static.nc
```

for you to check and compare with the reference image from the original guide.

It is now necessary to interpolate the atmosphere and land-surface initial
conditions for the 240-km simulation. Create symbolic links for the NCEP GFS
data that is in the original tutorial files,

```sh
ln -sf ${MPASORIG}/met_data/GFS\:2014-09-10_00 $MPASCASE
```

and create the new `namelist` and `streams` files just like we did before:

```sh
cat >${MPASCASE}/namelist.init_atmosphere <<EOL
&nhyd_model
    config_init_case = 7
    config_start_time = '2014-09-10_00:00:00'
/
&dimensions
    config_nvertlevels = 41
    config_nsoillevels = 4
    config_nfglevels = 38
    config_nfgsoillevels = 4
/
&data_sources
    config_met_prefix = 'GFS'
    config_use_spechumd = false
/
&vertical_grid
    config_ztop = 30000.0
    config_nsmterrain = 1
    config_smooth_surfaces = true
    config_dzmin = 0.3
    config_nsm = 30
    config_tc_vertical_grid = true
    config_blend_bdy_terrain = false
/
&interpolation_control
    config_extrap_airtemp = 'linear'
/
&preproc_stages
    config_static_interp = false
    config_native_gwd_static = false
    config_vertical_grid = true
    config_met_interp = true
    config_input_sst = false
    config_frac_seaice = true
/
EOL

cat >${MPASCASE}/streams.init_atmosphere <<EOL
<streams>
<immutable_stream name="input"
                  type="input"
                  filename_template="x1.${MPASMESH}.static.nc"
                  input_interval="initial_only" />

<immutable_stream name="output"
                  type="output"
                  filename_template="x1.${MPASMESH}.init.nc"
                  packages="initial_conds"
                  output_interval="initial_only" />

<immutable_stream name="surface"
                  type="output"
                  filename_template="x1.${MPASMESH}.sfc_update.nc"
                  filename_interval="none"
                  packages="sfc_update"
                  output_interval="86400" />

<immutable_stream name="lbc"
                  type="output"
                  filename_template="lbc.\$Y-\$M-\$D_\$h.\$m.\$s.nc"
                  filename_interval="output_interval"
                  packages="lbcs"
                  output_interval="3:00:00" />

</streams>
EOL
```

The initialization for this case only takes a few seconds (thankfully),

```sh
# Takes around 30 seconds (see ${MPASORIG}/job_scripts/init_real.pbs)
cd $MPASCASE && time ./init_atmosphere_model
```

and we can now visualize the interpolation using another Python script,

```sh
python3 ${MPASORIG}/python_scripts/plot_tsk.py ${MPASCASE}/x1.${MPASMESH}.init.nc
```

which will produce the `tsk.png` file for you to compare.


### Section 2.2: Generating SST and sea-ice update files

In order to create an SST update file, we will make use of a sequence of
intermediate files containing SST and sea-ice analyses that are available in
`${MPASORIG}/met_data`. Before proceeding, we'll link all of these SST
intermediate files into our working directory,

```sh
ln -sf ${MPASORIG}/met_data/SST* $MPASCASE
```

and generate our input files as usual,

```sh
cat >${MPASCASE}/namelist.init_atmosphere <<EOL
&nhyd_model
    config_init_case = 8
    config_start_time = '2014-09-10_00:00:00'
    config_stop_time = '2014-09-20_00:00:00'
/

&data_sources
    config_sfc_prefix = 'SST'
    config_fg_interval = 86400
/

&preproc_stages
    config_static_interp = false
    config_native_gwd_static = false
    config_vertical_grid = false
    config_met_interp = false
    config_input_sst = true
    config_frac_seaice = true
/
EOL

cat >${MPASCASE}/streams.init_atmosphere <<EOL
<streams>
<immutable_stream name="input"
                  type="input"
                  filename_template="x1.${MPASMESH}.static.nc"
                  input_interval="initial_only" />

<immutable_stream name="output"
                  type="output"
                  filename_template="x1.${MPASMESH}.init.nc"
                  packages="initial_conds"
                  output_interval="initial_only" />

<immutable_stream name="surface"
                  type="output"
                  filename_template="x1.${MPASMESH}.sfc_update.nc"
                  filename_interval="none"
                  packages="sfc_update"
                  output_interval="86400" />

<immutable_stream name="lbc"
                  type="output"
                  filename_template="lbc.\$Y-\$M-\$D_\$h.\$m.\$s.nc"
                  filename_interval="output_interval"
                  packages="lbcs"
                  output_interval="3:00:00" />

</streams>
EOL
```

Initialize your example case once again (takes only a few seconds):

```sh
cd $MPASCASE && ./init_atmosphere_model
```

You can proceed to visualize the difference in the SST field between the last time
in the surface update file and the new time in the updated file with the handy
Python script,

```sh
python3 ${MPASORIG}/python_scripts/plot_delta_sst.py ${MPASCASE}/x1.${MPASMESH}.static.nc ${MPASCASE}/x1.${MPASMESH}.sfc_update.nc
```

which will produce the `delta_sst.png` file for you to enjoy.


### Section 2.3: Model integration

After 7 sections of preamble, we are finally ready to run the main `atmosphere`
core. Do some initial prep-work,

```sh
ln -sf ${MPASROOT}/atmosphere_model $MPASCASE
cp ${MPASROOT}/namelist.atmosphere $MPASCASE
cp ${MPASROOT}/streams.atmosphere $MPASCASE
cp ${MPASROOT}/stream_list.atmosphere.* $MPASCASE
```

and link the parameterization files to your example case,

```sh
ln -sf ${MPASROOT}/src/core_atmosphere/physics/physics_wrf/files/* $MPASCASE
```

We now need to fine-tune only specific parameters of the rather long
`namelist.atmosphere` and `streams.atmosphere` files. The following two snippets
are a quick and very dirty way of accomplishing this, but you should apply
smarter methods when working on production runs. For `namelist.atmosphere`:

```sh
sed -i -e "s/config_dt = 720.0/config_dt = 1200.0/g" \
       -e "s/config_start_time = '2010-10-23_00:00:00'/config_start_time = '2014-09-10_00:00:00'/g" \
       -e "s/config_len_disp = 120000.0/config_len_disp = 240000.0/g" \
       -e "s/config_block_decomp_file_prefix = 'x1.40962.graph.info.part.'/config_block_decomp_file_prefix = 'x1.${MPASMESH}.graph.info.part.'/g" \
       -e "s/config_radtlw_interval = '00:30:00'/config_radtsw_interval = '00:30:00'/g" \
       -e "s/config_radtlw_interval = '01:00:00'/config_radtsw_interval = '01:00:00'/g" \
    ${MPASCASE}/namelist.atmosphere
```

and `streams.atmosphere`:

```sh
sed -i -e "s/40962/${MPASMESH}/g" \
       -e 's/input_interval="none" >/input_interval="86400" >/g' \
    ${MPASCASE}/streams.atmosphere
```

At long last, run the Atmosphere model for your example case:

```sh
# Takes around 6 minutes (see ${MPASORIG}/job_scripts/run_model.pbs)
cd $MPASCASE && mpirun -np 12 ./atmosphere_model
```

**NOTE: Sometimes these simulations will hang if too many MPI tasks are
requested. You should always monitor your progress via the log file:**

```sh
tail -f ${MPASCASE}/log.atmosphere.0000.out 
```

**If your simulation is hanging, it will stall at this point:**

```
  ** Attempting to bootstrap MPAS framework using stream: input
 Bootstrapping framework with mesh fields from input file 'x1.${MPASMESH}.init.nc'
```

but outside of that will appear as if it is running as normal! **You will NOT
get an error message!** If this happens, simply kill your calculation and lower
the number of MPI processes. The log should be updating continuously throughout
the simulation!


### Section 2.4: Obtaining and compiling the `convert_mpas` program

This program has already been compiled for you, and is available at
`/data/convert_mpas`. You add it to your `$PATH` in the first section.
Unfortunately, this program does not like the Intel compilers nor how the NetCDF
libraries are set-up on the cluster, so it has been statically compiled on a
different machine using the GNU toolchain. The provided binary works perfectly
fine on the cluster.


### Section 3.0 and Beyond...

The full tutorial is quite long, and is outside the scope of this general guide;
however, it should be clear from the above that MPAS has been successfully
ported over to DEAC/Lynx. The remainder of the original tutorial can be followed
in a similar fashion.

The MPAS Tools have already been downloaded at `$MPASTOOL` and can be compiled
following the instructions in the guide (the `grid_rotate` tool has already been
compiled), as long as you set up your environment as in Section 0.0.


## Reference: Additional Downloads and Utilities


### WPS Geographical Static Data Files

If you have not done so already, you need to download the WPS V4 geographical
static data files. Unfortunately, the single high-res download does not include
all the information needed to run the simulations; see [this
link](https://forum.mmm.ucar.edu/phpBB3/viewtopic.php?t=5548) for more
information. For the sake of this guide, you can simply use the following
commands to download and uncompress the files to your location of choice
(`/data` in this example). Change the `$DATADIR` variable to whatever works
best. You only need to do this once, as this data can be reused for all future
simulations.

```sh
export DATADIR="/data"

wget -P $DATADIR https://www2.mmm.ucar.edu/wrf/src/wps_files/geog_high_res_mandatory.tar.gz
wget -P $DATADIR https://www2.mmm.ucar.edu/wrf/src/wps_files/greenfrac.tar.bz2
wget -P $DATADIR https://www2.mmm.ucar.edu/wrf/src/wps_files/landuse_30s.tar.bz2
wget -P $DATADIR https://www2.mmm.ucar.edu/wrf/src/wps_files/modis_landuse_20class_30s.tar.bz2

tar -xvf ${DATADIR}/geog_high_res_mandatory.tar.gz    -C ${DATADIR}/          && rm ${DATADIR}/geog_high_res_mandatory.tar.gz
tar -xvf ${DATADIR}/greenfrac.tar.bz2                 -C ${DATADIR}/WPS_GEOG/ && rm ${DATADIR}/greenfrac.tar.bz2
tar -xvf ${DATADIR}/landuse_30s.tar.bz2               -C ${DATADIR}/WPS_GEOG/ && rm ${DATADIR}/landuse_30s.tar.bz2
tar -xvf ${DATADIR}/modis_landuse_20class_30s.tar.bz2 -C ${DATADIR}/WPS_GEOG/ && rm ${DATADIR}/modis_landuse_20class_30s.tar.bz2
```


### NCAR Python Packages

```sh
. "/data/anaconda3/etc/profile.d/conda.sh"
export PATH="/data/anaconda3/bin:$PATH"
```

```sh
conda create --name pyn_env --channel conda-forge pyngl netcdf4
```


### Combined view for NetCDF Libraries

Some software (like MPAS) requires both the C and FORTRAN NetCDF libraries to be
available under a single prefix. This is obviously not standard practice. To
solve this, I used Spack to create a unified view containing both libraries
(with no dependencies):

```sh
spack view -d false symlink /deac/opt/rhel7/mpas-model/view-netcdf netcdf-c netcdf-fortran
```

This command will create symlinks to the specified packages with the correct
layout; i.e. `bin`, `lib`, `include`, etc. With the new view, the user can
simply

```sh
export NETCDF=/deac/opt/rhel7/mpas-model/view-netcdf
```

and MPAS will now properly detect the combined NetCDF libraries.
