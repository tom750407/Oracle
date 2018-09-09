#!/bin/bash
while read LINES
do
    USERNAME=`echo $LINES | cut -f1 -d ' '`
    PASSWORD=`echo $LINES | cut -f2 -d ' '`
    useradd $USERNAME
    echo $PASSWORD | passwd --stdin $USERNAME
done < addusers.txt
