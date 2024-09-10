.. _sec.cluster_gpu:

====================
Cluster GPU Overview
====================

.. contents::
   :depth: 3
..


Overview
========

-  CUDA Toolkit Website [1]_
-  Tesla Based Products [2]_
-  Tesla Software Development Tools [3]_


.. _sec.cluster_gpu.cuda:

CUDA Specifics
==============

There are several CUDA modulefiles to load all starting with **nvidia** followed by installation version and type.

CUDA Installation Directory : /deac/opt/rocky9-noarch/nvidia/$VERSION
CUDA Driver Version / Runtime Version : 11.8.0 / 12.4.1
CUDA Capability Major/Minor version number: 10.0


.. _sec.cluster_gpu.jobsub:

Job Submission
==============

Support for GPU job submission is enabled the GRES (generic resource) configuration within SLURM. [4]_

Users must submit all GPU jobs to the **gpu** partition, and request a minimum of one GPU to successfully start.

.. _sec.cluster_gpu.references:

References
==========

.. raw:: html

   <references/>

.. [1]
   https://developer.nvidia.com/cuda-downloads

.. [2]
   http://www.nvidia.com/object/tesla-servers.html

.. [3]
   http://www.nvidia.com/object/tesla_software.html

.. [4]
   https://slurm.schedmd.com/gres.html


.. _sec.cluster_gpu.devinfo:

Device Information
==================

.. _sec.cluster_gpu.devinfo.a10080gb:

Tesla A100 80GB GPU Nodes
-------------------------

* From gpu-a100-0[1-2] A100_80GB node:

.. code-block:: none

 # module load nvidia/cuda12/cuda/12.4.1; /deac/opt/rocky9-noarch/nvidia/12.4.1/cuda/12.4.1/extras/demo_suite/deviceQuery
 Loading nvidia/cuda12/cuda/12.4.1
  Loading requirement: compilers/gcc/12.3.0
 /deac/opt/rocky9-noarch/nvidia/12.4.1/cuda/12.4.1/extras/demo_suite/deviceQuery Starting...

 CUDA Device Query (Runtime API) version (CUDART static linking)

 Detected 4 CUDA Capable device(s)

 Device 0: "NVIDIA A100 80GB PCIe" (truncated)
 Device 1: "NVIDIA A100 80GB PCIe" (truncated)
 Device 2: "NVIDIA A100 80GB PCIe" (truncated)
 Device 3: "NVIDIA A100 80GB PCIe"
  CUDA Driver Version / Runtime Version          12.4 / 12.4
  CUDA Capability Major/Minor version number:    8.0
  Total amount of global memory:                 81038 MBytes (84974239744 bytes)
  (108) Multiprocessors, ( 64) CUDA Cores/MP:     6912 CUDA Cores
  GPU Max Clock rate:                            1410 MHz (1.41 GHz)
  Memory Clock rate:                             1512 Mhz
  Memory Bus Width:                              5120-bit
  L2 Cache Size:                                 41943040 bytes
  Maximum Texture Dimension Size (x,y,z)         1D=(131072), 2D=(131072, 65536), 3D=(16384, 16384, 16384)
  Maximum Layered 1D Texture Size, (num) layers  1D=(32768), 2048 layers
  Maximum Layered 2D Texture Size, (num) layers  2D=(32768, 32768), 2048 layers
  Total amount of constant memory:               65536 bytes
  Total amount of shared memory per block:       49152 bytes
  Total number of registers available per block: 65536
  Warp size:                                     32
  Maximum number of threads per multiprocessor:  2048
  Maximum number of threads per block:           1024
  Max dimension size of a thread block (x,y,z): (1024, 1024, 64)
  Max dimension size of a grid size    (x,y,z): (2147483647, 65535, 65535)
  Maximum memory pitch:                          2147483647 bytes
  Texture alignment:                             512 bytes
  Concurrent copy and kernel execution:          Yes with 3 copy engine(s)
  Run time limit on kernels:                     No
  Integrated GPU sharing Host Memory:            No
  Support host page-locked memory mapping:       Yes
  Alignment requirement for Surfaces:            Yes
  Device has ECC support:                        Enabled
  Device supports Unified Addressing (UVA):      Yes
  Device supports Compute Preemption:            Yes
  Supports Cooperative Kernel Launch:            Yes
  Supports MultiDevice Co-op Kernel Launch:      Yes
  Device PCI Domain ID / Bus ID / location ID:   0 / 10 / 0
  Compute Mode:
     < Default (multiple host threads can use ::cudaSetDevice() with device simultaneously) >
 > Peer access from NVIDIA A100 80GB PCIe (GPU0) -> NVIDIA A100 80GB PCIe (GPU1) : Yes
 > Peer access from NVIDIA A100 80GB PCIe (GPU0) -> NVIDIA A100 80GB PCIe (GPU2) : Yes
 > Peer access from NVIDIA A100 80GB PCIe (GPU0) -> NVIDIA A100 80GB PCIe (GPU3) : Yes
 > Peer access from NVIDIA A100 80GB PCIe (GPU1) -> NVIDIA A100 80GB PCIe (GPU0) : Yes
 > Peer access from NVIDIA A100 80GB PCIe (GPU1) -> NVIDIA A100 80GB PCIe (GPU2) : Yes
 > Peer access from NVIDIA A100 80GB PCIe (GPU1) -> NVIDIA A100 80GB PCIe (GPU3) : Yes
 > Peer access from NVIDIA A100 80GB PCIe (GPU2) -> NVIDIA A100 80GB PCIe (GPU0) : Yes
 > Peer access from NVIDIA A100 80GB PCIe (GPU2) -> NVIDIA A100 80GB PCIe (GPU1) : Yes
 > Peer access from NVIDIA A100 80GB PCIe (GPU2) -> NVIDIA A100 80GB PCIe (GPU3) : Yes
 > Peer access from NVIDIA A100 80GB PCIe (GPU3) -> NVIDIA A100 80GB PCIe (GPU0) : Yes
 > Peer access from NVIDIA A100 80GB PCIe (GPU3) -> NVIDIA A100 80GB PCIe (GPU1) : Yes
 > Peer access from NVIDIA A100 80GB PCIe (GPU3) -> NVIDIA A100 80GB PCIe (GPU2) : Yes

 deviceQuery, CUDA Driver = CUDART, CUDA Driver Version = 12.4, CUDA Runtime Version = 12.4, NumDevs = 4, Device0 = NVIDIA A100 80GB PCIe, Device1 = NVIDIA A100 80GB PCIe, Device2 = NVIDIA A100 80GB PCIe, Device3 = NVIDIA A100 80GB PCIe Result = PASS


.. _sec.cluster_gpu.devinfo.a10040gb:

Tesla A100 40GB GPU Nodes
-------------------------

* From gpu-a100-0[3-4] A100_40GB node:

.. code-block:: none

 # module load nvidia/cuda12/cuda/12.4.1; /deac/opt/rocky9-noarch/nvidia/12.4.1/cuda/12.4.1/extras/demo_suite/deviceQuery
 Loading nvidia/cuda12/cuda/12.4.1
  Loading requirement: compilers/gcc/12.3.0
 /deac/opt/rocky9-noarch/nvidia/12.4.1/cuda/12.4.1/extras/demo_suite/deviceQuery Starting...

 CUDA Device Query (Runtime API) version (CUDART static linking)

 Detected 4 CUDA Capable device(s)

 Device 0: "NVIDIA A100-PCIE-40GB" (truncated)
 Device 1: "NVIDIA A100-PCIE-40GB" (truncated)
 Device 2: "NVIDIA A100-PCIE-40GB" (truncated)
 Device 3: "NVIDIA A100-PCIE-40GB"
  CUDA Driver Version / Runtime Version          12.4 / 12.4
  CUDA Capability Major/Minor version number:    8.0
  Total amount of global memory:                 40326 MBytes (42285268992 bytes)
  (108) Multiprocessors, ( 64) CUDA Cores/MP:     6912 CUDA Cores
  GPU Max Clock rate:                            1410 MHz (1.41 GHz)
  Memory Clock rate:                             1215 Mhz
  Memory Bus Width:                              5120-bit
  L2 Cache Size:                                 41943040 bytes
  Maximum Texture Dimension Size (x,y,z)         1D=(131072), 2D=(131072, 65536), 3D=(16384, 16384, 16384)
  Maximum Layered 1D Texture Size, (num) layers  1D=(32768), 2048 layers
  Maximum Layered 2D Texture Size, (num) layers  2D=(32768, 32768), 2048 layers
  Total amount of constant memory:               65536 bytes
  Total amount of shared memory per block:       49152 bytes
  Total number of registers available per block: 65536
  Warp size:                                     32
  Maximum number of threads per multiprocessor:  2048
  Maximum number of threads per block:           1024
  Max dimension size of a thread block (x,y,z): (1024, 1024, 64)
  Max dimension size of a grid size    (x,y,z): (2147483647, 65535, 65535)
  Maximum memory pitch:                          2147483647 bytes
  Texture alignment:                             512 bytes
  Concurrent copy and kernel execution:          Yes with 3 copy engine(s)
  Run time limit on kernels:                     No
  Integrated GPU sharing Host Memory:            No
  Support host page-locked memory mapping:       Yes
  Alignment requirement for Surfaces:            Yes
  Device has ECC support:                        Enabled
  Device supports Unified Addressing (UVA):      Yes
  Device supports Compute Preemption:            Yes
  Supports Cooperative Kernel Launch:            Yes
  Supports MultiDevice Co-op Kernel Launch:      Yes
  Device PCI Domain ID / Bus ID / location ID:   0 / 193 / 0
  Compute Mode:
     < Default (multiple host threads can use ::cudaSetDevice() with device simultaneously) >
 > Peer access from NVIDIA A100-PCIE-40GB (GPU0) -> NVIDIA A100-PCIE-40GB (GPU1) : Yes
 > Peer access from NVIDIA A100-PCIE-40GB (GPU0) -> NVIDIA A100-PCIE-40GB (GPU2) : Yes
 > Peer access from NVIDIA A100-PCIE-40GB (GPU0) -> NVIDIA A100-PCIE-40GB (GPU3) : Yes
 > Peer access from NVIDIA A100-PCIE-40GB (GPU1) -> NVIDIA A100-PCIE-40GB (GPU0) : Yes
 > Peer access from NVIDIA A100-PCIE-40GB (GPU1) -> NVIDIA A100-PCIE-40GB (GPU2) : Yes
 > Peer access from NVIDIA A100-PCIE-40GB (GPU1) -> NVIDIA A100-PCIE-40GB (GPU3) : Yes
 > Peer access from NVIDIA A100-PCIE-40GB (GPU2) -> NVIDIA A100-PCIE-40GB (GPU0) : Yes
 > Peer access from NVIDIA A100-PCIE-40GB (GPU2) -> NVIDIA A100-PCIE-40GB (GPU1) : Yes
 > Peer access from NVIDIA A100-PCIE-40GB (GPU2) -> NVIDIA A100-PCIE-40GB (GPU3) : Yes
 > Peer access from NVIDIA A100-PCIE-40GB (GPU3) -> NVIDIA A100-PCIE-40GB (GPU0) : Yes
 > Peer access from NVIDIA A100-PCIE-40GB (GPU3) -> NVIDIA A100-PCIE-40GB (GPU1) : Yes
 > Peer access from NVIDIA A100-PCIE-40GB (GPU3) -> NVIDIA A100-PCIE-40GB (GPU2) : Yes

 deviceQuery, CUDA Driver = CUDART, CUDA Driver Version = 12.4, CUDA Runtime Version = 12.4, NumDevs = 4, Device0 = NVIDIA A100-PCIE-40GB, Device1 = NVIDIA A100-PCIE-40GB, Device2 = NVIDIA A100-PCIE-40GB, Device3 = NVIDIA A100-PCIE-40GB Result = PASS


.. _sec.cluster_gpu.devinfo.v10032gb:

Tesla V100 32 GPU Nodes
-----------------------

* From gpu-v100-01 V100 32GB node:

.. code-block:: none

 # module load nvidia/cuda12/cuda/12.4.1; /deac/opt/rocky9-noarch/nvidia/12.4.1/cuda/12.4.1/extras/demo_suite/deviceQuery
 Loading nvidia/cuda12/cuda/12.4.1
  Loading requirement: compilers/gcc/12.3.0
 /deac/opt/rocky9-noarch/nvidia/12.4.1/cuda/12.4.1/extras/demo_suite/deviceQuery Starting...

 CUDA Device Query (Runtime API) version (CUDART static linking)

 Detected 4 CUDA Capable device(s)

 Device 0: "Tesla V100-PCIE-32GB" (truncated)
 Device 1: "Tesla V100-PCIE-32GB" (truncated)
 Device 2: "Tesla V100-PCIE-32GB" (truncated)
 Device 3: "Tesla V100-PCIE-32GB"
  CUDA Driver Version / Runtime Version          12.4 / 12.4
  CUDA Capability Major/Minor version number:    7.0
  Total amount of global memory:                 32494 MBytes (34072559616 bytes)
  (80) Multiprocessors, ( 64) CUDA Cores/MP:     5120 CUDA Cores
  GPU Max Clock rate:                            1380 MHz (1.38 GHz)
  Memory Clock rate:                             877 Mhz
  Memory Bus Width:                              4096-bit
  L2 Cache Size:                                 6291456 bytes
  Maximum Texture Dimension Size (x,y,z)         1D=(131072), 2D=(131072, 65536), 3D=(16384, 16384, 16384)
  Maximum Layered 1D Texture Size, (num) layers  1D=(32768), 2048 layers
  Maximum Layered 2D Texture Size, (num) layers  2D=(32768, 32768), 2048 layers
  Total amount of constant memory:               65536 bytes
  Total amount of shared memory per block:       49152 bytes
  Total number of registers available per block: 65536
  Warp size:                                     32
  Maximum number of threads per multiprocessor:  2048
  Maximum number of threads per block:           1024
  Max dimension size of a thread block (x,y,z): (1024, 1024, 64)
  Max dimension size of a grid size    (x,y,z): (2147483647, 65535, 65535)
  Maximum memory pitch:                          2147483647 bytes
  Texture alignment:                             512 bytes
  Concurrent copy and kernel execution:          Yes with 7 copy engine(s)
  Run time limit on kernels:                     No
  Integrated GPU sharing Host Memory:            No
  Support host page-locked memory mapping:       Yes
  Alignment requirement for Surfaces:            Yes
  Device has ECC support:                        Enabled
  Device supports Unified Addressing (UVA):      Yes
  Device supports Compute Preemption:            Yes
  Supports Cooperative Kernel Launch:            Yes
  Supports MultiDevice Co-op Kernel Launch:      Yes
  Device PCI Domain ID / Bus ID / location ID:   0 / 193 / 0
  Compute Mode:
     < Default (multiple host threads can use ::cudaSetDevice() with device simultaneously) >
 > Peer access from Tesla V100-PCIE-32GB (GPU0) -> Tesla V100-PCIE-32GB (GPU1) : Yes
 > Peer access from Tesla V100-PCIE-32GB (GPU0) -> Tesla V100-PCIE-32GB (GPU2) : Yes
 > Peer access from Tesla V100-PCIE-32GB (GPU0) -> Tesla V100-PCIE-32GB (GPU3) : Yes
 > Peer access from Tesla V100-PCIE-32GB (GPU1) -> Tesla V100-PCIE-32GB (GPU0) : Yes
 > Peer access from Tesla V100-PCIE-32GB (GPU1) -> Tesla V100-PCIE-32GB (GPU2) : Yes
 > Peer access from Tesla V100-PCIE-32GB (GPU1) -> Tesla V100-PCIE-32GB (GPU3) : Yes
 > Peer access from Tesla V100-PCIE-32GB (GPU2) -> Tesla V100-PCIE-32GB (GPU0) : Yes
 > Peer access from Tesla V100-PCIE-32GB (GPU2) -> Tesla V100-PCIE-32GB (GPU1) : Yes
 > Peer access from Tesla V100-PCIE-32GB (GPU2) -> Tesla V100-PCIE-32GB (GPU3) : Yes
 > Peer access from Tesla V100-PCIE-32GB (GPU3) -> Tesla V100-PCIE-32GB (GPU0) : Yes
 > Peer access from Tesla V100-PCIE-32GB (GPU3) -> Tesla V100-PCIE-32GB (GPU1) : Yes
 > Peer access from Tesla V100-PCIE-32GB (GPU3) -> Tesla V100-PCIE-32GB (GPU2) : Yes

 deviceQuery, CUDA Driver = CUDART, CUDA Driver Version = 12.4, CUDA Runtime Version = 12.4, NumDevs = 4, Device0 = Tesla V100-PCIE-32GB, Device1 = Tesla V100-PCIE-32GB, Device2 = Tesla V100-PCIE-32GB, Device3 = Tesla V100-PCIE-32GB Result = PASS


* From gpu-v100-0[2-3] V100 32GB (Legacy Architecture) nodes:

.. code-block:: none

 # module load nvidia/cuda12/cuda/12.4.1; /deac/opt/rocky9-noarch/nvidia/12.4.1/cuda/12.4.1/extras/demo_suite/deviceQuery
 Loading nvidia/cuda12/cuda/12.4.1
  Loading requirement: compilers/gcc/12.3.0
 /deac/opt/rocky9-noarch/nvidia/12.4.1/cuda/12.4.1/extras/demo_suite/deviceQuery Starting...

 CUDA Device Query (Runtime API) version (CUDART static linking)

 Detected 6 CUDA Capable device(s)

 Device 0: "Tesla V100-PCIE-32GB" (truncated)
 Device 1: "Tesla V100-PCIE-32GB" (truncated)
 Device 2: "Tesla V100-PCIE-32GB" (truncated)
 Device 3: "Tesla V100-PCIE-32GB" (truncated)
 Device 4: "Tesla V100-PCIE-32GB" (truncated)
 Device 5: "Tesla V100-PCIE-32GB"
  CUDA Driver Version / Runtime Version          12.4 / 12.4
  CUDA Capability Major/Minor version number:    7.0
  Total amount of global memory:                 32494 MBytes (34072559616 bytes)
  (80) Multiprocessors, ( 64) CUDA Cores/MP:     5120 CUDA Cores
  GPU Max Clock rate:                            1380 MHz (1.38 GHz)
  Memory Clock rate:                             877 Mhz
  Memory Bus Width:                              4096-bit
  L2 Cache Size:                                 6291456 bytes
  Maximum Texture Dimension Size (x,y,z)         1D=(131072), 2D=(131072, 65536), 3D=(16384, 16384, 16384)
  Maximum Layered 1D Texture Size, (num) layers  1D=(32768), 2048 layers
  Maximum Layered 2D Texture Size, (num) layers  2D=(32768, 32768), 2048 layers
  Total amount of constant memory:               65536 bytes
  Total amount of shared memory per block:       49152 bytes
  Total number of registers available per block: 65536
  Warp size:                                     32
  Maximum number of threads per multiprocessor:  2048
  Maximum number of threads per block:           1024
  Max dimension size of a thread block (x,y,z): (1024, 1024, 64)
  Max dimension size of a grid size    (x,y,z): (2147483647, 65535, 65535)
  Maximum memory pitch:                          2147483647 bytes
  Texture alignment:                             512 bytes
  Concurrent copy and kernel execution:          Yes with 7 copy engine(s)
  Run time limit on kernels:                     No
  Integrated GPU sharing Host Memory:            No
  Support host page-locked memory mapping:       Yes
  Alignment requirement for Surfaces:            Yes
  Device has ECC support:                        Enabled
  Device supports Unified Addressing (UVA):      Yes
  Device supports Compute Preemption:            Yes
  Supports Cooperative Kernel Launch:            Yes
  Supports MultiDevice Co-op Kernel Launch:      Yes
  Device PCI Domain ID / Bus ID / location ID:   0 / 197 / 0
  Compute Mode:
     < Default (multiple host threads can use ::cudaSetDevice() with device simultaneously) >
 > Peer access from Tesla V100-PCIE-32GB (GPU0) -> Tesla V100-PCIE-32GB (GPU1) : Yes
 > Peer access from Tesla V100-PCIE-32GB (GPU0) -> Tesla V100-PCIE-32GB (GPU2) : Yes
 > Peer access from Tesla V100-PCIE-32GB (GPU0) -> Tesla V100-PCIE-32GB (GPU3) : Yes
 > Peer access from Tesla V100-PCIE-32GB (GPU0) -> Tesla V100-PCIE-32GB (GPU4) : Yes
 > Peer access from Tesla V100-PCIE-32GB (GPU0) -> Tesla V100-PCIE-32GB (GPU5) : Yes
 > Peer access from Tesla V100-PCIE-32GB (GPU1) -> Tesla V100-PCIE-32GB (GPU0) : Yes
 > Peer access from Tesla V100-PCIE-32GB (GPU1) -> Tesla V100-PCIE-32GB (GPU2) : Yes
 > Peer access from Tesla V100-PCIE-32GB (GPU1) -> Tesla V100-PCIE-32GB (GPU3) : Yes
 > Peer access from Tesla V100-PCIE-32GB (GPU1) -> Tesla V100-PCIE-32GB (GPU4) : Yes
 > Peer access from Tesla V100-PCIE-32GB (GPU1) -> Tesla V100-PCIE-32GB (GPU5) : Yes
 > Peer access from Tesla V100-PCIE-32GB (GPU2) -> Tesla V100-PCIE-32GB (GPU0) : Yes
 > Peer access from Tesla V100-PCIE-32GB (GPU2) -> Tesla V100-PCIE-32GB (GPU1) : Yes
 > Peer access from Tesla V100-PCIE-32GB (GPU2) -> Tesla V100-PCIE-32GB (GPU3) : Yes
 > Peer access from Tesla V100-PCIE-32GB (GPU2) -> Tesla V100-PCIE-32GB (GPU4) : Yes
 > Peer access from Tesla V100-PCIE-32GB (GPU2) -> Tesla V100-PCIE-32GB (GPU5) : Yes
 > Peer access from Tesla V100-PCIE-32GB (GPU3) -> Tesla V100-PCIE-32GB (GPU0) : Yes
 > Peer access from Tesla V100-PCIE-32GB (GPU3) -> Tesla V100-PCIE-32GB (GPU1) : Yes
 > Peer access from Tesla V100-PCIE-32GB (GPU3) -> Tesla V100-PCIE-32GB (GPU2) : Yes
 > Peer access from Tesla V100-PCIE-32GB (GPU3) -> Tesla V100-PCIE-32GB (GPU4) : Yes
 > Peer access from Tesla V100-PCIE-32GB (GPU3) -> Tesla V100-PCIE-32GB (GPU5) : Yes
 > Peer access from Tesla V100-PCIE-32GB (GPU4) -> Tesla V100-PCIE-32GB (GPU0) : Yes
 > Peer access from Tesla V100-PCIE-32GB (GPU4) -> Tesla V100-PCIE-32GB (GPU1) : Yes
 > Peer access from Tesla V100-PCIE-32GB (GPU4) -> Tesla V100-PCIE-32GB (GPU2) : Yes
 > Peer access from Tesla V100-PCIE-32GB (GPU4) -> Tesla V100-PCIE-32GB (GPU3) : Yes
 > Peer access from Tesla V100-PCIE-32GB (GPU4) -> Tesla V100-PCIE-32GB (GPU5) : Yes
 > Peer access from Tesla V100-PCIE-32GB (GPU5) -> Tesla V100-PCIE-32GB (GPU0) : Yes
 > Peer access from Tesla V100-PCIE-32GB (GPU5) -> Tesla V100-PCIE-32GB (GPU1) : Yes
 > Peer access from Tesla V100-PCIE-32GB (GPU5) -> Tesla V100-PCIE-32GB (GPU2) : Yes
 > Peer access from Tesla V100-PCIE-32GB (GPU5) -> Tesla V100-PCIE-32GB (GPU3) : Yes
 > Peer access from Tesla V100-PCIE-32GB (GPU5) -> Tesla V100-PCIE-32GB (GPU4) : Yes

 deviceQuery, CUDA Driver = CUDART, CUDA Driver Version = 12.4, CUDA Runtime Version = 12.4, NumDevs = 6, Device0 = Tesla V100-PCIE-32GB, Device1 = Tesla V100-PCIE-32GB, Device2 = Tesla V100-PCIE-32GB, Device3 = Tesla V100-PCIE-32GB, Device4 = Tesla V100-PCIE-32GB, Device5 = Tesla V100-PCIE-32GB Result = PASS

