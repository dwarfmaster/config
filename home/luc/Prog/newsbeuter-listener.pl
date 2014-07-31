#!/usr/bin/perl

use strict;
use warnings;
use IO::Socket;

my $port = '7777';
my $browser = "uzbl-browser";

exit if fork() != 0;

my $sock = new IO::Socket::INET(
    LocalHost => 'localhost',
    LocalPort => $port,
    Proto     => 'tcp',
    Listen    => 1,
    Reuse     => 1
);
die "Could not create socket : $!\n" unless $sock;

while(1) {
    my $nsock = $sock->accept();
    while(my $in = <$nsock>) {
        if($in =~ m/^open (.*)$/) {
            if(fork() == 0) {
                system($browser, $1);
            }
        } else {
            print $in;
        }
    }
    close $nsock;
}

close $sock;
exit(0);

