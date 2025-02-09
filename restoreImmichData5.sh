#!/bin/bash
#
# download this script using the command:
# wget https://github.com/rallyeaon/RasPi-Server/raw/main/restoreHAData5.sh
#
# receive .env secret-file from backup and update-script for immich
#
if [ $(id -u) -eq 0 ]; then
   echo "$0 must not run as 'root'"
   echo "please restart with correct permissions"
   exit
fi
#
Remote=sepp@RasPi-Backup
RecoveryPath=/mnt/NVMeData/compose/immich/.env
RemotePath=/mnt/BackupDevice/RasPi5-Server$RecoveryPath

# retrieve a local copy of the .env configuration file
rsync -4auv $Remote:$RemotePath $RecoveryPath

# retrieve a local copy of the immich_upd configuration file
RecoveryPath=/mnt/NVMeData/compose/immich/immich_upd
rsync -4auv $Remote:$RemotePath $RecoveryPath


exit
