# DeepSTORM3D

## Stage 1: Running an Interactive Calculation

At first, it may be of interest to run the calculation with the model training visuals enabled. To do this, log in to the cluster,

```sh
ssh -Y gemini
```

and then request GPU resources,

```sh
srun -p gpu -n 1 --mem=16G --gres=gpu:V100:1 --time=00-01:00:00 --x11 --pty /bin/bash
```

where,

```sh
   -n 1             # 1 CPU core
--mem=16G           # 16 GB of memory
--gres=gpu:V100:1   # 1 V100 GPU
--time=00-12:00:00  # 12 Hours
--x11               # Graphical mode
```

This will drop you into an interactive shell on a GPU node. Once you are at the prompt, activate your software environment,

```sh
conda activate deep-storm3d
```

and you can then run the Python programs. For the demo programs, this could look like,

```sh
cd /deac/phy/gholzGrp/software/DeepSTORM3D

python3 demo1.py
python3 demo2.py
python3 demo3.py
python3 demo4.py
python3 demo5.py
```

**NOTE**: you will need to remain logged-in and connected to the cluster for the entire duration of the calculation. This will be unfeasible for long-running calculations.


## Stage 2: Running a Batch (Headless) Calculation

Upcoming!



## Stage 0a: Configuring the Software Environment (ONE-TIME ONLY)

New group members will need to enable the group Miniconda installation in their shell environment. This can be accomplished by adding the following line to your `~/.bashrc` (if you use BASH):

```sh
. "/deac/phy/ghozGrp/software/miniconda3/etc/profile.d/conda.sh"
```

or the following line to your `~/.tcshrc` or `~/.cshrc` (if you use CSH or TCSH):

```sh
source "/deac/phy/ghozGrp/software/miniconda3/etc/profile.d/conda.csh"
```

You will need to log out and back in to the cluster in order for the change to take effect. Once you have done this, you can confirm by running

```sh
which conda
```

which should return something like the paths above.


## Stage 0b: Installing the Software Environment (ONE-TIME ONLY)

This has been set up for you, and you will most likely never need to repeat these steps. They are recorded here for posterity.

Go to your research software path,

```sh
cd /deac/phy/gholzGrp/software
```

and download the latest version of Miniconda:

```sh
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
```

Initiate the installer and follow the prompts,

```sh
sh Miniconda3-latest-Linux-x86_64.sh
```

making sure it installs to `/deac/phy/gholzGrp/software/miniconda3`. Check your `~/.bashrc` or `~/.tcshrc` files to verify that you have it initialized in your environment. You will need to log out of the cluster after installation. Log back in, and return to `/deac/phy/gholzGrp/software`.

Now create a Conda environment with the DeepSTORM3D dependencies,

```sh
conda create --name deep-storm3d --file spec-file.txt
```

This will take a moment. Once completed, go ahead and clone the the main software repository,

```sh
git clone https://github.com:EliasNehme/DeepSTORM3D.git
```

You are now done with the initial software installation. Refer to the sections above for next steps.
