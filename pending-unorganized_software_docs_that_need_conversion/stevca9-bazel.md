# Bazel

https://docs.bazel.build/versions/master/install-compile-source.html

## Introduction

Bazel is an open-source build and test tool similar to Make, Maven, and Gradle.
It uses a human-readable, high-level build language. Bazel supports projects in
multiple languages and builds outputs for multiple platforms. Bazel supports
large codebases across multiple repositories, and large numbers of users.

## Installed Versions

 - 0.24.1
 - 0.27.1

### Prerequisites

bash, zip, unzip, gcc, gcc-c++, java-1.8.0-openjdk, python 3.7.0

```
module load rhel7/gpu/python/3.7.0
```

### Installation

Bazel needs to be bootstraped using the built in compile.sh command. The
compiled output is placed into output/bazel. This is a self-contained Bazel
binary, without an embedded JDK. You can copy it anywhere or use it in-place.

Download src zip file to `/deac/opt/src/rhel7`

```
mkdir -p /deac/opt/src/rhel7/bazel-0.27.1
cd /deac/opt/src/rhel7/bazel-0.27.1

wget https://github.com/bazelbuild/bazel/releases/download/0.27.1/bazel-0.27.1-dist.zip

unzip bazel-0.27.1-dist.zip
```

Run `./compile.sh` to build bazel binary file

```
env EXTRA_BAZEL_ARGS="--host_javabase=@local_jdk//:jdk" bash ./compile.sh
```

Copy bazel binary output to `/deac/opt/rhel7/gpu`

```
mkdir -p /deac/opt/rhel7/gpu/bazel/0.27.1/bin
cp output/bazel /deac/opt/rhel7/gpu/bazel/0.27.1/bin
```
