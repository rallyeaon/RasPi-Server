#!/bin/bash
#
# download this script using the command:
# wget https://raw.githubusercontent.com/rallyeaon/RasPi-Server/refs/heads/main/setupPartition5.sh
#
echo "This script is to be used on a brand-new or as brand-new considered device (NVMe)"
echo "for a RaspBerry5 as boot-device flased the first time with a Raspberian OS"
echo "As this usually is oversized a 3rd partition will be allocated at the end of the"
echo "device leaving some 80GB by default for Rasperian OS. The size fpr root-partition"
echo "can be changed during installation process at your convenience"
echo "The modified device mus be available as "$device". If this is not the case, please"
echo "modify this script to your needs"

if [ $(id -u) -ne 0 ]; then
   echo "$0 must run as 'root'"
   echo "restarting with correct permissions"
   sudo -p 'Restarting as root, password: ' bash $0 "$@"
   exit $?
fi

# initialize parameters
device="/dev/sdb"
RootFsSize=80
DataLabel="NVMeData"

# list partitions on terminal
sudo parted -s "$device" print free unit s print free

# determine size of root-partition. Default is 80G
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

# create a disk-label "NVMeData"
tune2fs -L $DataLabel "${device}3"

# show the result of the work performed
sudo parted -s "$device" print free unit s print free
exit
