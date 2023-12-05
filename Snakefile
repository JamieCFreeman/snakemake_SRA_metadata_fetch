
import pandas as pd
# from snakemake.utils import validate
from snakemake.utils import min_version

min_version("5.4.0")

#### Config:
configfile: "config.yaml"

PROJ_ACC = pd.read_csv(config["accession"], sep='\t', header=None, names=['PROJ_ACC'])

wildcard_constraints:
	project="|".join(PROJ_ACC['PROJ_ACC'])

rule all:
	input:
		"metadata/merge.txt"

rule get_sra_table:
	output:
		temp("metadata/{project}_sra_run_info.txt")
	conda:
		"./envs/NCBI_edirect.yml"
	shell:
		"""
		SRA=` echo {output} | sed 's ^.*/  ' | sed 's/_sra.*//' `;
			esearch -db sra -query ${{SRA}} | efetch -format runinfo > {output}
		"""

rule merge_raw:
	input:
		expand("metadata/{project}_sra_run_info.txt", project=PROJ_ACC['PROJ_ACC'])
	output:
		temp("metadata/all_run_info.txt")
	shell:
		"""
		cat {input} > {output}
		"""

rule format_sra_table:
	input:
		"metadata/all_run_info.txt"
	output:
		"metadata/merge.txt"
	shell:
		"""
		awk -F, '{{OFS=","}} {{print $1, $7, $11, $12, $13, $16, $19, $20, $29}}' {input} | sed 's/ /_/g' | 
			awk -F, 'BEGIN {{OFS="\t"}} {{$1=$1}}1' > {output}
		head -n 1 {output} > {output}.tmp
                grep --color=none "\S" {output} | sed '/Run\tavgLength/d' >> {output}.tmp
                rm {output}; mv {output}.tmp {output}
		"""
