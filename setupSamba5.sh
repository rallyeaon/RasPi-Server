#!/bin/bash
#
# download this script using the command:
# wget https://github.com/rallyeaon/RasPi-Server/raw/main/setupSamba5.sh
#
# function copied from raspi-config  -  it's updating /boot/config.txt

### main body
if [ $(id -u) -eq 0 ]; then
   echo "$0 must not run as 'root'"
   echo "please restart with correct permissions"
   exit
fi
#

setupNici=false

### install samba
sudo apt -y install samba

# add user "josef" to group "sambashare"
sudo usermod -aG sambashare sepp

# create samba-id & samba-pw for user josef
echo "create samba-user sepp"
sudo smbpasswd -a sepp

# create a user for Nici to enable her to use samba-shares
if [[ $setupNici = "true" ]] ; then
   sudo adduser nici --no-create-home --disabled-login --shell /bin/sh --uid 1001
   sudo usermod -aG users nici
   
   # create samba-id & samba-pw for user cruella
   echo "create samba-user cruella"
   sudo smbpasswd -a nici
fi

# recover smb-configuration from remote backup-host
Remote=josef@RasPi-Backup
RemotePath=/mnt/BackupDevice/RasPi-Server
Path=/etc/samba/
Filename=smb.conf

if ! ssh $Remote "test -e $RemotePath$Path$Filename"; then
    echo "$RemotePath$Path$Filename am Remote-Host nicht gefunden"
    exit
fi

# restore smb.conf to caller's home
echo rsync -4auqv --owner --numeric-ids --group --super $Remote:$RemotePath$Path$Filename $Path$Filename
rsync -4auqv --owner --numeric-ids --group --super $Remote:$RemotePath$Path$Filename .

# move to target
sudo mv $Filename $Path$Filename

# test configuration
testparm -s

# restart samba to tage changes into effect
sudo systemctl restart smbd.service

exit
