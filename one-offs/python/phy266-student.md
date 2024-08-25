# PHY266: Introduction to the DEAC Cluster


## Overview

The DEAC Cluster is a shared computing resourced used by 14 different academic
departments across WFU. It is comprised of 100 compute nodes, each with a
minimum of 44 CPU cores and 192 GB of RAM. These resources are managed by the
Slurm job scheduler, and jobs (computing tasks) are submitted by researchers
requesting the resources needed to run the job, as well as the commands needed
to execute the program.

For this class, however, you will be running your Jupyter notebooks and Python
code directly on a special login node, `hydra.deac.wfu.edu`.


## Logging into the DEAC Cluster

The DEAC Cluster is accessible through `hydra.deac.wfu.edu`, and our two
standard login nodes, `pegasus.deac.wfu.edu` and `gemini.deac.wfu.edu`; these
servers act as gateways to the cluster. Each login node is configured in an
identical manner with access to the same storage. The login nodes are servers
where you can upload and download your files to and from the cluster, edit your
code, and submit your jobs to the Slurm scheduler in order to execute your
calculations on the cluster's compute resources.

Separate instructions are provided for accessing the DEAC Cluster using Visual
Studio Code (VS Code), but power users can use any SSH client they wish in order
to access the servers.


## Storing Data

When you first log in to the DEAC Cluster, you are placed in your `$HOME`
directory located under `/home/$USER`. This directory should only be used to
**temporarily** store files. The bulk of your files and programs should be
stored in your $CLASSPATH for this course. Your designated CLASSPATH for this
course is:

```sh
/deac/phy/classes/phy266/YOURUSER
```

where `YOURUSER` is **your username**; i.e., the string in front of the
`@wfu.edu` part of your email. You can navigate to this directory using the cd command, or if using VS Code, you can use the `code` command to open the directory through VS Code's file explorer:

```sh
code /deac/phy/classes/phy266/YOURUSER
```

You can also use the `code` command to create new files or edit existing files be specifying a path to a file instead of a directory:

```sh
code /deac/phy/classes/phy266/YOURUSER/filename.txt
```


## 



```sh
/deac/phy/classes/phy266/python/bin/python3
```

CLOSE REMOTE CONNECTION
