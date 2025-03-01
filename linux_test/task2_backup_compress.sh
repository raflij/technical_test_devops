#!/bin/bash

# Check if the correct number of arguments is passed
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <source_directory> <backup_destination>"
    exit 1
fi

# Get the source directory and backup destination from the arguments
source_dir=$1
backup_dest=$2

# Check if the source directory exists
if [ ! -d "$source_dir" ]; then
    echo "Error: Source directory $source_dir does not exist."
    exit 1
fi

# Get the current date and time for a unique backup filename
timestamp=$(date +"%Y%m%d_%H%M%S")
backup_filename="backup_$(basename "$source_dir")_$timestamp.tar.gz"

# Create the backup and compress it
tar -czf "$backup_dest/$backup_filename" -C "$(dirname "$source_dir")" "$(basename "$source_dir")"

# Check if the backup was successful
if [ $? -eq 0 ]; then
    echo "Backup successful: $backup_dest/$backup_filename"
else
    echo "Backup failed."
    exit 1
fi
