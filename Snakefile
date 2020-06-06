PROJ_ACC = ['SRR521286', 'SRR521288']

rule all:
	input:
		expand("metadata/{project}_sra_run_metadata.txt", project=PROJ_ACC),
		"metadata/merge.txt"

rule get_sra_table:
	output:
		"metadata/{project}_sra_run_info.txt"
	shell:
		"""
		SRA=` echo {output} | sed 's ^.*/  ' | sed 's/_sra.*//' `;
			esearch -db sra -q ${{SRA}} | efetch -format runinfo > {output}
		"""

rule format_sra_table:
	input:
		"metadata/{project}_sra_run_info.txt"
	output:
		"metadata/{project}_sra_run_metadata.txt"
	shell:
		"""
		awk -F, '{{OFS=","}} {{print $1, $7, $11, $12, $13, $16, $19, $20, $29}}' {input} | sed 's/ /_/g' | 
			awk -F, 'BEGIN {{OFS="\t"}} {{$1=$1}}1' > {output}
		"""

rule combine_sra_table:
	input:
		expand("metadata/{project}_sra_run_metadata.txt", project=PROJ_ACC) 
	output:
		"metadata/merge.txt"
	shell:
		"""
		cat {input} > {output}
		head -n 1 {output} > {output}.tmp
		grep --color=none "\S" {output} | sed '/Run\tavgLength/d' >> {output}.tmp
		rm {output}; mv {output}.tmp {output}
		"""
