#!/bin/bash
COUNT=0
for LINES in `cat addusers.txt`
do
    echo $LINES
    let COUNT++
done
echo
echo "$0 looped $COUNT times"
