#!/bin/bash
#
#q4.Write a shell script to check to see if the file "/etc/shadow" exists. If it does exist, display "Shadow passwords are enabled." Next, check to see if you can write to the file. If you can, display "You have permissions to edit /etc/shadow." If you cannot, display "You do NOT have permissions to edit /etc/shadow."
#TO CHECK IF FILE EXIST OR NOT
FILE="/etc/shadow"
if [ -e $FILE ]
then
	echo "$FILE passwords are enabled"
else
	echo "$FILE doesn't exist"
fi
#TO CHECK IF EDIT PERMISSION  EXIST OR NOT
if [ -w $FILE ]
then
	echo  "You have permissions to edit /etc/shadow."
else
        echo "You do NOT have permissions to edit /etc/shadow."
fi
