#!/bin/bash

# Check if the correct number of arguments is passed
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <unique_string_in_key> <username>"
    exit 1
fi

# Assign input arguments to variables
UNIQUE_STRING=$1
USERNAME=$2

# Get the home directory of the specified user
USER_HOME=$(eval echo ~$USERNAME)

# Check if the user exists and has a home directory
if [ ! -d "$USER_HOME" ]; then
    echo "Error: User $USERNAME does not exist or has no home directory."
    exit 1
fi

# Define the path to the authorized_keys file
AUTHORIZED_KEYS="$USER_HOME/.ssh/authorized_keys"

# Check if the authorized_keys file exists
if [ ! -f "$AUTHORIZED_KEYS" ]; then
    echo "Error: authorized_keys file does not exist for user $USERNAME."
    exit 1
fi

# Remove the line containing the unique string from authorized_keys
sed -i "/$UNIQUE_STRING/d" "$AUTHORIZED_KEYS"

# Check if the key was removed successfully
if [ $? -eq 0 ]; then
    echo "Public key containing '$UNIQUE_STRING' successfully removed from $AUTHORIZED_KEYS for $USERNAME."
else
    echo "Failed to remove public key containing '$UNIQUE_STRING' from $AUTHORIZED_KEYS."
    exit 1
fi

exit 0
