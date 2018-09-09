#!/bin/bash
read -p "please enter a filename: " filename
if [ ! -e $filename ] ;then
	echo "$filename is not exist!!!"
	exit 1
fi
if [ -r $filename ] ;then
	echo "$filename is readable"
fi
if [ -w $filename ] ;then
	echo "$filename is writable"
fi
if [ -x $filename ] ;then
	echo "$filename is executable"
fi
