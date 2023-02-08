# Using Jupyter Notebooks on the DEAC Cluster

These instructions are for running Jupyter Notebooks on the DEAC cluster. They
are designed to work with a Mac computer that has readily accesible capabilities
for streaming graphical applications from a remote SSH connection. Windows-based
computers can also do this, but require additional software and set up.

**NOTE: this method requires constant connectivity with the cluster. ANY
disruption will most likely kill the job and result in a failed calculation.**


## Preamble & First-time Installation
 
The following few sections detail the installation and configuration of the
required software components for running a Jupyter Notebook on the cluster.
These steps need to be run only one time.


### Local Mac: Install X-forwarding software

On your local Mac, install the [XQuartz](https://www.xquartz.org/) client; this
will enable graphical applications on the cluster to be rendered on your local
machine.


### Local Mac: Using the built-in macOS terminal

For this exercise, it is probably best to use the built-in macOS terminal,
`Terminal`. It is generally more compatible with graphical applications than the
VS Code terminal. For most other purposes related to using the cluster, the two
are equivalent.


### DEAC: Create your Python Stack 

You first need to create our Python software stack. Load the latest Python
module:

```sh
module load python/3.8.13 # load the python module
```

You can now initialize the Python virtual environment into a folder of your
choosing. For this example, I will assume you will use `/deac/egr/divittorioGrp`
as the base for everything; this will be refered to with the `$RESEARCHPATH`
variable. For instance,

```sh
python3 -m venv $RESEARCHPATH/stack-mostafa # create the venv in a dir
```

will install to `/deac/egr/divittorioGrp/stack-mostafa`. Next, activate the
virtual environment,

```sh
source ${RESEARCHPATH}/stack-mostafa/bin/activate # activate the venv
```

Your SHELL prompt will change to reflect the name of this new environment
(`stack-mostafa`). Now that it is active, all installations and changes will
remain isolated but easily shared with your work group.

You can now install the required packages into the new environment using the
standard `pip3` procedure. Add or remove packages from this command and then
copy the entire block to the command line.

```sh
# install desired packages
pip3 install joblib \
             catboost \
             fancyimpute \
             lightgbm \
             shap \
             sklearn \
             xgboost \
             imblearn \
             tensorflow \
             seaborn
```


### Configuring Jupyter to use Chromium

Lastly, you need to tell Jupyter to use the Chromium browser. Simply add a line
to the Jupyter Notebook configuration file like this:

```sh
mkdir -p ${HOME}/.jupyter/
echo "c.NotebookApp.browser = 'chromium-browser'" >> ${HOME}/.jupyter/jupyter_notebook_config.py
```

You should now log out of the cluster (`exit`) in order for all changes to take
effect.


## Running your Jupyter Notebook

You are now ready to run your notebook. Log back into the cluster with the
following command,

```sh
ssh -Y pegasus
```

The `-Y` flag allows for graphical applications to be streamed to your local
machine. Now, request an interactive SLURM session,

```sh
srun -p small --pty --x11 -n 1 --mem=32G --time=00-01:00:00 /bin/bash
```

You can change the requested number of cores `-n`, memory `--mem` and time
`--time` as needed. This command will drop you onto a compute node, where you
can now run your Jupyter Notebook. Load your new software stack with the
following commands,

```sh
module load python/3.8.13 # load the python module
source ${RESEARCHPATH}/stack-mostafa/bin/activate # activate the venv
```

It is easiest if you change into your work directory; in this example, I'll
assume your notebook location is here,

```sh
cd ${RESEARCHPATH}/Mostafa
```

Once there, execute the Jupyter Notebook server,

```sh
jupyter-notebook
```

This will automatically spawn a new Chromium window on your local machine. You
can then run your notebook as normal.


### Using GPU resources

If you require GPU resources for use with Tensorflow or other modules, you will
need to modify a couple of lines from above. Instead of just loading Python,
load

```sh
module load python/3.8.13 cuda/11.7
```

and request a GPU node with the following,

```sh
srun -p gpu --pty --x11 -n 1 --mem=32G --time=00-01:00:00 /bin/bash
```

Note that the GPU nodes are significantly more constrained than the regular
compute nodes, so your request could potentially take longer to be allocated.
