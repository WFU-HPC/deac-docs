# Rosetta

```
# compile time
45m03.182s  gcc
45m42.395s  gcc,broadwell
78m19.757s  gcc,broadwell,mpi
51m58.665s  gcc,broadwell,cxxthreads
35m36.408s  gcc,broadwell,static
45m50.846s  gcc,broadwell,omp
76m57.787s  intel
92m38.737s  intel,broadwell,static

# performance
# time(s)   stdev(s)
  6.630     0.036   # GCC, broadwell, static
  6.644     0.018   # Intel, broadwell, static
  7.778     0.077   # GCC, broadwell
  7.826     0.090   # GCC, noarch
  8.109     0.084   # Intel, noarch
  8.175     0.038   # GCC, broadwell, cxxthreads, 1
  9.066     0.143   # Pre-built binaries (Ilse)
```

```sh
export ROSETTA3=$TMPDIR/rosetta_src_2021.07.61567_bundle/main
mkdir -p $TMPDIR/rosetta_temp && cd $TMPDIR/rosetta_temp

time $ROSETTA3/source/bin/InterfaceAnalyzer.static.linuxgccrelease -s $RESEARCHPATH/examples/rosetta/relax_output_10_nstruct/6vw1_AE_relaxed_0006.pdb -score:hbond_bb_per_residue_energy -interface A_E && rm -f 6vw1_AE_relaxed_0006_0001.pdb ROSETTA_CRASH.log score.sc
for i in {1..20}; do time $ROSETTA3/source/bin/InterfaceAnalyzer.static.linuxgccrelease -s $RESEARCHPATH/examples/rosetta/relax_output_10_nstruct/6vw1_AE_relaxed_0006.pdb -score:hbond_bb_per_residue_energy -interface A_E >/dev/null && rm -f 6vw1_AE_relaxed_0006_0001.pdb ROSETTA_CRASH.log score.sc; done 2> ~/times
time $ROSETTA3/source/bin/relax.static.linuxgccrelease -s $RESEARCHPATH/502D_files/502D_fix_AE.pdb -out:suffix _relaxed -nstruct 4 -relax:default_repeats 5 -out:path:pdb $TMPDIR/rosetta_temp -out:path:score $TMPDIR/rosetta_temp
```
