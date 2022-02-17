# CUDA

https://nvidia.com/en-us/

https://docs.nvidia.com/cuda/cuda-installation-guide-linux/index.html

## Introduction

CUDA is a parallel computing platform and programming model developed by NVIDIA
for general computing on graphical processing units (GPUs). With CUDA,
developers are able to dramatically speed up computing applications by
harnessing the power of GPUs.

## Installed Versions

Driver Version: 440.64.00

CUDA Version: 10.2

### Prerequisites

bash, gcc, gcc-c++

### Installation
All NVIDIA related software is installed via rpm. There are five RPMs that need
to be installed for CUDA based programming. These RPMs install the CUDA repo,
device drivers for the P100 and V100 Telsa GPU models, and the cuDNN deep
learning module.

Downloaded .rpm files are stored in /deac/opt/src/rhel7/NVIDIA/drivers

Install RPM containing repo information to download CUDA 10.2
```
cd /deac/opt/src/rhel7/NVIDIA/drivers
rpm -i cuda-repo-rhel7-10-2-local-10.2.89-440.33.01-1.0-1.x86_64.rpm
```

Install RPM containing the most up to date nvidia driver 440.64 versus version
440.33 in the above RPM
```
rpm -i nvidia-driver-local-repo-rhel7-440.64.00-1.0-1.x86_64.rpm
```

Install repo packages via yum
```
yum clean all

yum -y install nvidia-driver-latest-dkms cuda
yum -y install cuda-drivers
```

CUDA is installed locally under /usr/local/cuda

After installing the device drivers, reboot
```
reboot
```

Verify that the NVIDIA drivers are loaded correctly
```
nvidia-smi
```

Install cuDNN RPMs

https://docs.nvidia.com/deeplearning/sdk/cudnn-install/index.html
```
cd /deac/opt/src/rhel7/NVIDIA/drivers
rpm -i libcudnn7-7.6.5.33-1.cuda10.2.x86_64.rpm libcudnn7-devel-7.6.5.33-1.cuda10.2.x86_64.rpm libcudnn7-doc-7.6.5.33-1.cuda10.2.x86_64.rpm
```

### Post Installation

#### Configure nvidia-persistenced

The daemon nvidia-persistenced is used to the ensure the NVIDIA drivers are
loaded across multiple reboots. In the event that the NVIDIA driver fails to
load you will need to uninstall and remove and recomplete the above
installation steps.

init.d script /etc/init.d/
```
#!/bin/sh
#
# nvidia-persistenced:       Starts the Nvidia persistence daemon
#
# chkconfig: 345 99 01
# description: Nvidia perstence daemon keeps nvidia devices present
#
# processname: nvidia-persistenced
# pidfile: /var/run/nvidia-persistenced/lnvidia-persistenced.pid
#

#  load sysconfig configuration file
if [ ! -x /usr/bin/nvidia-smi ]; then
     echo "$0:  Could not find nvidia-smi installation!"
     exit 1
fi

#:x:487:486:NVIDIA persistent software state:/var/run/nvidia-persistenced:/sbin/nologin
NVIDIAPER_USER=nvidia-persistenced
NVIDIAPER_COMMAND=nvidia-persistenced
NVIDIAPER_BINARY=/usr/bin/nvidia-persistenced
NVIDIAPER_LOG=/var/log/nvidia-persistenced.log

###  Sanity checks
if [ ! -f ${NVIDIAPER_BINARY} ]; then
     echo "$0:  Could not find nvidia-persistenced daemon!"
     exit 1
fi

if ! id $NVIDIAPER_USER >& /dev/null; then
     echo "$0:  User $NVIDIAPER_USER not found!"
     exit 1
fi

###  Load Red Hat init functions
. /etc/rc.d/init.d/functions

RETVAL=0

start() {

     touch ${NVIDIAPER_LOG}
     chown ${NVIDIAPER_USER}:${NVIDIAPER_USER} ${NVIDIAPER_LOG}
     chmod 640 ${NVIDIAPER_LOG}

     echo -n $"Starting Nvidia Persistence Daemon: "
     su - $NVIDIAPER_USER -c "${NVIDIAPER_BINARY} --user=${NVIDIAPER_USER} --group=${NVIDIAPER_USER} -V"
     RETVAL=$?
     [ $RETVAL -eq 0 ] && success $"$base startup" || failure $"$base startup"
     echo
     [ $RETVAL -eq 0 ] && touch /var/lock/subsys/nvidia-persistenced
}

stop() {
     echo -n $"Shutting down Nvidia Persistence Daemon: "
     killproc ${NVIDIAPER_COMMAND}
     RETVAL=$?
     echo
     if [ $RETVAL -eq 0 ]; then
          rm -f /var/lock/subsys/nvidia-persistenced
     fi
}

case "$1" in
     start)
          start
          ;;
     stop)
          stop
          ;;
     status)
          status ${NVIDIAPER_COMMAND}
          RETVAL=$?
          ;;
     restart)
          stop
          start
          ;;
     condrestart)
          if [ -f /var/lock/subsys/nvidia-persistenced ]; then
               stop
               start
          fi
          ;;
     *)
          echo $"Usage: $0 {start|stop|status|restart|condrestart}"
          ;;
esac
exit $RETVAL
```
Enable nvidia-persistenced service
```
systemctl enable nvidia-persistenced
```

### Module file

/etc/modulefiles/rhel7/gpu/cuda/10.2

```
#%Module########################################################################
##
## cuda/10.2 modulefile
##

# for Tcl script use only

# Officially is 10.2
set      version  10.2

proc ModulesHelp { } {
    global version

    puts stderr "    This module sets up the environment to use CUDA $version"
}

module-whatis   "Sets up the environment to use CUDA $version"


set CUDADIR /usr/local/cuda-$version

prepend-path PATH  $CUDADIR/bin
prepend-path LD_LIBRARY_PATH $CUDADIR/lib64
```
