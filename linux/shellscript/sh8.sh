#!/bin/bash
#Modify the previous script to accept an unlimited number of files and directories as arguments.
#
FILE=$@
for NAME in $FILE
do
	if [ -f $NAME ]
	then 
		echo "$NAME is a regular file"
	elif [ -d $NAME ]
	then
		echo "$NAME is a directory"
	else
		echo "$NAME is a other type of file"
	fi
	ls -l $NAME
done
