#!/usr/bin/perl

#Author: David Bryant Lowry
#Date: 12/23/12

use warnings;
use strict;

#This is a pipeline script that takes two Col-0 reference aligned Arabidopsis genomes 
#in SHORE/FASTA format and an annotation file as arguments.
#The script returns output files for each stage in the process
#so that the user can see where any error have occured or to look
#at results in more detail. If completed the pipeline will return
#files that calculate nucleotide and amino acid divergence
#between the two genomes.

#The pipeline requires that the following scripts be in the same
#directory with this script to function properly:

#CDS_grabber.pl
#CDS_combiner.pl
#CDStoProtein.pl
#Amino_acid_divergence.pl
#Nucleotide_divergence.pl

#Also, make sure that the two genome files and the modified Tair10 annotation 
#file (TAIR10_GFF3_genes_mod.gff.cr) are in the directory. The pipeline will not  
#work with the original annotation file. The names of the genomes file should be in
#the format line_genome.txt.

#Argument 1 is the first genome
my $genome1 = $ARGV[0];
my @genome1 = split('_',"$genome1");
my $name1 = "$genome1[0]";

#Argument 2 is the second genome
my $genome2 = $ARGV[1];
my @genome2 = split('_',"$genome2");
my $name2 = "$genome2[0]";

print "-"x60, "\n";
print "CDSpipeline.pl v 1.0\n";
print "Created 23 Dec 2012 David B Lowry\n";
print "Last modified 24 Dec 2012\n";
print "-"x60, "\n\n";

#Extract CDS of all gene models for first genome
print "Extracting CDS for the $name1 genome\n";
print "See file: $name1\_CDS.csv for output of this step\n\n";
system ("perl CDS_grabber.pl $genome1 TAIR10_GFF3_genes_mod.gff.cr > $name1\_CDS.csv");

#Extract CDS of all gene models for second genome
print "Extracting CDS for the $name2 genome\n";
print "See file: $name2\_CDS.csv for output of this step\n\n";
system ("perl CDS_grabber.pl $genome2 TAIR10_GFF3_genes_mod.gff.cr > $name2\_CDS.csv");

#Combine CDS of all gene models for first genome
print "Reverse complementing and combining CDS for the $name1 genome\n";
print "See file: $name1\_combined_CDS.csv for output of this step\n";
print "Ignore one line warning\n";
system ("perl CDS_combiner.pl $name1\_CDS.csv > $name1\_combined_CDS.csv");

print "\n";

#Combine CDS of all gene models for second genome
print "Reverse complementing and combining CDS for the $name2 genome\n";
print "See file: $name2\_combined_CDS.csv for output of this step\n";
print "Ignore one line warning\n";
system ("perl CDS_combiner.pl $name2\_CDS.csv > $name2\_combined_CDS.csv");

print "\n";

#Translate CDS to protein coding for first genome
print "Translating CDS to ammino acid for the $name1 genome\n";
print "See file: $name1\_protein.csv for output of this step\n\n";
system ("perl CDStoProtein.pl $name1\_combined_CDS.csv > $name1\_protein.csv");

#Translate CDS to protein coding for second genome
print "Translating CDS to ammino acid for the $name2 genome\n";
print "See file: $name2\_protein.csv for output of this step\n\n";
system ("perl CDStoProtein.pl $name2\_combined_CDS.csv > $name2\_protein.csv"); 

#Calculating nucleotide divergence between the two genomes
print "Calculating nucleotide divergence between the two genomes\n";
print "See file: $name1\_$name2\_CDS_nucleotide_divergence.csv for output of this step\n\n";
system ("perl Nucleotide_divergence.pl $name1\_combined_CDS.csv $name2\_combined_CDS.csv > $name1\_$name2\_CDS_nucleotide_divergence.csv");

#Calculating protein divergence between the two genomes
print "Calculating protein divergence between the two genomes\n";
print "See file: $name1\_$name2\_CDS_protein_divergence.csv for output of this step\n\n";
system ("perl Amino_acid_divergence.pl $name1\_protein.csv $name2\_protein.csv > $name1\_$name2\_CDS_protein_divergence.csv");

print "Process complete. Check output for errors\n\n";
