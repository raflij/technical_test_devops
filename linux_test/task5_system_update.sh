#!/bin/bash

# Define log file location
LOG_FILE="/var/log/system_update.log"

# Detect package manager
if command -v apt &> /dev/null; then
    PKG_MANAGER="apt"
    UPDATE_CMD="apt update && apt upgrade -y"
elif command -v yum &> /dev/null; then
    PKG_MANAGER="yum"
    UPDATE_CMD="yum update -y"
else
    echo "Unsupported package manager. Please update manually."
    exit 1
fi

# Log start time
echo "----------------------------------------" | tee -a "$LOG_FILE"
echo "System update started at: $(date)" | tee -a "$LOG_FILE"
echo "Using package manager: $PKG_MANAGER" | tee -a "$LOG_FILE"
echo "----------------------------------------" | tee -a "$LOG_FILE"

# Execute the update command and log output
if eval "$UPDATE_CMD" | tee -a "$LOG_FILE"; then
    echo "Update completed successfully at: $(date)" | tee -a "$LOG_FILE"
else
    echo "Update failed at: $(date)" | tee -a "$LOG_FILE"
    exit 1
fi

echo "----------------------------------------" | tee -a "$LOG_FILE"
