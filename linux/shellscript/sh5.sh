#!/bin/bash
#
#Write a shell script that displays "man", "bear", "pig", "dog", "cat", and "sheep" to the screen with each appearing on a separate line. Try to do this in as few lines as possible.
#
NAME="man bear pig dog cat sheep"
for i in $NAME
do
	echo $i
done
