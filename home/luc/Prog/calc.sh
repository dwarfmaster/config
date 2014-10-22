#!/bin/bash

calc=$(echo "" | dmenu -p "Calc :")
result=$(echo $calc | bc -l)
notify-send '>' "$calc = $result"

