#!/bin/bash

# Check if the correct number of arguments is passed
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <directory>"
    exit 1
fi

# Assign input directory argument
KEY_DIR=$1

# Check if the directory exists, if not, create it
if [ ! -d "$KEY_DIR" ]; then
    echo "Directory does not exist. Creating directory: $KEY_DIR"
    mkdir -p "$KEY_DIR"
    if [ $? -ne 0 ]; then
        echo "Error: Failed to create directory $KEY_DIR."
        exit 1
    fi
fi

# Set the key file name
PRIVATE_KEY="$KEY_DIR/id_rsa"
PUBLIC_KEY="$PRIVATE_KEY.pub"

# Generate SSH key pair
echo "Generating SSH key pair..."
ssh-keygen -t rsa -b 4096 -f "$PRIVATE_KEY" -N ""

# Check if the key generation was successful
if [ $? -eq 0 ]; then
    echo "SSH key pair generated successfully:"
    echo "Private Key: $PRIVATE_KEY"
    echo "Public Key: $PUBLIC_KEY"
else
    echo "Error: Failed to generate SSH key pair."
    exit 1
fi

exit 0
