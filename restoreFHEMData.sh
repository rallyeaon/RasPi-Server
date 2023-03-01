#!/bin/bash
# run this Script as root https://www.linuxjournal.com/content/automatically-re-start-script-root-0
#
# download this script using the command:
# wget https://raw.githubusercontent.com/rallyeaon/RasPi-Server/master/restoreFHEMData.sh
#
#
# get all filenames of FHEM-Backups into the array
# the filenames correspond to the nomenclature FHEM-<yyymmdd>_<hhmmss>.tar.gz
#
if [ $(id -u) -eq 0 ]; then
   echo "$0 must not run as 'root'"
   echo "please restart with correct permissions"
   exit
fi
#
RecoveryPath=/opt/fhemdocker
BackupPath=/mnt/BackupDevice/RasPi-Server/opt/fhemdocker/backup

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

# retrieve a local copy of the most recent FHEM-Backup
rsync -auv --owner --numeric-ids --group --super josef@192.168.57.32:$BackupPath/$most_recent /home/josef/

# untar the FHEMBackup 
if [ ! -d "$RecoveryPath" ]; then
   sudo mkdir $RecoveryPath
fi
sudo tar -xvzf /home/josef/$most_recent -C ${RecoveryPath}/


printf "%s\n" "${lines[@]}"
