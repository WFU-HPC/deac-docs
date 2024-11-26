# DEACFold, MaSIF, AlphaFold, and BindCraft Environments

## DEACFold

The DEACFold environment includes:

* Python 3.10
* CUDA 12.1
* PyTorch 2.3.0

which are all quite recent and should be compatible with most modern packages
and workflows. Using these recent versions will also make it easier to add new
packages or to upgrade when needed.


### RoseTTAFold-All-Atom

* Info: https://github.com/baker-laboratory/RoseTTAFold-All-Atom
* Module file: `module load envs/biophysics/deacfold`

Loading the module file listed above will enable the Python environment to run
RoseTTAFoldAA. The repo has been adapted to the paths and software on the DEAC
Cluster. Since you are intended to work directly out of the repo itself, there
is a local clone at `$ROSETTAFOLDAA_ROOT` that you can copy to your research
path:

```sh
module load envs/biophysics/deacfold
cp -r $ROSETTAFOLDAA_ROOT /deac/chm/albaneseGrp/software/RoseTTAFold-All-Atom
module purge
```

or any other location you wish to use. **You should only do this once!**

Now that you have your own local copy, here is a basic Slurm script to run the
example cases:

```sh
#!/bin/bash
#SBATCH --job-name=RoseTTAFold-All-Atom
#SBATCH --account=albaneseGrp
#SBATCH --partition=gpu
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:A100_80:1
#SBATCH --mem=16GB
#SBATCH --time=0-01:00:00

## load the software environment
module load envs/biophysics/deacfold

## change into your local repo
cd /deac/chm/albaneseGrp/software/RoseTTAFold-All-Atom

## run the examples
python3 -m rf2aa.run_inference --config-name base           # doesn't work, but I suspect not our fault
python3 -m rf2aa.run_inference --config-name protein
python3 -m rf2aa.run_inference --config-name nucleic_acid
```


### LigandMPNN

* Info: https://github.com/dauparas/LigandMPNN
* Module file: `module load envs/biophysics/deacfold`

Just as before, loading the module file listed above will enable the Python
environment to run LigandMPNN. This repo has also been adapted to the paths and
software on the DEAC Cluster with a local clone at `$LIGANDMPNN_ROOT` so make a
copy in your research path:

```sh
module load envs/biophysics/deacfold
cp -r $LIGANDMPNN_ROOT /deac/chm/albaneseGrp/software/LigandMPNN
module purge
```

or any other location you wish to use. **You should only do this once!**

Now that you have your own local copy, here is a basic Slurm script to run the
example cases:

```sh
#!/bin/bash
#SBATCH --job-name=LigandMPNN
#SBATCH --account=albaneseGrp
#SBATCH --partition=gpu
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:A100_80:1
#SBATCH --mem=16GB
#SBATCH --time=0-01:00:00

## load the software environment
module load envs/biophysics/deacfold

## change into your local repo
cd /deac/chm/albaneseGrp/software/LigandMPNN

## run the examples
python3 run.py --seed 111 --pdb_path "./inputs/1BC8.pdb" --out_folder "./outputs/default"
python3 run.py --seed 111 --pdb_path "./inputs/1BC8.pdb" --out_folder "./outputs/temperature"       --temperature 0.05
python3 run.py            --pdb_path "./inputs/1BC8.pdb" --out_folder "./outputs/random_seed"
python3 run.py --seed 111 --pdb_path "./inputs/1BC8.pdb" --out_folder "./outputs/verbose"           --verbose 0
python3 run.py --seed 111 --pdb_path "./inputs/1BC8.pdb" --out_folder "./outputs/save_stats"        --save_stats 1
python3 run.py --seed 111 --pdb_path "./inputs/1BC8.pdb" --out_folder "./outputs/fix_residues"      --fixed_residues "C1 C2 C3 C4 C5 C6 C7 C8 C9 C10" --bias_AA "A:10.0"
python3 run.py --seed 111 --pdb_path "./inputs/1BC8.pdb" --out_folder "./outputs/redesign_residues" --redesigned_residues "C1 C2 C3 C4 C5 C6 C7 C8 C9 C10" --bias_AA "A:10.0"
python3 run.py --seed 111 --pdb_path "./inputs/1BC8.pdb" --out_folder "./outputs/batch_size"        --batch_size 3 --number_of_batches 5
python3 run.py --seed 111 --pdb_path "./inputs/1BC8.pdb" --out_folder "./outputs/global_bias"       --bias_AA "W:3.0,P:3.0,C:3.0,A:-3.0"
python3 run.py --seed 111 --pdb_path "./inputs/1BC8.pdb" --out_folder "./outputs/per_residue_bias"  --bias_AA_per_residue "./inputs/bias_AA_per_residue.json"
python3 run.py --seed 111 --pdb_path "./inputs/1BC8.pdb" --out_folder "./outputs/global_omit"       --omit_AA "CDFGHILMNPQRSTVWY"
python3 run.py --seed 111 --pdb_path "./inputs/1BC8.pdb" --out_folder "./outputs/per_residue_omit"  --omit_AA_per_residue "./inputs/omit_AA_per_residue.json"
python3 run.py --seed 111 --pdb_path "./inputs/1BC8.pdb" --out_folder "./outputs/symmetry"          --symmetry_residues "C1,C2,C3|C4,C5|C6,C7" --symmetry_weights "0.33,0.33,0.33|0.5,0.5|0.5,0.5"
```


### RFdiffusion

* Info: https://github.com/RosettaCommons/RFdiffusion/
* Module file: `module load envs/biophysics/deacfold`

Just as before, loading the module file listed above will enable the Python
environment to run RFdiffusion. This repo has also been adapted to the paths and
software on the DEAC Cluster with a local clone at `$RFDIFFUSION_ROOT` so make a
copy in your research path:

```sh
module load envs/biophysics/deacfold
cp -r $RFDIFFUSION_ROOT /deac/chm/albaneseGrp/software/RFdiffusion
module purge
```

or any other location you wish to use. **You should only do this once!**

Now that you have your own local copy, here is a basic Slurm script to run the
example cases:

```sh
#!/bin/bash
#SBATCH --job-name=RFdiffusion
#SBATCH --account=albaneseGrp
#SBATCH --partition=gpu
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:A100_80:1
#SBATCH --mem=16GB
#SBATCH --time=0-01:00:00

## load the software environment
module load envs/biophysics/deacfold

## change into your local repo
cd /deac/chm/albaneseGrp/software/RFdiffusion

## run the examples
python3 ./scripts/run_inference.py \
        'contigmap.contigs=[150-150]' \
        inference.output_prefix="test_outputs/test" \
        inference.num_designs=10
```


### RFDiffusion AA

* Info: https://github.com/baker-laboratory/rf_diffusion_all_atom
* Module file: `module load envs/biophysics/deacfold`

Just as before, loading the module file listed above will enable the Python
environment to run RFdiffusion. This repo has also been adapted to the paths and
software on the DEAC Cluster with a local clone at `$RFDIFFUSIONAA_ROOT` so make a
copy in your research path:

```sh
module load envs/biophysics/deacfold
cp -r $RFDIFFUSIONAA_ROOT /deac/chm/albaneseGrp/software/rf_diffusion_all_atom
module purge
```

or any other location you wish to use. **You should only do this once!**

Now that you have your own local copy, here is a basic Slurm script to run the
example cases:

```sh
#!/bin/bash
#SBATCH --job-name=RFdiffusionAA
#SBATCH --account=albaneseGrp
#SBATCH --partition=gpu
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:A100_80:1
#SBATCH --mem=16GB
#SBATCH --time=0-01:00:00

## load the software environment
module load envs/biophysics/deacfold

## change into your local repo
cd /deac/chm/albaneseGrp/software/rf_diffusion_all_atom

## run the examples
python3 run_inference.py \
        inference.deterministic=True \
        diffuser.T=100 \
        inference.output_prefix=output/ligand_only/sample \
        inference.input_pdb=input/7v11.pdb \
        contigmap.contigs=[\'150-150\'] \
        inference.ligand=OQO \
        inference.num_designs=1 \
        inference.design_startnum=0

python3 run_inference.py \
        inference.deterministic=True \
        diffuser.T=200 \
        inference.output_prefix=output/ligand_protein_motif/sample \
        inference.input_pdb=input/1haz.pdb \
        contigmap.contigs=[\'10-120,A84-87,10-120\'] \
        contigmap.length="150-150" \
        inference.ligand=CYC \
        inference.num_designs=1 \
        inference.design_startnum=0
```


### ESM3

* Info: https://github.com/evolutionaryscale/esm
* Module file: `module load envs/biophysics/deacfold`

Just as before, loading the module file listed above will enable the Python
environment to run ESM3. Fortunately, this is a Python module that does not need
the repo work, but there is a local clone located at `$ESM_ROOT` that can be
used for reference.

In order to download the pre-trained models from Hugging Face you will need to
make an account and [generate an access
token](https://huggingface.co/settings/tokens/new?tokenType=read). Once you have
the access token, run the following to enable the automatic download feature
when running your jobs on the cluster:

```sh
python3 -c "from huggingface_hub import login; login()"
```

Once you have registered your token, here is a basic Slurm script to run the example cases:

```sh
#!/bin/bash
#SBATCH --job-name=ESM3
#SBATCH --account=albaneseGrp
#SBATCH --partition=gpu
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:A100_80:1
#SBATCH --mem=16GB
#SBATCH --time=0-01:00:00

## load the software environment
module load envs/biophysics/deacfold

## create and change into work directory
WORKDIR=/deac/chm/albaneseGrp/ESM3 
mkdir -p $WORKDIR && cd $WORKDIR

## run the examples
cat << EOF | python3
from esm.models.esm3 import ESM3
from esm.sdk.api import ESM3InferenceClient, ESMProtein, GenerationConfig

# This will download the model weights and instantiate the model on your machine.
model: ESM3InferenceClient = ESM3.from_pretrained("esm3_sm_open_v1").to("cuda") # or "cpu"

# Generate a completion for a partial Carbonic Anhydrase (2vvb)
prompt = "___________________________________________________DQATSLRILNNGHAFNVEFDDSQDKAVLKGGPLDGTYRLIQFHFHWGSLDGQGSEHTVDKKKYAAELHLVHWNTKYGDFGKAVQQPDGLAVLGIFLKVGSAKPGLQKVVDVLDSIKTKGKSADFTNFDPRGLLPESLDYWTYPGSLTTPP___________________________________________________________"
protein = ESMProtein(sequence=prompt)
# Generate the sequence, then the structure. This will iteratively unmask the sequence track.
protein = model.generate(protein, GenerationConfig(track="sequence", num_steps=8, temperature=0.7))
# We can show the predicted structure for the generated sequence.
protein = model.generate(protein, GenerationConfig(track="structure", num_steps=8))
protein.to_pdb("./generation.pdb")
# Then we can do a round trip design by inverse folding the sequence and recomputing the structure
protein.sequence = None
protein = model.generate(protein, GenerationConfig(track="sequence", num_steps=8))
protein.coordinates = None
protein = model.generate(protein, GenerationConfig(track="structure", num_steps=8))
protein.to_pdb("./round_tripped.pdb")
EOF
```


### OpenMM

* Info: https://openmm.org
* Module file: `module load envs/biophysics/deacfold`

Just as before, loading the module file listed above will enable the Python
environment to run OpenMM. There are a few examples at `${OPENMM_ROOT}/examples`
that can be used for reference. You can copy these to your local account:

```sh
module load envs/biophysics/deacfold
cp -r ${OPENMM_ROOT}/examples /deac/chm/albaneseGrp/OpenMM_examples
module purge
```

Now that you have the examples, here is a basic Slurm script to run them:

```sh
#!/bin/bash
#SBATCH --job-name=OpenMM
#SBATCH --account=albaneseGrp
#SBATCH --partition=gpu
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:A100_80:1
#SBATCH --mem=16GB
#SBATCH --time=0-01:00:00

## load the software environment
module load envs/biophysics/deacfold

## change into work directory
cd /deac/chm/albaneseGrp/OpenMM_examples

## run the example
python3 simulatePdb.py
```


## MaSIF, MaSIF-neosurf, and MaSIF-seed

* Info: https://github.com/LPDI-EPFL/masif, https://github.com/LPDI-EPFL/masif_seed, https://github.com/LPDI-EPFL/masif-neosurf
* Module file: `module load envs/biophysics/masif`

The MaSIF environment includes:

* Python 3.7
* CUDA 12.1
* TensorFlow 1.14

These packages are built around the TensorFlow 1.* framework, and this limits us
to much older versions of Python and associated packages. I tried porting these
packages to TensorFlow 2 which would overcome many of these limitations -- I got
close, but some parts of the code had to be heavily modified and behaved
unexpectedly. For the time being, it is probably safer sticking with TensorFlow
1.14. Additionally, most of the examples shown in the documentation do not seem
to work. I think that the errors have to do with missing files, wrong paths,
etc. and not with the Python or external dependencies. The MaSIF-neosurf
examples do seem to work fine, which is why I include them in the Slurm script
below.

It seems like calculations should be run directly in the repo directories
themselves and there are local clones at `$MASIF_ROOT`, `$MASIFSEED_ROOT`, and
`$MASIFNEOSURF_ROOT` that you can copy to your research path:

```sh
module load envs/biophysics/masif
cp -r $MASIF_ROOT        /deac/chm/albaneseGrp/software/masif
cp -r $MASIFSEED_ROOT    /deac/chm/albaneseGrp/software/masif_seed
cp -r $MASIFNEOSURF_ROOT /deac/chm/albaneseGrp/software/masif-neosurf
module purge
```

or any other location you wish to use. **You should only do this once!** These
clones have been tweaked a little bit to work with the installed software.

Now that you have your own local copies, here is a basic Slurm script to run the
example cases:

```sh
#!/bin/bash
#SBATCH --job-name=OpenMM
#SBATCH --account=albaneseGrp
#SBATCH --partition=gpu
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:A100_80:1
#SBATCH --mem=16GB
#SBATCH --time=0-01:00:00

## load the software environment
module load envs/biophysics/masif

## change into work directory
cd /deac/chm/albaneseGrp/software/masif-neosurf

## run the examples
# with ligand
./preprocess_pdb.sh example/1a7x.pdb 1A7X_A -l FKA_B -s example/1a7x_C_FKA.sdf -o example/output/

# without ligand
./preprocess_pdb.sh example/1a7x.pdb 1A7X_A -o example/output/
```


## AlphaFold2

The previous installation of AlphaFold2 is still functional and has produced
good results in the past. It will be worth it to install AlphaFold3 when it is
released in some form, and I will update the documentation accordingly.

Below is the Slurm script:

```sh
#!/bin/bash
#SBATCH --job-name=AlphaFold
#SBATCH --account=albaneseGrp
#SBATCH --partition=gpu
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=8
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:A100_80:1
#SBATCH --mem=32GB
#SBATCH --time=0-01:00:00

# load anaconda and relevant cuda
module load apps/anaconda3/2024.02 nvidia/cuda12/cuda

# activate the environment
conda activate alphafold

# convenient environment variables
export ALPHAFOLD_DATA="/deac/data/alphafold_data"
export SCRATCH="/scratch/$SLURM_JOB_ID"
export INPUT="${SCRATCH}/query.fasta"
export OUTPUT="${SCRATCH}/output_dir"
export DATE="2020-05-14"

# make your output directory
mkdir -p $OUTPUT

# create example fasta file
cat <<EOF > "$INPUT"
>dummy_sequence
GWSTELEKHREELKEFLKKEGITNVEIRIDNGRLEVRVEGGTERLKRFLEELRQKLEKKGYTVDIKIE
EOF

# running alphafold
python3 /deac/opt/rhel7-noarch/alphafold/alphafold-2.3.2/run_alphafold.py \
    --hhblits_binary_path="${CONDA_PREFIX}/bin/hhblits" \
    --hhsearch_binary_path="${CONDA_PREFIX}/bin/hhsearch" \
    --jackhmmer_binary_path="${CONDA_PREFIX}/bin/jackhmmer" \
    --kalign_binary_path="${CONDA_PREFIX}/bin/kalign" \
    --uniref90_database_path="${ALPHAFOLD_DATA}/uniref90/uniref90.fasta" \
    --mgnify_database_path="${ALPHAFOLD_DATA}/mgnify/mgy_clusters_2022_05.fa" \
    --data_dir="${ALPHAFOLD_DATA}" \
    --template_mmcif_dir="${ALPHAFOLD_DATA}/pdb_mmcif/mmcif_files" \
    --obsolete_pdbs_path="${ALPHAFOLD_DATA}/pdb_mmcif/obsolete.dat" \
    --pdb70_database_path="${ALPHAFOLD_DATA}/pdb70/pdb70" \
    --uniref30_database_path="${ALPHAFOLD_DATA}/uniref30/UniRef30_2021_03" \
    --bfd_database_path="${ALPHAFOLD_DATA}/bfd/bfd_metaclust_clu_complete_id30_c90_final_seq.sorted_opt" \
    --fasta_paths="$INPUT" \
    --output_dir="$OUTPUT" \
    --max_template_date="$DATE" \
    --db_preset=full_dbs \
    --model_preset=monomer \
    --benchmark=false \
    --use_precomputed_msas=false \
    --num_multimer_predictions_per_model=5 \
    --use_gpu_relax=true \
    --logtostderr

# copy results back to somewhere useful
mv "$OUTPUT" "${SLURM_SUBMIT_DIR}/${SLURM_JOB_ID}"
```


## BindCraft

The BindCraft environment includes:

* Python 3.11
* CUDA 12.6
* Jax 0.4.27
* Jaxlib 0.4.23-cuda

This was created separately from the main `DEACFold` environment because of concflicts arising from using Jax and CUDA. 

It seems like calculations should be run directly in the repo directories
themselves and there is a local clone at `$BINDCRAFT_ROOT` that you can copy to
your research path:

```sh
module load envs/biophysics/bindcraft
cp -r $BINDCRAFT_ROOT /deac/chm/albaneseGrp/software/BindCraft
module purge
```

or any other location you wish to use. **You should only do this once!** This
clone has been tweaked a little bit to work with the installed software.

Now that you have your own local copy, here is a basic Slurm script to run the
example case:

```sh
#!/bin/bash
#SBATCH --job-name=BindCraft
##SBATCH --account=albaneseGrp
#SBATCH --partition=gpu
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:A100_80:1
#SBATCH --mem=16GB
#SBATCH --time=0-01:00:00

## load the software environment
module load envs/biophysics/bindcraft

## change into work directory
cd /deac/chm/albaneseGrp/software/BindCraft

## run the example
python3 -u ./bindcraft.py \
            --settings './settings_target/PDL1.json' \
            --filters './settings_filters/default_filters.json' \
            --advanced './settings_advanced/4stage_multimer.json'
```

## AlphaFold 3

Please read the [terms of
use](https://github.com/google-deepmind/alphafold3/blob/main/WEIGHTS_TERMS_OF_USE.md)
of the AlphaFold 3 model parameters before using. I have obtained this model for
general use on the DEAC Cluster, but we could all get in trouble if anyone
violates these terms.

This environment is not designed in the same way as the other ones featured
above. It is safest to purge any previously loaded modules or deactivate any
other environments before working with the AlphaFold 3 environment.

Below is the Slurm script:

```sh
#!/bin/bash
#SBATCH --job-name=AlphaFold3
#SBATCH --account=albaneseGrp
#SBATCH --partition=gpu
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:A100_80:1
#SBATCH --mem=8GB
#SBATCH --time=00-01:00:00

# load the alphafold3 environment
module load envs/biophysics/alphafold3

# convenient environment variables
export SCRATCH="/scratch/$SLURM_JOB_ID"
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK

# make your input and output directories
mkdir -p ${SCRATCH}/af_input
mkdir -p ${SCRATCH}/af_output

# create your input file
cat << EOF > ${SCRATCH}/af_input/alphafold_input.json
{
  "name": "2PV7",
  "sequences": [
    {
      "protein": {
        "id": ["A", "B"],
        "sequence": "GMRESYANENQFGFKTINSDIHKIVIVGGYGKLGGLFARYLRASGYPISILDREDWAVAESILANADVVIVSVPINLTLETIERLKPYLTENMLLADLTSVKREPLAKMLEVHTGAVLGLHPMFGADIASMAKQVVVRCDGRFPERYEWLLEQIQIWGAKIYQTNATEHDHNMTYIQALRHFSTFANGLHLSKQPINLANLLALSSPIYRLELAMIGRLFAQDAELYADIIMDKSENLAVIETLKQTYDEALTFFENNDRQGFIDAFHKVRDWFGDYSEQFLKESRQLLQQANDLKQG"
      }
    }
  ],
  "modelSeeds": [1],
  "dialect": "alphafold3",
  "version": 1
}
EOF

# running alphafold
python3 ${ALPHAFOLD3_ROOT}/run_alphafold.py \
    --model_dir="/deac/data/alphafold3_models" \
    --db_dir="/deac/data/alphafold3_data" \
    --json_path="${SCRATCH}/af_input/alphafold_input.json" \
    --output_dir="${SCRATCH}/af_output"

# copy results back to somewhere useful
mv ${SCRATCH}/af_output/2pv7 /your/research/path/directory
```
