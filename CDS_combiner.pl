#!/usr/bin/perl

#Author: David Bryant Lowry
#Date: 12/22/12

#This program takes in a file of 
#extracted gene CDS and joins them together
#producing reverse complements of those
#with a negative orientation

use warnings;
use strict;

my $counter1=0;
my $trimseq;
my @matrix_rows;
my @matrix_array;

#Argument 1 is the CDS file
my $file1 = $ARGV[0];
open(MATRIX, $file1) or die;

#Read lines of file into an array of arrays
while (<MATRIX>){
	chomp;
	@matrix_rows = split('\,');
	push(@matrix_array, [@matrix_rows]);
	$counter1++;
	}

my $string = "empty";
my $start = "empty";

for (my $y=0; $y < $counter1; ++$y){
	if("$matrix_array[$y][5]" eq "+"){
		if("$matrix_array[$y][1]" eq "$matrix_array[$y+1][1]"){
			if($string eq "empty"){
				$string = ("$matrix_array[$y][6]" . "$matrix_array[$y+1][6]");
				$start = "$matrix_array[$y][3]";
			}elsif($string ne "empty"){
				$string = ("$string" . "$matrix_array[$y+1][6]");
			}else{
				die;
			}
		}elsif($string eq "empty"){
			print "$matrix_array[$y][0]\,$matrix_array[$y][1]\,$matrix_array[$y][2]\,$matrix_array[$y][3]\,$matrix_array[$y][4]\,$matrix_array[$y][5]\,$matrix_array[$y][6]\n";
			$string = "empty";
			$start = "empty";
		}elsif($string ne "empty"){
			print "$matrix_array[$y][0]\,$matrix_array[$y][1]\,$matrix_array[$y][2]\,$start\,$matrix_array[$y][4]\,$matrix_array[$y][5]\,$string\n";
			$string = "empty";
			$start = "empty";
		}else{
			die;
		}
	}elsif("$matrix_array[$y][5]" eq "-"){
		if("$matrix_array[$y][1]" eq "$matrix_array[$y+1][1]"){
			if($string eq "empty"){
				my $str1 = "$matrix_array[$y][6]";
				my $str2 = "$matrix_array[$y+1][6]";
				$str1 = reverse $str1;
				$str1 =~ tr/ACGT/TGCA/;
				$str2 = reverse $str2;
				$str2 =~ tr/ACGT/TGCA/;
				$string = $str1 . $str2;
				$start = "$matrix_array[$y][4]";
			}elsif($string ne "empty"){
				my $str3 = "$matrix_array[$y+1][6]";
				$str3 = reverse $str3;
				$str3 =~ tr/ACGT/TGCA/;
				$string = $string . $str3;
			}else{
				die;
			}
		}elsif($string eq "empty"){
			my $str1 = "$matrix_array[$y][6]";
			$str1 = reverse $str1;
			$str1 =~ tr/ACGT/TGCA/;
			print "$matrix_array[$y][0]\,$matrix_array[$y][1]\,$matrix_array[$y][2]\,$matrix_array[$y][4]\,$matrix_array[$y][3]\,$matrix_array[$y][5]\,$str1\n";
			$string = "empty";
			$start = "empty";
		}elsif($string ne "empty"){
			print "$matrix_array[$y][0]\,$matrix_array[$y][1]\,$matrix_array[$y][2]\,$start\,$matrix_array[$y][3]\,$matrix_array[$y][5]\,$string\n";
			$string = "empty";
			$start = "empty";
		}else{
			die;
		}
	}else{
		die;
	}
}