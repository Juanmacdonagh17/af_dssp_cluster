#!/usr/bin/env bash
# pull_and_run_af_disorder.sh – download AF models and run alphafold_disorder.py
# Requires: uniprot_ids.txt (one UniProt ID per line)
# Uses 10 parallel jobs by default

JOBS=${JOBS:-10}
ID_FILE="uniprot_ids.txt" ##### this si where the list goes!!!! #####

if [ ! -f "alphafold_disorder.py" ]; then
  echo "alphafold_disorder.py not found. Cloning from GitHub..."
  git clone https://github.com/BioComputingUP/AlphaFold-disorder.git temp_af_disorder_repo
  cp temp_af_disorder_repo/alphafold_disorder.py .
  rm -rf temp_af_disorder_repo
fi
chmod u+x alphafold_disorder.py

# add this step so i can provide a list and just run the script 

cat "$ID_FILE" | xargs -n1 -P "$JOBS" -I{} sh -c '
  id="{}"
  file="AF-${id}-F1-model_v6.pdb"
  [ -s "$file" ] && exit 0
  curl -fsS --retry 3 -o "$file" \
    "https://alphafold.ebi.ac.uk/files/${file}" || rm -f "$file"
'

find . -maxdepth 1 -name 'AF-*-F1-model_v6.pdb' -print0 | \
xargs -0 -n1 -P "$JOBS" -I{} sh -c '
  in="{}"
  base=$(basename "$in" .pdb)
  out="${base}.tsv"
  [ -s "$out" ] && exit 0
  python3 alphafold_disorder.py -i "$in" -o "$out"
'

echo "All done ✅"
