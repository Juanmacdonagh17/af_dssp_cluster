# AlphaFold Disorder Batch Runner

This repository contains a  very simple Bash script that automates a repetitive workflow I often need in my PhD.

The script:
- Takes a list of UniProt IDs (`uniprot_ids.txt`)
- Downloads the corresponding AlphaFold structure models (PDB format)
- Runs [`alphafold_disorder.py`](https://github.com/BioComputingUP/AlphaFold-disorder) on each structure
- Outputs a `.tsv` file for each input `.pdb` model

> This is not a general-purpose or optimized tool. It’s a personal utility designed to make my life easier by batch-processing AlphaFold models for disorder predictions.


##  MWE

1. Clone this repo:
   ```bash
   git clone https://github.com/Juanmacdonagh17/af_dssp_cluster.git
   cd af_dssp_cluster
   ```
2. Create a file called uniprot_ids.txt with ids (e.g is provided)


3. Run the script:
4. 
```bash
chmod u+x run_and_request_prl.sh
./run_and_request_prl.sh
   ```
For each .pdb downloaded, a corresponding *_pred.tsv with disorder predictions will be created in the same folder. It uses, by default, 10 jobs, you can change this inside the script. 
This script uses [`alphafold_disorder.py`](https://github.com/BioComputingUP/AlphaFold-disorder), developed by the BioComputingUP group. All credits goes to them. 
Be awaret that it will also clone te repo inside the folder to excecute the script.
There's also another script that only runs the jobs, with out the request.



