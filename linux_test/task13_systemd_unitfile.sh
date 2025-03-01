#!/bin/bash

# Check if the correct number of arguments is passed
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <python_script_path> <service_name>"
    exit 1
fi

# Assign input arguments to variables
PYTHON_SCRIPT=$1
SERVICE_NAME=$2
UNIT_FILE="/etc/systemd/system/$SERVICE_NAME.service"

# Check if the Python script exists
if [ ! -f "$PYTHON_SCRIPT" ]; then
    echo "Error: Python script $PYTHON_SCRIPT does not exist."
    exit 1
fi

# Create the systemd service unit file
echo "Creating systemd unit file at $UNIT_FILE"

cat > $UNIT_FILE <<EOL
[Unit]
Description=Python Script Service - $SERVICE_NAME
After=network.target

[Service]
ExecStart=/usr/bin/python3 $PYTHON_SCRIPT
WorkingDirectory=$(dirname "$PYTHON_SCRIPT")
Restart=always
User=$(whoami)
Group=$(whoami)

[Install]
WantedBy=multi-user.target
EOL

# Reload systemd to recognize the new service
echo "Reloading systemd..."
systemctl daemon-reload

# Enable the service to start on boot
echo "Enabling service to start on boot..."
systemctl enable $SERVICE_NAME.service

# Start the service
echo "Starting the service..."
systemctl start $SERVICE_NAME.service

echo "Service $SERVICE_NAME created and started successfully."
exit 0
