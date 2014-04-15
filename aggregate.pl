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
my @sorted_keys = reverse sort { sort_by_length($a, $b) } keys %hidden;

# Reading the config list
open FD, '<:encoding(UTF-8)', $config_list or die "Couldn't open $config_list.";
while(my $path = <FD>) {
    chomp $path;
    next if $path !~ m/^\/.*$/;
    my $npath = parse($path);
    print "Saving $path to $npath.\n";

    open FDIN, '<:encoding(UTF-8)', $path or (warn "Coudln't read $path.\n" and next);
    if(not open FDOUT, '>:encoding(UTF-8)', $npath) {
        warn "Couldn't open $npath for save.";
        close FDIN;
        next;
    }

    while($line = <FDIN>) {
        foreach my $key (@sorted_keys) {
            $line =~ s/$key/$hidden{$key}/g;
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

    my $dir = ".";
    my $file = $path;
    while($file =~ m/^([^\/]*)\/(.*)$/) {
        $dir = "$dir/$1";
        $file = $2;
        mkdir($dir, 0777) unless (-d $dir);
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

