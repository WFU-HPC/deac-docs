# Centralized Python Installation on the DEAC Cluster

Standard Python environments, `analysis` and `htmd`, are available in a
centralized installation on the DEAC Cluster. To access them, add the following
line to your `~/.bashrc` if you use Bash,

```sh
. /deac/phy/salsburyGrp/software/miniconda3/etc/profile.d/conda.sh
```

or the following line to your `~/.tcshrc` or `~/.cshrc` if you use tcsh or csh,

```sh
source /deac/phy/salsburyGrp/software/miniconda3/etc/profile.d/conda.csh
```

You should also disable the auto-activation of the `base` environment which can
be a potential source for confusion. Run the following command directly on the
command line:

```sh
conda config --set auto_activate_base false
```

Log out and back in to the cluster for the changes to take effect. You can then
activate the environments per usual:

```sh
conda activate analysis
conda activate htmd
```


## Installation and Maintenance (Power Users Only)

The Miniconda installation is located at
`/deac/phy/salsburyGrp/software/miniconda3`. The steps to install everything are
as follows. First, download the latest Miniconda release,

```sh
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
```

and install it in the desired location,

```sh
sh Miniconda3-latest-Linux-x86_64.sh -b -p /deac/phy/salsburyGrp/software/miniconda3
```

Once you have it initialized in your shell (with `conda init` or instructions
above), update to the latest version of Conda,

```sh
conda update -n base -c defaults conda
```

and install `mamba`,

```sh
conda install -n base -c conda-forge mamba
```

Each environment will have a YAML file with the package specs in it. For
instance, we created the two existing environment files with,

```sh
cat <<EOF >/deac/phy/salsburyGrp/software/miniconda3/envs/analysis.yml
name: analysis
channels:
  - conda-forge
  - omnia
  - defaults
dependencies:
  - python=3.9
  - pdbfixer
  - mdtraj
  - mdanalysis
  - hdbscan
  - pyemma
  - corner
  - python-docx
  - rdkit
  - openmm
EOF
```

and

```sh
cat <<EOF >/deac/phy/salsburyGrp/software/miniconda3/envs/htmd.yml
name: htmd
channels:
  - acellera
  - conda-forge
  - defaults
dependencies:
  - python=3.10
  - htmd
EOF
```

Now that you have the YAML spec files, create the environments:

```sh
conda env create --file /deac/phy/salsburyGrp/software/miniconda3/envs/analysis.yml
mamba env create --file /deac/phy/salsburyGrp/software/miniconda3/envs/htmd.yml
```

**Note** that the `htmd` environment uses `mamba` instead of `conda` which is
the preferred way to install. Lastly, if you ever want to delete the
environments and start over, simply remove them:

```sh
conda remove -n analysis --all
conda remove -n htmd     --all
```


### Updating Environments

It is easy to modify or update the environments. You can interact with them
directly via `conda` or `mamba` commands, but the most sustainable way is by
modifying the appropriate YAML files and running the following commands to
update the environments to match:

```sh
conda env update --file /deac/phy/salsburyGrp/software/miniconda3/envs/analysis.yml --prune
mamba env update --file /deac/phy/salsburyGrp/software/miniconda3/envs/htmd.yml     --prune
```

Maintaining the YAML files adds slight overhead to the process, but is more
consistent and reproducible.
