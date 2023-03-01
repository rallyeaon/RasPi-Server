#!/bin/bash
#
# download this script using the command:
# wget https://raw.githubusercontent.com/rallyeaon/RasPi-Server/master/setupSamba.sh
#
# function copied from raspi-config  -  it's updating /boot/config.txt

### main body
if [ $(id -u) -ne 0 ]; then
   echo "$0 must run as 'root'"
   echo "restarting with correct permissions"
   sudo -p 'Restarting as root, password: ' bash $0 "$@"
   exit $?
fi

### install samba
apt -y install samba

# add user "josef" to group "sambashare"
usermod -aG sambashare josef

# create a user for Nici to enable her to use samba-shares
adduser cruella --no-create-home --disabled-login --shell /bin/sh --uid 1001
usermod -aG users cruella

# create samba-id & samba-pw for user josef
echo "create samba-user josef"
smbpasswd -a josef

# create samba-id & samba-pw for user cruella
echo "create samba-user cruella"
smbpasswd -a cruella

exit
