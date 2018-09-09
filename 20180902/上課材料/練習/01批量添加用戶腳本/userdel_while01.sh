#!/bin/bash

USERS_INFO=/root/exercise1/addusers.txt
USERDEL=/usr/sbin/userdel
PASSWD=/usr/bin/passwd
CUT=/bin/cut

while read LINES
do
    USERNAME=`echo $LINES | $CUT -f1 -d ' '`
    PASSWORD=`echo $LINES | $CUT -f2 -d ' '`
    echo | $PASSWD -d $USERNAME
    if [ $? -ne 0 ]; then
	echo "$USERNAME is not exits"
    else
	echo | $USERDEL -r $USERNAME
    fi
done < $USERS_INFO
