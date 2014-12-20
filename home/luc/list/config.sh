#!/usr/bin/bash
# Script converting config files to script
# for the list program

prefix=/home/LOG1/.list
files=(keys colors)

for file in "${files[@]}"; do
    path="$prefix/$file"
    if [[ ! -e $path ]]; then
        continue
    fi
    while read line; do
        if [[ ! -z $line && ! $line =~ ^"#" ]]; then
            echo $line
        fi
    done < $path
done

