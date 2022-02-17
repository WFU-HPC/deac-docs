# EasyBuild (WORK IN PROGRESS)


### Dependency graphs (enhancements)

* Develop code to output to Cypher langauge instead of DOT


## Concepts

* [Toolchains](https://easybuild.readthedocs.io/en/latest/eb_list_toolchains.html):
  the tools (compilers, libraries, MPI) that will be used to build a package.
    * [Common
      toolchains](https://easybuild.readthedocs.io/en/latest/Common-toolchains.html):
      EasyBuild already has numerous pre-defined toolchains, based mainly around
      `foss` (GCC, BLAS, LAPACK, ...), and `intel` (Intel compilers, MKL, ...).
    * [Custom
      toolchains](https://github.com/easybuilders/easybuild/wiki/Compiler-toolchains):
      toolchains can be readily created and altered. This is particularly useful
      when you want to mix-and-match components from different toolchains.
    * [System toolchain](): use your own system compilers and libraries.
* [Easyconfigs](https://github.com/easybuilders/easybuild-easyconfigs): config
  files that dictate the toolchain and build options of a given package. This is
  the easiest way to create custom packages for installation.
* [Easyblocks](https://github.com/easybuilders/easybuild-easyblocks): python
  modules that establish the build procedures for every package available in
  EasyBuild. These are separated into generic and software-specific modules; the
  former are used with any package that supports a standard build process, while
  the latter are for packages that require a more customized approach.


## Procedure

Export the necessary Intel license environment variable in order to build the
intel toolchains,

```
export INTEL_LICENSE_FILE=/deac/opt/intel/licenses
export SBATCH_PARTITION=small
export SBATCH_RESERVATION=easybuild
```

Building a software stack with EasyBuild is quite straightforward. We will focus
on the `iomkl-2018b` toolchain, which includes the Intel 2018 compilers, Open
MPI, and the Intel MKL. Times on a single node (Lancaster)

```
foss-2018b.eb                                                       288m09.775s
iomkl-2018b.eb                                                      185m44.639s
intel-2018b.eb                                                      022m28.400s
ABINIT-8.10.3-intel-2018b.eb --try-toolchain=iomkl,2018b            148m08.808s
QuantumESPRESSO-6.4.1-intel-2019a.eb --try-toolchain=iomkl,2018b    237m45.361s
```


## Concerns/Questions


### Dependencies

* investigate `system` toolchain
* develop `iomkl` toolchain, see community efforts
* `--filter-deps` to avoid excessive compiling 
* `--use-existing-modules` doesn't seem to work as I want


### Modulefiles (usage)

* [custom module naming](https://github.com/easybuilders/easybuild/wiki/Using-a-custom-module-naming-scheme)
* moduleclasses alternatives?
* hide dependency modules, but think about better solution
* post-process modules using script


### Slurm job submission (enhancements)

* fix reading of `job` section from config file
* enabling `job=True` in config file does not work correctly
* add memory limiting options
* allow specifying job email
* allow specifying job partition
* job paths (testoutput, output-dir) don't seem to do anything
* save slurm batch scripts for manual execution
