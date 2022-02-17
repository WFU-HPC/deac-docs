# Tensorflow

https://www.tensorflow.org/install/source#tensorflow_2x

## Introduction

TensorFlow is an end-to-end open source platform for machine learning. It has 
a comprehensive, flexible ecosystem of tools, libraries and community resources 
that lets researchers push the state-of-the-art in ML and developers easily 
build and deploy ML powered applications.

## Installed Versions

 - 1.14.0

### Prerequisites

gcc 4.8.5, python 3.7.0, CUDA 10.2, cuDNN 7.6.5

```
module load rhel7/gpu/bazel/0.24.1
module load rhel7/gpu/python/3.7.0
module load rhel7/gpu/cuda/10.2

pip install wheel
pip install --upgrade setuptools
```

### Installation

Download src zip file to /deac/opt/src/rhel7
```
cd /deac/opt/src/rhel7/
wget https://github.com/tensorflow/tensorflow/archive/v1.14.0.tar.gz

tar xvf tensorflow-1.14.0.tar.gz 
cd tensorflow-1.14.0
```

Edit the WORKSPACE file and add the following code starting at line 5.

See: https://github.com/tensorflow/tensorflow/issues/28824
```
http_archive(
    name = "io_bazel_rules_docker",
    sha256 = "aed1c249d4ec8f703edddf35cbe9dfaca0b5f5ea6e4cd9e83e99f3b0d1136c3d",
    strip_prefix = "rules_docker-0.7.0",
    urls = ["https://github.com/bazelbuild/rules_docker/archive/v0.7.0.tar.gz"],
)
```
Comment out the statement ```"--bin2c-path=%s" % bin2c.dirname,``` from line 177 in the file third_party/nccl/build_defs.bzl.tpl

See: https://github.com/tensorflow/tensorflow/issues/34429
```
vim third_party/nccl/build_defs.bzl.tpl
```


Run ./configure and select the appropriate options for building with CUDA, and using /usr/bin/gcc

```
./configure 
WARNING: --batch mode is deprecated. Please instead explicitly shut down your Bazel server using the command "bazel shutdown".
You have bazel 0.24.1- (@non-git) installed.
Please specify the location of python. [Default is /deac/opt/rhel7/gpu/python/3.7.0/bin/python]: 

Found possible Python library paths:
  /deac/opt/rhel7/gpu/python/3.7.0/lib/python3.7/site-packages
Please input the desired Python library path to use.  Default is [/deac/opt/rhel7/gpu/python/3.7.0/lib/python3.7/site-packages]

Do you wish to build TensorFlow with XLA JIT support? [Y/n]: N
No XLA JIT support will be enabled for TensorFlow.

Do you wish to build TensorFlow with OpenCL SYCL support? [y/N]: N
No OpenCL SYCL support will be enabled for TensorFlow.

Do you wish to build TensorFlow with ROCm support? [y/N]: N
No ROCm support will be enabled for TensorFlow.

Do you wish to build TensorFlow with CUDA support? [y/N]: Y
CUDA support will be enabled for TensorFlow.

Do you wish to build TensorFlow with TensorRT support? [y/N]: N
No TensorRT support will be enabled for TensorFlow.

Found CUDA 10.2 in:
    /usr/local/cuda/lib64
    /usr/local/cuda/include
Found cuDNN 7 in:
    /usr/lib64
    /usr/include


Please specify a list of comma-separated CUDA compute capabilities you want to build with.
You can find the compute capability of your device at: https://developer.nvidia.com/cuda-gpus.
Please note that each additional compute capability significantly increases your build time and binary size, and that TensorFlow only supports compute capabilities >= 3.5 [Default is: 7.0,7.0,7.0,7.0,7.0,7.0]: 6.0,7.0

Do you want to use clang as CUDA compiler? [y/N]: N
nvcc will be used as CUDA compiler.

Please specify which gcc should be used by nvcc as the host compiler. [Default is /bin/gcc]: /usr/bin/gcc

Do you wish to build TensorFlow with MPI support? [y/N]: N
No MPI support will be enabled for TensorFlow.

Please specify optimization flags to use during compilation when bazel option "--config=opt" is specified [Default is -march=native -Wno-sign-compare]: 

Would you like to interactively configure ./WORKSPACE for Android builds? [y/N]: N
Not configuring the WORKSPACE for Android builds.

Preconfigured Bazel build configs. You can use any of the below by adding "--config=<>" to your build command. See .bazelrc for more details.
    --config=mkl            # Build with MKL support.
    --config=monolithic     # Config for mostly static monolithic build.
    --config=gdr            # Build with GDR support.
    --config=verbs          # Build with libverbs support.
    --config=ngraph         # Build with Intel nGraph support.
    --config=numa           # Build with NUMA support.
    --config=dynamic_kernels    # (Experimental) Build kernels into separate shared objects.
Preconfigured Bazel build configs to DISABLE default on features:
    --config=noaws          # Disable AWS S3 filesystem support.
    --config=nogcp          # Disable GCP support.
    --config=nohdfs         # Disable HDFS support.
    --config=noignite       # Disable Apache Ignite support.
    --config=nokafka        # Disable Apache Kafka support.
    --config=nonccl         # Disable NVIDIA NCCL support.
Configuration finished
```

Run bazel to build the Python package for tensorflow
```
bazel build --config=opt --config=cuda //tensorflow/tools/pip_package:build_pip_package --verbose_failures
mkdir tmp
./bazel-bin/tensorflow/tools/pip_package/build_pip_package tmp/tensorflow_pkg
```

Install the tensorflow package via pip
```
pip install tmp/tensorflow_pkg/tensorflow-1.14.0-cp37-cp37m-linux_x86_64.whl
```
Verify the installation
```
python -c "import tensorflow as tf; print(tf.contrib.eager.num_gpus())"
```
