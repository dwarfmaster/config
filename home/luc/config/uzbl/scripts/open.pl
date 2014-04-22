#!/usr/bin/perl

use strict;
use warnings;

my ($url) = @ARGV;
die "You must provide an url" if not defined $url;

my $fifo = $ENV{UZBL_FIFO};
open FD,">",$fifo or die "Couldn't open $fifo for writing.";
if($url =~ m/^\w+:\/\/.*$/
        or $url =~ m/^(\w+\.)?\w+\.\w+(\/.*)?/) {
    print FD "uri $url\n";
} else {
    print FD "uri http://duckduckgo.com/?q=$url\n";
}
close FD;

