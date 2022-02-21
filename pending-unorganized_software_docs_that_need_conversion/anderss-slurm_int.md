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
