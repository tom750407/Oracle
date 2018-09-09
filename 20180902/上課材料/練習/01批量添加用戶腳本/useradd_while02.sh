#!/bin/bash
while read LINES
do
    USERNAME=`echo $LINES | cut -f1 -d ' '`
    PASSWORD=`echo $LINES | cut -f2 -d ' '`
    echo -n "USERNAME:$USERNAME PASSWORD:$PASSWORD"
    echo
done < addusers.txt
