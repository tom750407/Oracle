#!/bin/bash
COUNT=0
while read LINES
do
    echo $LINES
    let COUNT++
done < addusers.txt

echo
echo "$0 looped $COUNT times"
