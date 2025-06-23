#!/usr/bin/env bash
# run_af_disorder.sh – run alphafold_disorder.py on every .pdb in the current folder

JOBS=${JOBS:-10}  # number of parallel jobs, my default is 10

# First clone the AlphaFold-disorder repo if script not found:
# https://github.com/BioComputingUP/AlphaFold-disorder
if [ ! -f "alphafold_disorder.py" ]; then
  echo "alphafold_disorder.py not found. Cloning from GitHub..."
  git clone https://github.com/BioComputingUP/AlphaFold-disorder.git temp_af_disorder_repo
  cp temp_af_disorder_repo/alphafold_disorder.py . # taje it out and remove the temp 
  rm -rf temp_af_disorder_repo
fi

chmod u+x alphafold_disorder.py

# run the script in parallel over all .pdb files in the current directory
find . -maxdepth 1 -name '*.pdb' -print0 | \
xargs -0 -n1 -P "$JOBS" -I{} sh -c '
  in="{}"
  base=$(basename "$in" .pdb)
  out="${base}.tsv"
  [ -s "$out" ] && exit 0  # skip if already processed
  python3 alphafold_disorder.py -i "$in" -o "$out"
'
