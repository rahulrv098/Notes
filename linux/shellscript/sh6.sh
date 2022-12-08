#!/bin/bash
#
#Write a shell script that prompts the user for a name of a file or directory and reports if it is a regular file, a directory, or other type of file.
#Also perform an ls command against the file or directory with the long listing option.
#
echo "Enter the file Path"
read NAME

if [ -f $NAME ]
then 
	echo "$NAME is a regular file"
elif [ -d $NAME ]
then
	echo "$NAME is a directory"
else
	echo "$NAME is a other type of file"
fi

ls -ltr $NAME
