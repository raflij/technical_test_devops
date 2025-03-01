#!/bin/bash

# Check if the correct number of arguments is passed
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <public_key_file> <username>"
    exit 1
fi

# Assign input arguments to variables
PUBLIC_KEY_FILE=$1
USERNAME=$2

# Check if the public key file exists
if [ ! -f "$PUBLIC_KEY_FILE" ]; then
    echo "Error: Public key file $PUBLIC_KEY_FILE does not exist."
    exit 1
fi

# Get the home directory of the specified user
USER_HOME=$(eval echo ~$USERNAME)

# Check if the user exists and has a home directory
if [ ! -d "$USER_HOME" ]; then
    echo "Error: User $USERNAME does not exist or has no home directory."
    exit 1
fi

# Create the .ssh directory if it doesn't exist
SSH_DIR="$USER_HOME/.ssh"
if [ ! -d "$SSH_DIR" ]; then
    echo "Creating .ssh directory for $USERNAME"
    mkdir -p "$SSH_DIR"
    chown $USERNAME:$USERNAME "$SSH_DIR"
    chmod 700 "$SSH_DIR"
fi

# Add the public key to the authorized_keys file
AUTHORIZED_KEYS="$SSH_DIR/authorized_keys"
cat "$PUBLIC_KEY_FILE" >> "$AUTHORIZED_KEYS"

# Set the correct permissions for the authorized_keys file
chown $USERNAME:$USERNAME "$AUTHORIZED_KEYS"
chmod 600 "$AUTHORIZED_KEYS"

echo "Public key successfully added to $USER_HOME/.ssh/authorized_keys for $USERNAME."
exit 0
