#!/bin/bash
#
# download this script using the command:
# wget https://github.com/rallyeaon/RasPi-Server/blob/main/setupSamba.sh
#
# function copied from raspi-config  -  it's updating /boot/config.txt

### main body
if [ $(id -u) -eq 0 ]; then
   echo "$0 must not run as 'root'"
   echo "please restart with correct permissions"
   exit
fi
#

### install samba
sudo apt -y install samba

# add user "josef" to group "sambashare"
sudo usermod -aG sambashare josef

# create a user for Nici to enable her to use samba-shares
sudo adduser cruella --no-create-home --disabled-login --shell /bin/sh --uid 1001
sudo usermod -aG users cruella

# create samba-id & samba-pw for user josef
echo "create samba-user josef"
sudo smbpasswd -a josef

# create samba-id & samba-pw for user cruella
echo "create samba-user cruella"
sudo smbpasswd -a cruella

# recover smb-configuration from remote backup-host
Remote=josef@RasPi-Backup
RemotePath=/mnt/BackupDevice/RasPi-Server
Path=/etc/samba/
Filename=smb.conf
if ! ssh $Remote "test -e $RemotePath$Path$Filename" 2> /dev/null; then
   echo "No backupfile $Filename found - exiting"
   exit
fi

# restore smb.conf to caller's home
rsync -auq --owner --numeric-ids --group --super $Remote:$RemotePath$Path$Filename .

# move to target
sudo mv $Filename $Path$Filename

# test configuration
testparm

# restart samba to tage changes into effect
sudo systemctl restart smbd.service

exit
