#!/usr/bin/perl -w

use strict;
use warnings;
use utf8;

binmode(STDOUT, ":utf8");

my $num_args = $#ARGV + 1;
if ($num_args != 1) {
  print "\nUsage: critic.pl file\n";
  exit;
}

my $filename=$ARGV[0];

# my $filename = 'data.txt';
open(my $fh, '<:encoding(UTF-8)', $filename)
  or die "Could not open file '$filename' $!";

while (my $row = <$fh>) {
  chomp $row;
  $row =~ s/{\+\+(.+)\+\+}/\\add{$1}/g;
  $row =~ s/{~~(.+)~>(.+)~~}/\\change{$1}{$2}/g;
  $row =~ s/{--(.+)--}/\\remove{$1}/g;
  $row =~ s/{==(.+)==}{>>(.+)<<}/\\annote{$1}{$2}/g;
  $row =~ s/{>>(.+)<<}/\\note{$1}/g;
  $row =~ s/{==(.+)==}/\\hilight{$1}/g;
  print "$row\n";
}
