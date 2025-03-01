#!/bin/bash

# Check if the correct number of arguments is passed
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <source_directory> <backup_directory>"
    exit 1
fi

# Assign input arguments
SOURCE_DIR=$1
BACKUP_DIR=$2

# Check if source directory exists
if [ ! -d "$SOURCE_DIR" ]; then
    echo "Error: Source directory $SOURCE_DIR does not exist."
    exit 1
fi

# Ensure backup directory exists
mkdir -p "$BACKUP_DIR"

# Generate backup filename with timestamp
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
BACKUP_FILE="$BACKUP_DIR/backup_$TIMESTAMP.tar.gz"

# Create a compressed backup
tar -czf "$BACKUP_FILE" "$SOURCE_DIR"

if [ $? -eq 0 ]; then
    echo "Backup successful: $BACKUP_FILE"
else
    echo "Backup failed!"
    exit 1
fi

# Delete backups older than 7 days
find "$BACKUP_DIR" -name "backup_*.tar.gz" -type f -mtime +7 -exec rm -f {} \;

echo "Old backups (older than 7 days) deleted."

exit 0
