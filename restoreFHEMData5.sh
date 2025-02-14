#!/bin/bash
#
# download this script using the command:
# wget https://github.com/rallyeaon/RasPi-Server/raw/main/restoreFHEMData5.sh
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
Remote=josef@RasPi-Backup
RecoveryPath=/opt/fhem
RemotePath=/mnt/BackupDevice/RasPi-Server$RecoveryPath/backup

numbers=( $(ssh $Remote ls $RemotePath | grep .tar.gz) )

# initialize most_recent with first entry in array
most_recent=${numbers[0]}
#
if [[ "$most_recent" != FHEM-*.tar.gz ]]; then
   echo "No FHEM-backup found on $Remote:$RemotePath"
   exit
fi

# walk thru the array to find the youngest/most recent backup
for (( i=0; i<${#numbers[@]}; i++ )); do
    if [[ "$most_recent" < "${numbers[i]}" ]]; then
       most_recent=${numbers[i]};
    fi
done
echo "most recent backup is named"
echo $RemotePath/$most_recent

# retrieve a local copy of the most recent FHEM-Backup
rsync -4auv $Remote:$RemotePath/$most_recent .

# untar the FHEMBackup 
sudo tar -xvzf $most_recent -C ${RecoveryPath}/

# clean-up disk
rm $most_recent

exit
