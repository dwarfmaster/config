#!/usr/bin/bash

fifo="/tmp/caml_light_fifo"
if [[ -e $fifo ]]; then
    rm -f $fifo
fi
mkfifo $fifo
tail -f $fifo | /usr/bin/camllight

