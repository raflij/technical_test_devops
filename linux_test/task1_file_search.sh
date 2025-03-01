#!/bin/bash

# Check if the correct number of arguments is passed
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <directory> <extension>"
    exit 1
fi

# Get the directory and extension from the arguments
directory=$1
extension=$2

# Check if the directory exists
if [ ! -d "$directory" ]; then
    echo "Directory $directory does not exist."
    exit 1
fi

# Find and list the files with the specified extension in the given directory
find "$directory" -type f -name "*.$extension" -print
