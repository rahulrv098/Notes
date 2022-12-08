#!/bin/bash
echo "Please enter a file extension: "
read EXTENSION
if [ ${#EXTENSION} -eq 0 ]
then
    echo "No file extension provided. Aborting."
    exit 1
fi
PREFIX=$(date +%F)
echo  "Please enter a file prefix: (Press ENTER for ${PREFIX}). " 
read NEW_PREFIX
if [ ${#NEW_PREFIX} -ne 0 ]
then
    PREFIX="${NEW_PREFIX}"
fi
for FILENAME in *.${EXTENSION}
do
    NEW_FILENAME="${PREFIX}-${FILENAME}"
    echo "Renaming ${FILENAME} to ${NEW_FILENAME}."
    mv "${FILENAME}" "${NEW_FILENAME}"
done
