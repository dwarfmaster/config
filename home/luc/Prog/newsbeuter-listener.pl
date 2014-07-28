#!/usr/bin/perl

use strict;
use warnings;

my $path = "/tmp/newsbeuter.fifo";
my $browser = "uzbl-browser";

system("mkfifo", $path);
my $fifo;
open($fifo, "+< $path") or die "Couldn't create and open $path name pipe.";

while(my $in = <$fifo>)
{
    if($in =~ m/^open (.*)$/) {
        if(fork() == 0) {
            system($browser, $1);
        }
    } else {
        print STDERR $in;
    }
}

close $fifo;
exit(0);

