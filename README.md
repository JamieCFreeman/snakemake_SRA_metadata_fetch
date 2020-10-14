# snakemake_SRA_metadata_fetch


Takes an NCBI SRA accession in the config file, outputs the metadata table pulled from SRA, reformats 
into the just the fields I want and combines all accessions into one table.

Written with snakemake version 5.4.0, so set to require at least that. 

Input should be a file containing SRA accessions. Set path to input in config.yaml.

Uses conda for package management, so should be run with command:
snakemake --use-conda
For dry run:
snakemake -n --use-cona

