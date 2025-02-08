#!/bin/bash
#
# download this script using the command:
# wget https://raw.githubusercontent.com/rallyeaon/RasPi-Server/refs/heads/main/restoreCERTData5.sh
#
if [ $(id -u) -eq 0 ]; then
   echo "$0 must not run as 'root'"
   echo "please restart with correct permissions"
   exit
fi
#
Remote=sepp@RasPi-Backup
RecoveryPath=/opt/cert
RemotePath=/mnt/BackupDevice/RasPi-Server$RecoveryPath

# retrieve a local copy of the most recent FHEM-Backup
rsync -4auv --owner --numeric-ids --group --super $Remote:$RemotePath $RecoveryPath

exit
