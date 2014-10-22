#!/bin/bash

calc=$(echo "" | dmenu -p "Calc :")
result=$(echo $calc | bc)
notify-send '>' "$calc = $result"

