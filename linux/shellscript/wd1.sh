#!/bin/bash
#shebang
#
#q1.Write a shell script that renames all files in the current directory that end in ".jpg" to begin with today's date in the following format: YYYY­MM­DD. For example, if a picture of my cat was in the current directory and today was October 31, 2016 it would change name from "mycat.jpg" to "2016­10­31­mycat.jpg".
#comment/file details
#
#global variable
DAY=$(date +%F)

for FILE in *.jpg; do
	mv $FILE ${DAY}-${FILE}
done

