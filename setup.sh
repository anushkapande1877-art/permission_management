#!/bin/bash

echo "Creating company directories..."
mkdir -p /opt/company/projects
mkdir -p /opt/company/confidentials

echo "Creating groups..."
groupadd manager 2>/dev/null
groupadd developer 2>/dev/null
groupadd intern 2>/dev/null

echo "Creating users..."
id m1 &>/dev/null || useradd -m m1
id d1 &>/dev/null || useradd -m d1
id i1 &>/dev/null || useradd -m i1

echo "Assigning users to groups..."
usermod -aG manager m1
usermod -aG developer d1
usermod -aG intern i1

echo "Configuring projects directory..."
chown root:developer /opt/company/projects
chmod 770 /opt/company/projects

setfacl -m g:manager:rwx /opt/company/projects
setfacl -m g:intern:r-x /opt/company/projects

echo "Configuring confidentials directory..."
chown root:manager /opt/company/confidentials
chmod 770 /opt/company/confidentials

echo "Setup Complete!"
