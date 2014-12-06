#!/bin/sh

cmd=$(echo $1 | perl -e 'my $in = <>; if($in =~ m/^(.*) "(.*)"/) { print "$1\t$2"; } else { print ""; }')
if [ -z "$cmd" ]
then
    name=$1
    tags=""
else
    name=$(echo "$cmd" | cut -f1)
    tags=$(echo "$cmd" | cut -f2)
fi
jot bookmark --no-editor --notes "$name" $UZBL_URI $tags

