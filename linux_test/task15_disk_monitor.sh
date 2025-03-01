#!/bin/bash

# Disk usage threshold
THRESHOLD=80

# Disk partition to check (e.g., "/")
DISK_PARTITION="/"

# Function to check disk usage
get_disk_usage() {
    # Get the disk usage percentage for the specified partition
    DISK_USAGE=$(df -h $DISK_PARTITION | awk 'NR==2 {print $5}' | sed 's/%//')
    echo $DISK_USAGE
}

# Function to send notification
send_notification() {
    MESSAGE="Disk usage on $DISK_PARTITION is above $THRESHOLD%. Current usage: $1%"
    
    # Using 'notify-send' to send notification (for graphical systems)
    notify-send "Disk Usage Alert" "$MESSAGE"
    
    # Alternatively, using 'mail' to send an email (if configured)
    # echo "$MESSAGE" | mail -s "Disk Usage Alert" user@example.com
}

# Monitor the disk usage
while true; do
    # Get the current disk usage
    CURRENT_DISK_USAGE=$(get_disk_usage)

    # Check if disk usage exceeds the threshold
    if [ $CURRENT_DISK_USAGE -gt $THRESHOLD ]; then
        # Send notification
        send_notification $CURRENT_DISK_USAGE
    fi

    # Sleep for 60 seconds before checking again
    sleep 60
done
