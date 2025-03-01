#!/bin/bash

# Check if the correct number of arguments is passed
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <username> <server_ip>"
    exit 1
fi

# Assign input arguments to variables
USERNAME=$1
SERVER_IP=$2

# Try to establish an SSH connection (without executing any command)
ssh -o ConnectTimeout=5 "$USERNAME@$SERVER_IP" exit

# Check if the SSH connection was successful
if [ $? -eq 0 ]; then
    echo "SSH connection to $USERNAME@$SERVER_IP successful!"
else
    echo "Failed to connect to $USERNAME@$SERVER_IP. Please check the connection and credentials."
    exit 1
fi

exit 0
