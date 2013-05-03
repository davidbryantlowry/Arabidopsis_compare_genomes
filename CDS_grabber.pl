#!/usr/bin/perl

#Author: David Bryant Lowry
#Date: 12/22/12

#This program extracts the protein coding CDS, but does not reverse transcribe

use warnings;
use strict;

my $counter1=0;
my @matrix_rows;
my @matrix_array;
my $trimseq;
my $chr;
my @chr;

#Argument 1 is the genome file
my $file = $ARGV[0];
open(GENOME, $file) or die;

#Read lines of file into an array of arrays
while (<GENOME>){
	chomp $_;
	if ($_ =~ />/){
		next;
	}else{
		push (@chr, $_); 
 	}
}

#Argument 2 is annotation file
my $file2 = $ARGV[1];
open(MATRIX, $file2) or die;

#Read lines of file into an array of arrays
while (<MATRIX>){
	chomp;
	@matrix_rows = split('\t');
	push(@matrix_array, [@matrix_rows]);
	$counter1++;
	}

for (my $x=1; $x < 6; ++$x){
	$chr = "$chr[$x-1]";
	for (my $y=0; $y < $counter1; ++$y){
		if("$matrix_array[$y][0]" == "$x" && "$matrix_array[$y][2]" eq "CDS" && "$matrix_array[$y][6]" eq "+"){
			my $end=("$matrix_array[$y][4]");
			my $start = ("$matrix_array[$y][3]" - 1);
			my $strlen = $end - $start;
			$trimseq = substr($chr,$start,$strlen);
			my $gene_name = "$matrix_array[$y][8]";
			$gene_name =~ s/Parent\=//;
			$gene_name =~ s/\.\d//;
			print "$gene_name\,$matrix_array[$y][2]\,$matrix_array[$y][3]\,$matrix_array[$y][4]\,$matrix_array[$y][6]\,$trimseq\n";
		}elsif("$matrix_array[$y][0]" == "$x" && "$matrix_array[$y][2]" eq "CDS" && "$matrix_array[$y][6]" eq "-"){
			my $end=("$matrix_array[$y][4]");
			my $start = ("$matrix_array[$y][3]" - 1);
			my $strlen = $end - $start;
			$trimseq = substr($chr,$start,$strlen);
			my $gene_name = "$matrix_array[$y][8]";
			$gene_name =~ s/Parent\=//;
			$gene_name =~ s/\.\d//;
			print "$gene_name\,$matrix_array[$y][2]\,$matrix_array[$y][3]\,$matrix_array[$y][4]\,$matrix_array[$y][6]\,$trimseq\n";
 		}else{
 			next;
 		}
 	}
}
