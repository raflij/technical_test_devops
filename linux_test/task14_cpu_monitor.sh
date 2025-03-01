#!/bin/bash

# Log file location
LOG_FILE="/var/log/cpu_usage_log.txt"

# CPU usage threshold
THRESHOLD=75

# Function to get the CPU usage
get_cpu_usage() {
    # Get the CPU usage for the last minute (1-minute load average)
    CPU_USAGE=$(uptime | awk -F'load average: ' '{ print $2 }' | cut -d',' -f1)
    
    # Convert to an integer (remove decimal)
    CPU_USAGE_INT=$(echo "$CPU_USAGE" | awk '{print int($1)}')
    
    echo $CPU_USAGE_INT
}

# Function to log CPU usage to the log file
log_cpu_usage() {
    TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
    echo "$TIMESTAMP - CPU usage: $1%" >> $LOG_FILE
}

# Monitor the CPU usage
while true; do
    # Get the current CPU usage
    CURRENT_CPU_USAGE=$(get_cpu_usage)

    # Check if CPU usage exceeds the threshold
    if [ $CURRENT_CPU_USAGE -gt $THRESHOLD ]; then
        # Log the high CPU usage
        log_cpu_usage $CURRENT_CPU_USAGE
    fi

    # Sleep for 60 seconds before checking again
    sleep 60
done
