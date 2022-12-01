#!/bin/bash

# Display the UID and username of the user executing the script.
# Display if the user is the root user or not.

# Display the UID
echo "Your UID is ${UID}"

# Display the username
USER_NAME=$(id -un)
echo "Your username is ${USER_NAME}"

# we can also use whoami command in last line to display username.

#echo "Your username is `whoami`"

# Display if the user is the root user or not

if [[ ${UID} -eq 0 ]]
then
        echo "You are root"
else
        echo "You are not root"
fi

#output when run as root
#Your UID is 0
#Your username is root
#You are root
