#!/bin/bash

# Check if the correct number of arguments is passed
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <source_file> <username> <ip_address>"
    exit 1
fi

# Assign input arguments to variables
SOURCE_FILE=$1
USERNAME=$2
IP_ADDRESS=$3

# Check if the source file exists
if [ ! -f "$SOURCE_FILE" ]; then
    echo "Error: Source file $SOURCE_FILE does not exist."
    exit 1
fi

# Perform rsync to copy the file to the home directory of the remote user
echo "Copying $SOURCE_FILE to $USERNAME@$IP_ADDRESS:~/"
rsync -avz "$SOURCE_FILE" "$USERNAME@$IP_ADDRESS:~/"

# Check if the rsync command was successful
if [ $? -eq 0 ]; then
    echo "File copied successfully to $USERNAME@$IP_ADDRESS:~/"
else
    echo "Failed to copy the file using rsync."
    exit 1
fi

exit 0
