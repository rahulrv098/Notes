#!/bin/bash
#
#q3.Store the output of the command "hostname" in a variable. Display "This script is running on _______." where "_______" is the output of the "hostname" command.Store the output of the command "hostname" in a variable. Display "This script is running on _______." where "_______" is the output of the "hostname" command.Store the output of the command "hostname" in a variable. Display "This script is running on _______." where "_______" is the output of the "hostname" command.
#
HOSTNAME=$(hostname)
#HOSTNAME=`hostname`
echo "This script is running on ${HOSTNAME}"
