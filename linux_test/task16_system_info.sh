#!/bin/bash

# Get the hostname
HOSTNAME=$(hostname)

# Get the current system time
CURRENT_TIME=$(date)

# Get the number of users currently logged in
USER_COUNT=$(who | wc -l)

# Display the information
echo "System Information:"
echo "--------------------"
echo "Hostname: $HOSTNAME"
echo "Current Time: $CURRENT_TIME"
echo "Number of Users Logged In: $USER_COUNT"
