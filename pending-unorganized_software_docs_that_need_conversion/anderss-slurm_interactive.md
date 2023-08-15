If you want an interactive session, you have two choices:

1. (Recommended) Use `salloc` to allocate the resources for the job, and then run your commands directly on the head-node. MPI programs will run automatically on the compute nodes but you will remain logged in on the head-node at all times. For instance,

```sh
# prepare environment
module load compilers/gcc/10.2.0 mpi/openmpi/4.1.1/gcc/10.2.0

# request interactive session (verify with `squeue -u $USER`)
# you are still on head-node, but in new bash shell
salloc -p medium -w comp-08-1,comp-08-2 -N 2 --ntasks-per-node 1 --mem 1G --time 00-00:05:00 bash

# run commands
mpirun ./a.out

    Hello world from processor comp-08-1.deac.wfu.edu, rank 0 out of 2 processors
    Hello world from processor comp-08-2.deac.wfu.edu, rank 1 out of 2 processors

# exit out of shell to deallocate the resources
exit
    salloc: Relinquishing job allocation 1393929
```

2. Use `srun` as to generate a pseudoterminal on a compute node, and then run `mpirun` using `rsh` instead of the default Slurm bindings. For instance,

```sh
# execute bash via pseudoterminal directly on node. you will be dropped into a new shell on the compute node
srun -p medium -w comp-08-1,comp-08-2 -N 2 --ntasks-per-node 1 --mem=1GB --time=00-00:05:00 --pty /bin/bash

# prepare environment
module load compilers/gcc/10.2.0 mpi/openmpi/4.1.1/gcc/10.2.0

# run commands; however, we need to use rsh and specify the OpenMPI prefix
# this allows the internode connectivity within the srun interactive session
# and correctly populates the environment in the secondary node(s)
# $MPIHOME comes from the aformentioned modulefile
mpirun --prefix $MPIHOME -mca plm rsh ./a.out

    Hello world from processor comp-08-1.deac.wfu.edu, rank 0 out of 2 processors
    Hello world from processor comp-08-2.deac.wfu.edu, rank 1 out of 2 processors
```

## Using a GUI via X11 Forwarding

Using the GUI will require you to remain connected to the cluster for the entire
duration of your work. Severing your connection will kill your job almost
immediately.

For Windows, we recommend using [MobaXterm](https://mobaxterm.mobatek.net/)
which has good X11 capabilities. The free "Home Edition" is perfectly suited for
this task. Set up a new "Session" with SSH and log in to either
`gemini.deac.wfu.edu` or `pegasus.deac.wfu.edu` using your username.

Once on the cluster, request an interactive SLURM session to gain access to a
compute node:

```sh
srun -p small -n 16 --mem=16GB --time=00-06:00:00 --pty --x11 /bin/bash
```

where:

* `-p` is the partition, can be:
    * 'small' for jobs that take less than 24 hours, and max 1 node (48 cores)
    * 'medium' for jobs that take less than 7 days, max 8 nodes (8x48 cores)
    * 'large' for jobs that take less than 365 days, any number of nodes
* `-n` is the number of cores (between 1 and 48)
* `--mem` is the requested amount of memory (between 1G and 180GB)
* `--time` is the requested time in days-hours:minutes:seconds
* `--pty` is for terminal mode
* `--x11` enables the graphical capabilities
* `/bin/bash` will give you an interactive shell

You are now ready to run the GUI.

When you are finished working, please exit the GUI and then type `exit` in the
interactive shell. This will return you to the head node. Type `exit` again to
close your connection with the cluster.
