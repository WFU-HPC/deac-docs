## About

BWA is a software package for mapping low-divergent sequences against a
large reference genome, such as the human genome. It consists of three
algorithms: BWA-backtrack, BWA-SW and BWA-MEM. The first algorithm is
designed for Illumina sequence reads up to 100bp, while the rest two for
longer sequences ranged from 70bp to 1Mbp. BWA-MEM and BWA-SW share
similar features such as long-read support and split alignment, but
BWA-MEM, which is the latest, is generally recommended for high-quality
queries as it is faster and more accurate. BWA-MEM also has better
performance than BWA-backtrack for 70-100bp Illumina reads. BWA also has
an parallel version called pBWA

## Version

  - BWA Version = 0.7.1 with gcc 4.8.5
  - pBWA version = 0.5.9-1.21009 with openmpi/4.0.2-gcc-4.8

## Compiling

### BWA

Find the source file at
<https://sourceforge.net/projects/bio-bwa/files/>

In the BWAROOTDIR

To compile with Intel:

` module load module load compilers/intel-$version`
` vim Makefile     //Edit the Makefile, change compiler to icc`

In Makefile:

` CC  =   icc`

Now, compile:

` make  //Executable file ‘bwa’ is created in current directory`

Otherwise to compile with gcc:

` make  //Executable file ‘bwa’ is created in current directory`

### pBWA

Find the source file at <https://sourceforge.net/projects/pbwa/files/>

In the PBWAROOTDIR

` module load openmpi/4.0.2-gcc-4.8`

` make       //Executable file ‘pBWA’’ is created in current directory`
