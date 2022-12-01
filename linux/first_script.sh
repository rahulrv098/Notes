#!/bin/bash

# This script display various information to the screen.

# Display 'Hello'
echo 'Hello'

# Assign a value to a variable
WORD='script'

# Display that value using the variable
echo "$WORD"

# Demonstrate that single qoutes cause variable to NOT get expaned
echo '$WORD'

# Combine the variable with hard-code text
echo "This is shell $WORD"

# Display the content of the variable using an alternative syntax
echo "This is shell ${WORD}"

# Append text to the variable
echo "${WORD}ing is fun!"

# Creating a new variable
ENDING='ed'

# Combine two variable
echo "This is ${WORD}${ENDING}"

# Changing the value stored in Ending Variable ( Reassignment)
ENDING='ing'
echo "${WORD}${ENDING} is fun!"

# Reassign value to ENDING
ENDING='s'
echo "You are going to write many ${WORD}${ENDING} in this class."


#OUTPUT
#Hello
#script
#$WORD
#This is shell script
#This is shell script
#scripting is fun!
#This is scripted
#scripting is fun!
#You are going to write many scripts in this class.
