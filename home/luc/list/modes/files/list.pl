#!/usr/bin/perl

use strict;
use warnings;
my $cfg = "/home/LOG1/.list";

my $path = ".";
$path = $ARGV[0] if scalar(@ARGV) > 0;

print "spawn source $cfg/config.sh\n";
print "map [return] spawn perl $cfg/modes/files/open.pl %n\n";
print "map o<Open : > spawn perl $cfg/modes/files/open.pl %s\n";

print "spawn perl $cfg/modes/files/open.pl $path\n";
