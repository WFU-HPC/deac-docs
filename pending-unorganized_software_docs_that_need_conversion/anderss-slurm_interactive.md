# Interactive jobs on the DEAC Cluster

If you want an interactive session, you have two choices:

1. Use `salloc` to allocate the resources for the job, and then run your commands directly on the head-node. MPI programs will run automatically on the compute nodes but you will remain logged in on the head-node at all times. For instance,

```sh
# prepare environment
module load compilers/gcc/12.3.0 mpi/openmpi/4.1.6

# request interactive session (verify with `squeue -u $USER`)
# you are still on head-node, but in new bash shell
salloc --partition=small --node-list=cpu-intel-01 --nodes=1 --ntasks-per-node=4 --mem=1G --time=00-00:05:00 /bin/bash

# run commands
mpirun hw_mpi

    Hello world from rank 1 out of 4 processors with name cpu-intel-01.deac.wfu.edu
    Hello world from rank 2 out of 4 processors with name cpu-intel-01.deac.wfu.edu
    Hello world from rank 3 out of 4 processors with name cpu-intel-01.deac.wfu.edu
    Hello world from rank 0 out of 4 processors with name cpu-intel-01.deac.wfu.edu

# exit out of shell to deallocate the resources
exit
    salloc: Relinquishing job allocation 1393929
```

2. Use `srun` as to generate a pseudoterminal on a compute node, and then run `mpirun` using `rsh` instead of the default Slurm bindings. For instance,

```sh
# execute bash via pseudoterminal directly on node. you will be dropped into a new shell on the compute node
srun --partition=small --nodelist=cpu-intel-01 --nodes=1 --ntasks-per-node=4 --mem=1GB --time=00-00:05:00 --pty /bin/bash

# prepare environment
module load compilers/gcc/12.3.0 mpi/openmpi/4.1.6

# run commands
mpirun hw_mpi

    Hello world from rank 0 out of 4 processors with name cpu-intel-01.deac.wfu.edu
    Hello world from rank 1 out of 4 processors with name cpu-intel-01.deac.wfu.edu
    Hello world from rank 2 out of 4 processors with name cpu-intel-01.deac.wfu.edu
    Hello world from rank 3 out of 4 processors with name cpu-intel-01.deac.wfu.edu

## DEPRECATED BUT KEPT FOR HISTORICAL REASONS
## run commands; however, we need to use rsh and specify the OpenMPI prefix
## this allows the internode connectivity within the srun interactive session
## and correctly populates the environment in the secondary node(s)
## $MPIHOME comes from the aformentioned modulefile
# mpirun --prefix $MPIHOME -mca plm rsh hw_mpi

# exit out of the pseudoterminal to deallocate the resources
exit
```


## Appendix 1: MPI Hello World

Here is a simple MPI "hello world" program:

```c
#include <mpi.h>
#include <stdio.h>

int main(int argc, char** argv) {
    // Initialize the MPI environment
    MPI_Init(NULL, NULL);

    // Get the number of processes
    int world_size;
    MPI_Comm_size(MPI_COMM_WORLD, &world_size);

    // Get the rank of the process
    int world_rank;
    MPI_Comm_rank(MPI_COMM_WORLD, &world_rank);

    // Get the name of the processor
    char processor_name[MPI_MAX_PROCESSOR_NAME];
    int name_len;
    MPI_Get_processor_name(processor_name, &name_len);

    // Print off a hello world message
    printf("Hello world from rank %d out of %d processors with name %s\n", world_rank, world_size, processor_name);

    // Finalize the MPI environment.
    MPI_Finalize();
}
```

Save that to a file (`mpi_hello_world.c`) and then compile it with:

```sh
mpicc mpi_hello_world.c -o hw_mpi
```


## Appendix 2: Using a GUI via X11 Forwarding (Deprecated)

Using the GUI will require you to remain connected to the cluster for the entire
duration of your work. Severing your connection will kill your job almost
immediately.

For Windows, we recommend using [MobaXterm](https://mobaxterm.mobatek.net/)
which has good X11 capabilities. The free "Home Edition" is perfectly suited for
this task. Set up a new "Session" with SSH and log in to either
`artemis.deac.wfu.edu` or `apollo.deac.wfu.edu` using your username.

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
