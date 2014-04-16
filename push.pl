#!/usr/bin/perl

use warnings;
use strict;
use autodie;

# Configuration
my $config_list = "cfglist";
my $to_hide     = "tohide";

# Reading the words to hide
open FD, '<:encoding(UTF-8)', $to_hide or die "Couldn't read $to_hide.";
my %hidden;
my $line;
while($line = <FD>) {
    next if $line !~ m/^([^\s]+)\s+(\w+)$/;
    my $key = $1;
    my $value = $2;
    $hidden{$key} = $value;
}
close FD;

# Reading the config list
open FD, '<:encoding(UTF-8)', $config_list or die "Couldn't open $config_list.";
while(my $path = <FD>) {
    chomp $path;
    next if $path !~ m/^\/.*$/;
    my $npath = parse($path);
    print "Restoring $npath to $path.\n";

    open FDIN, '<:encoding(UTF-8)', $npath or (warn "Coudln't read $npath.\n" and next);
    if(not open FDOUT, '>:encoding(UTF-8)', $path) {
        warn "Couldn't open $path for save.";
        close FDIN;
        next;
    }

    # Restoring
    while($line = <FDIN>) {
        while(my ($key,$value) = each(%hidden)) {
            $line =~ s/$value/$key/g;
        }
        print FDOUT $line;
    }

    close FDIN;
    close FDOUT;
}
close FD;

# Reading a path
sub parse {
    my ($path) = @_;
    return undef if not $path;

    # Make the path relative.
    if($path =~ m/^\/(.*)$/) {
        $path = $1;
    }

    my $dir;
    my $file;
    if($path =~ m/^(.*)\/([^\/]*)$/) {
        $dir = $1;
        $file = $2;
        $dir =~ s/\/\./\//g;
    } else {
        $dir = ".";
        $file = $path;
    }

    if($file =~ m/^\.(.*)$/) {
        $file = $1;
    }
    $path = "$dir/$file";
    return $path;
}

# To sort tohide by length
sub sort_by_length {
    my ($k1, $k2) = @_;
    return length($k1) <=> length($k2);
}

