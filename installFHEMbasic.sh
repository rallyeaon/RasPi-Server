#!/bin/bash
#
# download this script using the command:
# wget https://raw.githubusercontent.com/rallyeaon/RasPi-Server/refs/heads/main/installFHEMbasic.sh
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
# for FHEMpy below modules are to be installed
sudo apt install -y python3 python3-pip python3-dev python3-venv libffi-dev libssl-dev libjpeg-dev zlib1g-dev autoconf build-essential libglib2.0-dev libdbus-1-dev bluez libbluetooth-dev git libprotocol-websocket-perl

# install prerequisites for FritzBox-access
sudo apt install -y libjson-perl libwww-perl libsoap-lite-perl libjson-xs-perl

# install prerequisites for Denon-AVR
sudo apt -y install libxml-simple-perl libnet-telnet-perl

# install prerequisites for alexa-fhem
sudo apt install -y nodejs npm
# show version of nodejs
node --version
# now let's install alexa-fhem from official repository
sudo npm install -g alexa-fhem
# clean-up

# install modules for Sonos TextToSpeech
sudo apt install -y mp3wrap

# install modules for SolarForecast & AI support
sudo apt install -y libdatetime-perl libdatetime-format-strptime-perl libai-decisiontree-perl
sudo apt -y autoremove
exit
