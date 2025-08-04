#!/bin/bash
# start-gui.sh: Start the LightDM display manager if not already running

if systemctl is-active --quiet lightdm; then
    echo "LightDM is already running."
else
    echo "Starting LightDM..."
    sudo systemctl start lightdm
    if [ $? -eq 0 ]; then
        echo "LightDM started successfully."
    else
        echo "Failed to start LightDM. Check system logs for details."
        exit 1
    fi
fi
