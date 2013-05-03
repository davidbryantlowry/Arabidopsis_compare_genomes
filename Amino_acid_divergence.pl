#!/usr/bin/perl

#Author: David Bryant Lowry
#Date: 12/23/12

#This program determines pairwise amino acis divergence between two genomes for
#extracted genome CDS.

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

print "Gene\,Gene_Model\,Type\,Start\,End\,Orientation\,Missing\,Sites\,Substitution\,Divergence\,Premature_Stops\n";

#Count pairwaise amino acid divergence for each pair of sequences in files

for (my $y=0; $y < $counter1; ++$y){
	if ("$matrix_array[$y][1]" eq "$set_array[$y][1]"){
		my @protein1 = split('', "$matrix_array[$y][6]"); 
		my @protein2 = split('', "$set_array[$y][6]");
		my $counterX=0;
		my $counterM=0;
		my $counterAA=0;
		my $sites=0;
		my $pairwise=0;
		my $counterSTOP=0;
		my $length = scalar(@protein1);
			for (my $x=0; $x < $length; ++$x){
				if ("$protein1[$x]" eq "X" or "$protein2[$x]" eq "X"){
					$counterX++;
					next;
				}elsif("$protein1[$x]" eq "_" or "$protein2[$x]" eq "_"){
					$counterSTOP++;
					next;
				}elsif("$protein1[$x]" eq "$protein2[$x]"){
					$counterM++;
					next;
				}else{
					$counterAA++;
				}
			}
		my $premature = $counterSTOP - 1;
		$counterAA = $counterAA + $premature;
		$sites=($counterAA + $counterM);
		$pairwise=($counterAA/$sites);
		print "$matrix_array[$y][0]\,$matrix_array[$y][1]\,$matrix_array[$y][2]\,$matrix_array[$y][3]\,$matrix_array[$y][4]\,$matrix_array[$y][5]\,$counterX,$sites\,$counterAA\,$pairwise\,$premature\n";
	 }else{
	 	print "Files not in matching format!!!\n";
	 	die;
	 }
}