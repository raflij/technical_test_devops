#!/bin/bash

# Check if the correct number of arguments is passed
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <start|stop|status> <service_name>"
    exit 1
fi

# Assign input arguments to variables
ACTION=$1
SERVICE=$2

# Function to start the service
start_service() {
    echo "Starting $SERVICE..."
    sudo systemctl start "$SERVICE"
    if [ $? -eq 0 ]; then
        echo "$SERVICE started successfully."
    else
        echo "Failed to start $SERVICE."
    fi
}

# Function to stop the service
stop_service() {
    echo "Stopping $SERVICE..."
    sudo systemctl stop "$SERVICE"
    if [ $? -eq 0 ]; then
        echo "$SERVICE stopped successfully."
    else
        echo "Failed to stop $SERVICE."
    fi
}

# Function to check the status of the service
status_service() {
    echo "Checking status of $SERVICE..."
    sudo systemctl status "$SERVICE" --no-pager
    if [ $? -eq 0 ]; then
        echo "$SERVICE is running."
    else
        echo "$SERVICE is not running or doesn't exist."
    fi
}

# Perform the requested action
case $ACTION in
    start)
        start_service
        ;;
    stop)
        stop_service
        ;;
    status)
        status_service
        ;;
    *)
        echo "Invalid action. Use 'start', 'stop', or 'status'."
        exit 1
        ;;
esac

exit 0
