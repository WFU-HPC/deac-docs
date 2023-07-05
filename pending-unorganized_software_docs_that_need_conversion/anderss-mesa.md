## Preamble

Ugh, meson.

```sh
yum install meson 
```

Load your modules:

```sh
module load python/3.8.13 compilers/gcc/10.2.0 utils/cmake/3.23.1 
```


# Building

Set everything up:

```sh
cd $TMPDIR/mesa-*
mkdir build && cd build
```

Ugh, meson.

```sh
meson .. --prefix /deac/opt/rhel7/mesa/20.3.5-gcc_10.2.0 \
         -Dgallium-drivers=swrast \
         -Dgallium-omx=disabled \
         -Dgallium-opencl=disabled \
         -Dgallium-va=disabled \
         -Dgallium-vdpau=disabled \
         -Dgallium-xa=disabled \
         -Dgallium-xvmc=disabled \
         -Dosmesa=gallium \
         -Dglx=gallium-xlib \
         -Degl=disabled \
         -Dgbm=disabled \
         -Dgles1=disabled \
         -Dgles2=disabled \
         -Dshared-glapi=enabled \
         -Dllvm=disabled \
         -Dshared-llvm=disabled \
         -Dplatforms=x11 \
         -Ddri3=disabled \
         -Ddri-drivers= \
         -Dvulkan-drivers= \
         -Dbuildtype=release
```

Finally, just install:

```sh
ninja install
```
