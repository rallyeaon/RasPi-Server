#!/bin/bash
#
# download this script using the command:
# wget https://raw.githubusercontent.com/rallyeaon/RasPi-Server/refs/heads/main/restoreImmichData5.sh
#
# This script performs the basic installation of FHEM (bare metal)
# Attention: in case you run the script multiple times (for whatever reason) clean-up /etc/apt/sources.list from multiple identical entries
#
if [ $(id -u) -eq 0 ]; then
   echo "$0 must not run as 'root'"
   echo "please restart with correct permissions"
   exit
fi
#
# the following commands MUST be executed as root using "sudo su"
#
sudo su <<EOF
wget -O- https://debian.fhem.de/archive.key | gpg --dearmor > /usr/share/keyrings/debianfhemde-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/debianfhemde-archive-keyring.gpg] https://debian.fhem.de/nightly/ /" >> /etc/apt/sources.list
apt update
apt install -y fhem
EOF
exit
