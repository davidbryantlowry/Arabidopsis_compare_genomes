Arabidopsis_compare_genomes
===========================
Arabidopsis SHORE/FASTA formatted genome extraction scripts.
Author: David Bryant Lowry
Date: 12/26/12

This directory contains scripts to extract gene CDS and UTR regions and compare them pairwise 
between the two genomes. Genomes should be in SHORE/FASTA format that aligned to the Col-0 
reference genome. The scripts count SNPs and calculate nucleotide divergence for CDS and UTR 
regions. The CDS pipeline also counts amino acid substitutions and premature stop codons. The 
scripts are currently written only to compare genes from the nuclear genome.

Make sure that all of the programs are in the directory and have the EXACT names as below:

Files:

CDSpipeline.pl						Pipeline for CDS

UTRpipeline.pl						Pipeline for UTR

CDS_grabber.pl						Extracts CDS from genome

UTR_grabber.pl						Extracts 5’ and 3’ UTR from genome

CDS_combiner.pl						Concatenates CDS and reverse transcribes

CDStoProtein.pl						Converts CDS to in frame protein

Amino_acid_divergence.pl			Calculates AA substitutions between genomes and counts premature stop codons 
Nucleotide_divergence.pl			Counts SNPs between genomes

TAIR10_GFF3_genes_mod.gff.cr 		Modified annotation file, DO NOT USE ANOTHER

Also make sure that the two genomes you want to compare are in the directory.
Genome file names should be in the format name_genome.txt

------------------------------------------------------------------------------

To conduct all analyses, run the pipeline scripts from the command line from within the 
directory containing the scripts and genomes. The pipeline scripts take the two genomes that 
you are comparing as arguments. Once executed, the pipeline scripts will run all the other 
programs automatically.

Examples of how to run pipelines to compare the Italy and Sweden genomes are listed below.

For CDS:

perl CDSpipeline.pl Italy_genome.txt sweden_genome.txt

For UTR:

perl UTRpipeline.pl Italy_genome.txt sweden_genome.txt
