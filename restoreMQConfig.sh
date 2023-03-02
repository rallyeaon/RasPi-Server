#!/bin/bash
#
# download this script using the command:
# wget https://raw.githubusercontent.com/rallyeaon/RasPi-Server/master/restoreMQConfig.sh
#
#
# get all filenames of mosquitto-config-Backups into the array
# the filenames correspond to the nomenclature MQ-<yyymmdd>_<hhmmss>.tar.gz
#
if [ $(id -u) -eq 0 ]; then
   echo "$0 must not run as 'root'"
   echo "please restart with correct permissions"
   exit
fi
#
RecoveryPath=/opt/mosquitto
BackupPath=/mnt/BackupDevice/RasPi-Server/opt/mosquitto/backup

numbers=( $(ssh josef@RasPi-Backup ls $BackupPath | grep .tar.gz) )

# initialize most_recent with first entry in array
most_recent=${numbers[0]}

# walk thru the array to find the youngest/most recent backup
for (( i=0; i<${#numbers[@]}; i++ )); do
    if [[ "$most_recent" < "${numbers[i]}" ]]; then
       most_recent=${numbers[i]};
    fi
done
echo "most recent backup is named"
echo $BackupPath/$most_recent

# retrieve a local copy of the most recent mosquitto-conf-Backup
rsync -auv --owner --numeric-ids --group --super josef@RasPi-Backup:$BackupPath/$most_recent /home/josef/

# untar the mosquitto-configBackup 
if [ ! -d "$RecoveryPath" ]; then
   sudo mkdir $RecoveryPath
fi
sudo tar -xzf /home/josef/$most_recent -C /

printf "%s\n" "${lines[@]}"
