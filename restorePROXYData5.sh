#!/bin/bash
#
# This script restores configuration data for NGINX and LETSENCRYPT for my Raspi-Backup
#
# download this script using the command:
# wget https://raw.githubusercontent.com/rallyeaon/RasPi-Server/refs/heads/main/restorePROXYData5.sh
#
if (( $EUID != 0 )); then
   echo "$0 must run as 'root'"
   echo "please restart with correct permissions"
   exit
fi
#
Remote=sepp@RasPi-Backup
RecoveryPath=/opt/certbot
RemotePath=/mnt/BackupDevice/RasPi-Server$RecoveryPath

# retrieve a local copy of the most recent FHEM-Backup
rsync -4auv --rsync-path="sudo rsync" $Remote:$RemotePath /opt


RecoveryPath=/opt/nginx
RemotePath=/mnt/BackupDevice/RasPi-Server$RecoveryPath

# retrieve a local copy of the most recent FHEM-Backup
rsync -4auv --rsync-path="sudo rsync" $Remote:$RemotePath /opt

exit
