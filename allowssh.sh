#!/bin/bash

sudo apt update
sudo apt install openssh-server
sudo systemctl start ssh
sudo apt install ufw
sudo systemctl enable ssh
sudo ufw allow ssh
sudo ufw allow 22
sudo ufw reload

hostname -I
