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
#files that calculate nucleotide divergence in the 3' and 5' UTR
#between the two genomes.

#The pipeline requires that the following scripts be in the same
#directory with this script to function properly:

#UTR_grabber.pl
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
print "UTRpipeline.pl v 1.0\n";
print "Created 23 Dec 2012 David B Lowry\n";
print "Last modified 24 Dec 2012\n";
print "-"x60, "\n\n";

#Extract UTR of all gene models for first genome
print "Extracting UTR for the $name1 genome\n";
print "See file: $name1\_UTR.csv for output of this step\n\n";
system ("perl UTR_grabber.pl $genome1 TAIR10_GFF3_genes_mod.gff.cr > $name1\_UTR.csv");

#Extract UTR of all gene models for second genome
print "Extracting UTR for the $name2 genome\n";
print "See file: $name2\_UTR.csv for output of this step\n\n";
system ("perl UTR_grabber.pl $genome2 TAIR10_GFF3_genes_mod.gff.cr > $name2\_UTR.csv");

#Calculating nucleotide divergence between the two genomes
print "Calculating nucleotide divergence in UTRs between the two genomes\n";
print "See file: $name1\_$name2\_UTR_nucleotide_divergence.csv for output of this step\n\n";
system ("perl Nucleotide_divergence.pl $name1\_UTR.csv $name2\_UTR.csv > $name1\_$name2\_UTR_nucleotide_divergence.csv");

print "Process complete. Check output for errors\n\n";
