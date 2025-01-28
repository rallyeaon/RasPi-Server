#!/bin/bash
#
# download this script using the command:
# wget https://github.com/rallyeaon/RasPi-Server/raw/main/re-setupPartition.sh
#
device="/dev/sdb"
StartSectorP3=156250112
LastSectorP2=$((StartSectorP3 - 1))
echo "This script will re-create the data-partition of the previousely used but"
echo "newly flashed Raspberian-OS lite on the NVMe 500GB SSD."
echo "The StartSector of the data-partition is assumed as "$startsector" and the partition"
echo "will use all remaining space on "$device"."
echo "Furthermore the tiny root-partition will be expanded to provide as much as possible space"

if [ $(id -u) -ne 0 ]; then
   echo "$0 must run as 'root'"
   echo "restarting with correct permissions"
   sudo -p 'Restarting as root, password: ' bash $0 "$@"
   exit $?
fi

# LastSectorP3=`parted -s /dev/sdb unit s print --json | jq '.disk.partitions[]  | select(.number==3).start'`

# print partitions on terminal
echo "Modifying below device:"
parted -s "$device" print free unit s print free

echo $LastSectorP2 $StartSectorP3

read -r -p "Do you want to continue? [y/N] " response
response=${response,,}
if [[ "$response" =~ ^(yes|y)$ ]]
then
  :
else
  exit
fi

# create data-partition starting on sector $startsector allocating the remaining space
parted $device mkpart primary ext4 "${StartSectorP3}s" 100%

# check if the label "NVMeData" is found - this is an indicator the data-partition has
# been restored successfully
blkid | if [ $(grep -c "NVMeData") -eq 0 ]
then
    echo "Something went wrong - LABEL NVMeData not found"
    exit
fi

# print output of blkid & partitions on terminal
blkid | grep NVMeData
parted -s "$device" print free unit s print free
echo "alles bestens"

# check and repair rootfs-filesystem if necessarry
e2fsck -fy "${device}2"

# resize the rootfs-filesystem to the new size
# resize2fs "${device}2" "${RootFsSize}G"

# resize the partition of rootfs
parted $device resizepart 2 "${LastSectorP2}s"

# make sure the rootfs-filesystem is conuming all space available in the partition
resize2fs "${device}2"

# show the result of the work performed
parted -s "$device" print free unit s print free
exit
