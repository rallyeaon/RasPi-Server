#!/bin/bash
#
# download this script using the command:
# wget https://raw.githubusercontent.com/rallyeaon/RasPi-Server/master/restoreHASSData.sh
#
#
# get all filenames of HomeAssistant-Backups into the array
# the filenames correspond to the nomenclature HA-<yyymmdd>_<hhmmss>.tar.gz
#
if [ $(id -u) -eq 0 ]; then
   echo "$0 must not run as 'root'"
   echo "please restart with correct permissions"
   exit
fi
#
RecoveryPath=/opt/homeassistant
BackupPath=/mnt/BackupDevice/RasPi-Server/opt/homeassistant/backup

numbers=( $(ssh josef@192.168.57.32 ls $BackupPath | grep .tar.gz) )

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

# retrieve a local copy of the most recent Home Assistant-Backup
rsync -auv --owner --numeric-ids --group --super josef@192.168.57.32:$BackupPath/$most_recent /home/josef/

# untar the HomeAssistantBackup 
if [ ! -d "$RecoveryPath" ]; then
   sudo mkdir $RecoveryPath
fi
sudo tar -xvzf /home/josef/$most_recent -C /

printf "%s\n" "${lines[@]}"

