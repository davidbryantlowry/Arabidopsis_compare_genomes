#!/usr/bin/perl

#Author: David Bryant Lowry
#Date: 12/23/12

#This program takes in the combined CDS file from CDS_combiner.pl
#and convert DNA sequence to amino acid sequence

use warnings;
use strict;

my @matrix_rows;
my @matrix_array;
my $protein='';
my $codon;
my $DNA;
my $counter1;
my(%g)=('TCA'=>'S','TCC'=>'S','TCG'=>'S','TCT'=>'S','TTC'=>'F','TTT'=>'F','TTA'=>'L','TTG'=>'L','TAC'=>'Y','TAT'=>'Y','TAA'=>'_','TAG'=>'_','TGC'=>'C','TGT'=>'C','TGA'=>'_','TGG'=>'W','CTA'=>'L','CTC'=>'L','CTG'=>'L','CTT'=>'L','CCA'=>'P','CCC'=>'P','CCG'=>'P','CCT'=>'P','CAC'=>'H','CAT'=>'H','CAA'=>'Q','CAG'=>'Q','CGA'=>'R','CGC'=>'R','CGG'=>'R','CGT'=>'R','ATA'=>'I','ATC'=>'I','ATT'=>'I','ATG'=>'M','ACA'=>'T','ACC'=>'T','ACG'=>'T','ACT'=>'T','AAC'=>'N','AAT'=>'N','AAA'=>'K','AAG'=>'K','AGC'=>'S','AGT'=>'S','AGA'=>'R','AGG'=>'R','GTA'=>'V','GTC'=>'V','GTG'=>'V','GTT'=>'V','GCA'=>'A','GCC'=>'A','GCG'=>'A','GCT'=>'A','GAC'=>'D','GAT'=>'D','GAA'=>'E','GAG'=>'E','GGA'=>'G','GGC'=>'G','GGG'=>'G','GGT'=>'G');


#Argument 1 is the CDS file with everything in proper frame
my $file = $ARGV[0];
open(MATRIX, $file) or die;

#Read lines of file into an array of arrays
while (<MATRIX>){
	chomp;
	@matrix_rows = split('\,');
	push(@matrix_array, [@matrix_rows]);
	$counter1++;
	}

close MATRIX;

#Loop through each line of the CDS file
for(my $y=0; $y< $counter1; ++$y){
	$DNA = "$matrix_array[$y][6]";	
	for(my $i=0; $i<(length($DNA)-2); $i+=3){
		$codon = substr($DNA,$i,3);
		$protein .= &codon2aa($codon);
	}
	print "$matrix_array[$y][0]\,$matrix_array[$y][1]\,$matrix_array[$y][2]\,$matrix_array[$y][3]\,$matrix_array[$y][4]\,$matrix_array[$y][5]\,$protein\n"; 
	$protein='';
}

#Subroutine to translate codons amino acids
sub codon2aa{
	my($codon)=@_;
	if ($codon =~ /N/){
		return "X";
	}elsif($codon =~ /W/){
		return "X";
	}elsif(exists $g{$codon}){
		return $g{$codon};
	}else{
		print STDERR "Bad codon \"$codon\"!!\n";
		exit;
	}
}