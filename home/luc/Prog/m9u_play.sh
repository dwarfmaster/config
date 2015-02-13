#!/usr/bin/bash
echo "Player called"
cmdfifo=/tmp/LOG1_mplayer_fifo
streamfifo=/tmp/LOG1_mplayer_stream_fifo
mplayer_cmd="/usr/bin/mplayer -slave -input file=$cmdfifo -vo null -noconfig all -noconsolecontrols -quiet"

if [[ $# -lt "1" ]]; then
    exit
fi

function fifo_check {
    if [[ ! -f $1 ]]; then
        mkfifo $1
    elif [[ ! -p $1 ]]; then
        rm -f $1
        mkfifo $1
    fi
}
fifo_check $cmdfifo
fifo_check $streamfifo

file=$1
name=$(echo $file | tr A-Z a-z)
echo "Playing $file"
case $name in
    https://www.youtube.com*)
           exec curl --ciphers RC4-SHA "$(youtube-dl -f 140 -g $file)" | $mplayer_cmd
           ;;
    http*) curl --ciphers RC4-SHA "$file" | exec $mplayer_cmd - ;;
    *)     exec $mplayer_cmd "$file";;
esac

