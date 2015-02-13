#!/usr/bin/bash
echo "Player called"
mplayer_cmd="/usr/bin/mplayer -msglevel all=0 -vo null -noconfig all -noconsolecontrols -quiet"

if [[ $# -lt "1" ]]; then
    exit
fi

file=$1
name=$(echo $file | tr A-Z a-z)
echo "Playing $file"
case $name in
    https://www.youtube.com*)
           curl --ciphers RC4-SHA "$(youtube-dl -f 140 -g $file)" 2>/dev/null | exec $mplayer_cmd -
           ;;
    http*) curl --ciphers RC4-SHA "$file" 2>/dev/null | exec $mplayer_cmd - ;;
    *)     exec $mplayer_cmd "$file";;
esac

