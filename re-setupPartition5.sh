#!/bin/bash
#
# download this script using the command:
# wget https://raw.githubusercontent.com/rallyeaon/RasPi-Server/refs/heads/main/re-setupPartition5.sh
#
echo "This script will re-create the data-partition of the previousely used but"
echo "newly flashed Raspberian-OS lite on my NVMe 500GB SSD."
echo "The StartSector of the data-partition is assumed as "$startsector" and the partition"
echo "will use all remaining space on "$device". Please make sure $startsector is identical"
echo " to the startsector of the data-partition in the previous installation - otherwise"
echo "recovery will fail and data are lost"
echo "Furthermore the tiny root-partition will be expanded to provide as much as possible space"

if [ $(id -u) -ne 0 ]; then
   echo "$0 must run as 'root'"
   echo "restarting with correct permissions"
   sudo -p 'Restarting as root, password: ' bash $0 "$@"
   exit $?
fi

# initialize parameters
device="/dev/sdb"
StartSectorP3=156250112
LastSectorP2=$((StartSectorP3 - 1))

# print partitions on terminal
echo "Modifying below device:"
parted -s "$device" print free unit s print free

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

# Let's add NVMeData and the Share-volume to /etc/fstab to ensure it will be mounted on every boot process:
# Get name of PARTUUID3 (the data-volume NVMeData)
PARTUUID3=$(blkid -o value -s PARTUUID /dev/sdb3)

#create a temporary directory to provide a mount-point for the new root-volume

tempdir=$(mktemp -d)

# mount the root-volume to this mount-point
mount /dev/sdb2 $tempdir

# create a backup of /etc/fstab
cp -v $tempdir/etc/fstab $tempdir/etc/fstab.ok

# add the relevant line at the end of /etc/fstab
su -c "echo '# mount the NVMeData-volume' >> $tempdir/etc/fstab"
su -c "echo 'PARTUUID=$PARTUUID3  /mnt/NVMeData    ext4    defaults         0       2' >> $tempdir/etc/fstab"
su -c "echo '#' >> $tempdir/etc/fstab"

# now let's add the 2TB-HD attached via USB3 to /etc/fstab
su -c "echo '# mount share-volume' >> $tempdir/etc/fstab"
su -c "echo 'PARTUUID=ce5a4333-c0e8-4f38-a3b1-5d9c80c4ec79 /mnt/share  ext4 defaults   0   2' >> $tempdir/etc/fstab"

# now let's create the subdirectories within /mnt for the mount points
if [ ! -d "$tempdir/mnt/share" ]; then
   mkdir $tempdir/mnt/share
fi

if [ ! -d "$tempdir/mnt/NVMeData" ]; then
   mkdir $tempdir/mnt/NVMeData
fi

# SonosSpeak remains on /mnt for historical reasons but is planned to be moved to /mnt/NVMeData
if [ ! -d "$tempdir/mnt/SonosSpeak" ]; then
   mkdir $tempdir/mnt/SonosSpeak
fi

# boot-devise no longer needed, therefore unmount it from our system and remove temporary directory
umount /dev/sdb2
rm -r $tempdir

exit
