#!/bin/sh

#NOTE: it's the job of the script that inserts bookmarks to make sure there are no dupes.

DMENU_SCHEME="bookmarks"
DMENU_OPTIONS="xmms vertical resize"

. "$UZBL_UTIL_DIR/dmenu.sh"
. "$UZBL_UTIL_DIR/uzbl-dir.sh"

query="$*"
if [ -z "$DMENU_HAS_VERTICAL" ]; then
    # because they are all after each other, just show the url, not their tags.
    goto=$( /home/LOG1/Prog/jot search --format='{{url}}' $query | $DMENU )
else
    # show tags as well
    goto=$( /home/LOG1/Prog/jot search --format='{{notes}} -- {{url}}' $query | $DMENU | sed 's/.*-- //g')
fi

[ -n "$goto" ] && echo "uri $goto" > "$UZBL_FIFO"
