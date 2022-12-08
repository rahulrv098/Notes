#!/bin/bash
#
#q1.Write a shell script that consists of a function that displays the number of files in the present working directory. Name this function “file_count” and call it in your script. If you use variable in your function, remember to make it a local variable.
#
function file_count() 
{
  local NUMBER_OF_FILES=$(ls | wc -l)
  echo "$NUMBER_OF_FILES"
}

file_count
