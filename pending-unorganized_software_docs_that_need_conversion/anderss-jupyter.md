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


### Local Mac: Install X11 graphical library

On your local Mac, install the [XQuartz](https://www.xquartz.org/) client; this
will enable graphical applications on the cluster to be rendered on your local
machine.


### Local Mac: Using the built-in macOS terminal

For this exercise, it is probably best to use the built-in macOS terminal,
`Terminal`. You can also use Visual Studio Code, but must add the following
option within your SSH configuration file for the appropriate host:

```
ForwardX11 yes
```


### DEAC: Configuring Jupyter to use Chromium

Lastly, you need to tell Jupyter to use the Chromium browser. Simply add a line
to the Jupyter Notebook configuration file like this:

```sh
mkdir -p ${HOME}/.jupyter/
echo "c.NotebookApp.browser = 'chromium-browser'" >> ${HOME}/.jupyter/jupyter_notebook_config.py
```

You should now log out of the cluster (`exit`) in order for all changes to take
effect.


## DEAC: Running your Jupyter Notebook

You are now ready to run your notebook. Log back into the cluster with the
following command,

```sh
ssh -Y pegasus
```

The `-Y` flag allows for graphical applications to be streamed to your local
machine. Now, request an interactive SLURM session,

```sh
srun -p small --pty --x11 -n 1 --mem=2G --time=00-01:00:00 /bin/bash
```

You can change the requested number of cores `-n`, memory `--mem` and time
`--time` as needed. This command will drop you onto a compute node, where you
can now run your Jupyter Notebook. Load your new software stack with the
following commands,

```sh
module load python/3.8.13 # load the python module
```

It is easiest if you change into your work directory; in this example, I'll
assume your notebook location is here,

```sh
cd ${RESEARCHPATH}/jupyter
```

Once there, execute the Jupyter Notebook server,

```sh
jupyter-notebook
```

This will automatically spawn a new Chromium window on your local machine. You
can then run your notebook as normal.


### DEAC: Using GPU resources

If you require GPU resources for use with Tensorflow or other modules, you will
need to modify a couple of lines from above. Instead of just loading Python,
load

```sh
module load python/3.8.13 cuda/11.7
```

and request a GPU node with the following,

```sh
srun -p gpu --gres=gpu:1 --pty --x11 -n 1 --mem=2G --time=00-01:00:00 /bin/bash
```

Note that the GPUs are significantly more constrained than the CPU resources, so your request could potentially take longer to be allocated.
