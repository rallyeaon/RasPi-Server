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
RecoveryPath=/mnt/NVMeData/myopt/certbot
RemotePath=/mnt/BackupDevice/RasPi5-Server$RecoveryPath

# retrieve a local copy of letsencrypt data
rsync -4auv --rsync-path="sudo rsync" $Remote:$RemotePath $RecoveryPath


RecoveryPath=/mnt/NVMeData/myopt/nginx
RemotePath=/mnt/BackupDevice/RasPi5-Server$RecoveryPath

# retrieve a local copy of nginx data
rsync -4auv --rsync-path="sudo rsync" $Remote:$RemotePath $RecoveryPath

exit
