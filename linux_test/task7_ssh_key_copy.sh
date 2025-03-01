#!/bin/bash

# Check if the correct number of arguments is passed
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <public_key_file> <username> <server_ip>"
    exit 1
fi

# Assign input arguments to variables
PUBLIC_KEY_FILE=$1
USERNAME=$2
SERVER_IP=$3

# Check if the public key file exists
if [ ! -f "$PUBLIC_KEY_FILE" ]; then
    echo "Error: Public key file $PUBLIC_KEY_FILE does not exist."
    exit 1
fi

# Copy the public key to the remote server
echo "Copying public key to remote server $SERVER_IP..."

ssh-copy-id -i "$PUBLIC_KEY_FILE" "$USERNAME@$SERVER_IP"

# Check if the ssh-copy-id command was successful
if [ $? -eq 0 ]; then
    echo "Public key successfully copied to $USERNAME@$SERVER_IP"
else
    echo "Error: Failed to copy the public key."
    exit 1
fi

exit 0
