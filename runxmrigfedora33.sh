#!/bin/bash

# Update the package list
sudo dnf update -y

# Set the required packages URLs
GCC_CXX_URL="https://download.fedoraproject.org/pub/fedora/linux/releases/33/Everything/x86_64/os/Packages/g/gcc-c++-10.2.1-9.fc33.x86_64.rpm"
CMAKE_URL="https://download.fedoraproject.org/pub/fedora/linux/releases/33/Everything/x86_64/os/Packages/c/cmake-3.18.4-5.fc33.x86_64.rpm"
LIBUV_DEV_URL="https://download.fedoraproject.org/pub/fedora/linux/releases/33/Everything/x86_64/os/Packages/l/libuv-devel-1.40.0-1.fc33.x86_64.rpm"
OPENSSL_DEV_URL="https://download.fedoraproject.org/pub/fedora/linux/releases/33/Everything/x86_64/os/Packages/o/openssl-devel-1:1.1.1g-10.fc33.x86_64.rpm"
WGET_URL="https://download.fedoraproject.org/pub/fedora/linux/releases/33/Everything/x86_64/os/Packages/w/wget-1.21-1.fc33.x86_64.rpm"

# Download required dependencies using wget
wget $GCC_CXX_URL
wget $CMAKE_URL
wget $LIBUV_DEV_URL
wget $OPENSSL_DEV_URL
wget $WGET_URL

# Install downloaded RPM packages
sudo dnf localinstall -y gcc-c++-10.2.1-9.fc33.x86_64.rpm \
    cmake-3.18.4-5.fc33.x86_64.rpm \
    libuv-devel-1.40.0-1.fc33.x86_64.rpm \
    openssl-devel-1:1.1.1g-10.fc33.x86_64.rpm \
    wget-1.21-1.fc33.x86_64.rpm

# Download and install xmrig
XMRIG_VERSION="6.15.1"
XMRIG_URL="https://github.com/xmrig/xmrig/releases/download/v${XMRIG_VERSION}/xmrig-${XMRIG_VERSION}-linux-x86_64.tar.gz"

# Download xmrig
wget ${XMRIG_URL} -O xmrig.tar.gz

# Extract the archive
tar xvf xmrig.tar.gz

# Navigate to the extracted directory
cd xmrig-${XMRIG_VERSION}

# Create a new config if not already present
if [ ! -f config.json ]; then
    cp config.json.example config.json  # Use the example config as a template
fi

# Set your mining pool and user details here
POOL_URL="168.235.86.33:3393"  # Replace with your mining pool address
WALLET_USER="SK_QzApkbVGsAxyQykaWSnEF.rafaelftn"  # Replace with your wallet address
PASSWORD="x"  # You can replace this with your desired password or leave it as is

# Create a new config.json with the specified structure
cat <<EOL > config.json
{
    "autosave": true,
    "donate-level": 1,
    "cpu": {
        "enabled": true,
        "huge-pages": true,
        "hw-aes": null,
        "priority": null,
        "asm": true,
        "max-threads-hint": 100,
        "max-cpu-usage": 100,
        "yield": false,
        "init": -1,
        "*": {
            "intensity": 2,
            "threads": 8,
            "affinity": -1
        }
    },
    "opencl": true,
    "cuda": true,
    "pools": [{
        "coin": null,
        "algo": "cn/ccx",
        "url": "$POOL_URL",
        "user": "$WALLET_USER",
        "pass": "$PASSWORD",
        "keepalive": false,
        "nicehash": false,
        "rig-id": null,
        "enabled": true,
        "tls": false,
        "sni": false,
        "tls-fingerprint": null,
        "daemon": false,
        "socks5": null,
        "self-select": null,
        "submit-to-origin": false
    }]
}
EOL

# Run xmrig
./xmrig
