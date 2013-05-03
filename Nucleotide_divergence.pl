#!/usr/bin/perl

#Author: David Bryant Lowry
#Date: 12/23/12

#This program determines pairwise nucleotide divergence between two genomes for
#extracted genome components (UTR, CDS, promoter, etc).

use warnings;
use strict;

my @matrix_rows;
my @matrix_array;
my $counter1=0;

my @set_rows;
my @set_array;

#First argument is the file for genome 1
my $file = $ARGV[0];
open(MATRIX, $file) or die;

while (<MATRIX>){
	chomp;
	@matrix_rows = split(',');
	push(@matrix_array, [@matrix_rows]);
	$counter1++;
	}

#First argument is the file for genome 2
my $file1 = $ARGV[1];
open(SET, $file1) or die;

while (<SET>){
	chomp;
	@set_rows = split(',');
	push(@set_array, [@set_rows]);
	}
	
print "Gene\,Gene_Model\,Type\,Start\,End\,Orientation\,Missing\,Sites\,SNPs\,Divergence\n";


#Count pairwaise nucleotide divergence for each pair of sequences in files

for (my $y=0; $y < $counter1; ++$y){
	if ("$matrix_array[$y][1]" eq "$set_array[$y][1]"){
		my @dna1 = split('', "$matrix_array[$y][6]"); 
		my @dna2 = split('', "$set_array[$y][6]");
		my $counterN=0;
		my $counterM=0;
		my $counterSNPs=0;
		my $sites=0;
		my $pairwise=0;
		my $length = scalar(@dna1);
			for (my $x=0; $x < $length; ++$x){
				if ("$dna1[$x]" eq "N" or "$dna2[$x]" eq "N"){
					$counterN++;
					next;
				}elsif("$dna1[$x]" eq "$dna2[$x]"){
					$counterM++;
					next;
				}else{
					$counterSNPs++;
				}
			}
		$sites=($counterSNPs + $counterM);
		$pairwise=($counterSNPs/$sites);
		print "$matrix_array[$y][0]\,$matrix_array[$y][1]\,$matrix_array[$y][2]\,$matrix_array[$y][3]\,$matrix_array[$y][4]\,$matrix_array[$y][5]\,$counterN\,$sites\,$counterSNPs\,$pairwise\n";
	 }else{
	 	print "Files not in matching format!!!\n";
	 #	die;
	 }
}