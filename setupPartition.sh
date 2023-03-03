#!/bin/bash
#
# download this script using the command:
# wget https://github.com/rallyeaon/RasPi-Server/blob/main/setupPartition.sh
#
device="/dev/sdb"
echo "This script will resize the partition of an already booted but not"
echo "modified Raspberian which allocates the full M2"
echo "The size of the boot-partition (rootfs) will be set to your convenience"
echo "however, please make sure this script assumes the device to be modified"
echo "is accessible under "$device". If this is not the case, please modify"
echo "this script to your needs"

if [ $(id -u) -ne 0 ]; then
   echo "$0 must run as 'root'"
   echo "restarting with correct permissions"
   sudo -p 'Restarting as root, password: ' bash $0 "$@"
   exit $?
fi

# list partitions on terminal
parted -l

# determine size of root-partition. Default is 64G
RootFsSize=64
read -p "Root-partition "$RootFsSize"G ändern? Bitte die gewünschte Größe eingeben, oder einfach enter: " RootSize
if [[ $RootSize != "" ]] ; then
   RootFsSize=$RootSize
fi
if echo $RootFsSize | egrep -q "^-?[0-9]+$"; then 
   echo "Systempartition wird auf ${RootFsSize}G gesetzt"
else
   echo "Ungülitige (nicht-numerische) Eingabe"
   exit
fi

# check and repair rootfs-filesystem if necessarry
e2fsck -fy "${device}2"

# resize the rottfs-filesystem to the new size
resize2fs "${device}2" "${RootFsSize}G"

# resize the partition of rootfs
parted $device resizepart 2 "${RootFsSize}G"

# make sure the rootfs-filesystem is conuming all space available in the partition
resize2fs "${device}2"

# create a data-partition on the remaining space
parted $device  mkpart primary ext4 "${RootFsSize}G" 100%

# create an ext4 filesystem on the new partition
mkfs.ext4 "${device}3"

# create a disk-label  "M2Data"
tune2fs -L M2Data "${device}3"

# show the result of the work performed
parted -l
exit
