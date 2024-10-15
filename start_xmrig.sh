#!/bin/bash

# Update package list and install dependencies
echo "Updating package list..."
apt-get update

echo "Installing necessary packages..."
apt-get install -y git build-essential cmake libuv1-dev libssl-dev libhwloc-dev curl

# Clone the XMRig repository if it doesn't already exist
if [ ! -d "xmrig" ]; then
    echo "Cloning XMRig repository..."
    git clone https://github.com/xmrig/xmrig.git
fi

# Change to the XMRig directory
cd xmrig

# Create build directory if it doesn't exist
if [ ! -d "build" ]; then
    echo "Creating build directory..."
    mkdir build
fi

cd build

# Run cmake to configure the build
echo "Configuring XMRig..."
cmake ..

# Compile XMRig
echo "Building XMRig..."
make

# Download the specific config.json file
CONFIG_URL="https://raw.githubusercontent.com/orkaroeli/orkaroeliminer/e2bec3ba85277842965533fe92734b069605f324/config.json"
echo "Downloading config.json..."
curl -L -o ../config.json $CONFIG_URL

# Check if config.json was downloaded successfully
if [ ! -f "../config.json" ]; then
    echo "Failed to download config.json!"
    exit 1
fi

# Run XMRig
echo "Starting XMRig..."
chmod +x xmrig
./xmrig --config=../config.json
