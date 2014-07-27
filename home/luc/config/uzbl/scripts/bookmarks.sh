#!/bin/sh

cmd=$(echo $1 | perl -e 'my $in = <>; if($in =~ m/^(.*) "(.*)"/) { print "$1\t$2"; } else { print ""; }')
echo "Cmd : \"$cmd\" ..."
if [ -z "$cmd" ]
then
    echo "... is empty"
    name=$1
    tags=""
else
    name=$(echo "$cmd" | cut -f1)
    tags=$(echo "$cmd" | cut -f2)
    echo "... includes \"$name\" and \"$tags\""
fi
echo "Bookmarking $UZBL_URI with \"$name\" [$tags] from \"$1\""
jot bookmark --skip-editor --notes "$name" $UZBL_URI $tags

