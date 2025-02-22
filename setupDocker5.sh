#!/bin/bash
#
# download this script using the command:
# wget https://github.com/rallyeaon/RasPi-Server/raw/main/setupDocker5.sh
#
#
#
if [ $(id -u) -eq 0 ]; then
   echo "$0 must not run as 'root'"
   echo "please restart with correct permissions"
   exit
fi
#
# make sure the system ist up-to-date
sudo apt update && sudo apt-get upgrade -y

# receive official installation script and make it executable
curl -fsSL https://get.docker.com -o get-docker.sh
chmod 755 get-docker.sh

# install docker
sudo sh get-docker.sh

# add my user to group docker
sudo usermod -aG docker $USER

# display installed version of docker
docker -v

# create volume for protainer_data
if [ ! -d "/mnt/NVMeData/myopt/portainer" ]; then
   sudo mkdir /mnt/NVMeData/myopt/portainer
fi

if [ ! -d "/mnt/NVMeData/myopt/portainer/data" ]; then
   sudo mkdir /mnt/NVMeData/myopt/portainer/data
fi

