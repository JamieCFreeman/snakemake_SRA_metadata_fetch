# snakemake_SRA_metadata_fetch


Takes an NCBI SRA accession in the config file, outputs the metadata table pulled from SRA, reformats 
into the just the fields I want and combines all accessions into one table.

Written with snakemake version 5.4.0, so set to require at least that. 

Input should be a file containing SRA accessions (see Md_Annot_RNAseq_SRA.txt for example). Set path to input in config.yaml.

Uses conda for package management, so should be run with command:
snakemake --use-conda
For dry run:
snakemake --dry-run --use-conda

Example output file provided in metadata folder:

| Run	| avgLength	| Experiment |	LibraryName	| LibraryStrategy	| LibraryLayout	| Platform	| Model	| ScientificName |
| ------------- | ------------- | ------------- | ------------- | ------------- | ------------- | ------------- | ------------- | ------------- |
SRR521286 | 100	SRX159760	GSM961033:_aabys_mRNA	RNA-Seq	PAIRED	ILLUMINA	Illumina_HiSeq_2000	Musca_domestica
SRR521288	| 100	SRX159762	GSM961035:_ALHF2_mRNA	RNA-Seq	PAIRED	ILLUMINA	Illumina_HiSeq_2000	Musca_domestica
SRR521289	| 100	SRX159763	GSM961036:_ALHF3_mRNA	RNA-Seq	PAIRED	ILLUMINA	Illumina_HiSeq_2000	Musca_domestica
SRR521290	| 100	SRX159764	GSM961037:_CS_mRNA	RNA-Seq	PAIRED	ILLUMINA	Illumina_HiSeq_2000	Musca_domestica
SRR629516	| 200	SRX208995	2882693088	RNA-Seq	PAIRED	ILLUMINA	Illumina_HiSeq_2000	Musca_domestica
SRR629507	| 200	SRX208996	2875926454	RNA-Seq	PAIRED	ILLUMINA	Illumina_Genome_Analyzer_II	Musca_domestica
SRR629504	| 200	SRX208993	2875926334	RNA-Seq	PAIRED	ILLUMINA	Illumina_Genome_Analyzer_II	Musca_domestica
SRR629513 |	200	SRX208997	2875926470	RNA-Seq	PAIRED	ILLUMINA	Illumina_Genome_Analyzer_II	Musca_domestica
SRR629506	200	SRX208994	2875926335	RNA-Seq	PAIRED	ILLUMINA	Illumina_Genome_Analyzer_II	Musca_domestica


