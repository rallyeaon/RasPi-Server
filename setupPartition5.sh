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
echo ""
echo ""
echo "If you are 100% sure you want to run this Script and you know what you are doing"
echo "please edit this file and remove/comment the exit-statement right after these messages"

exit

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
DataLabel="NVMeData"

# list partitions on terminal
sudo parted -s "$device" print free unit s print free

# determine size of root-partition. Default is 80G
read -p "Root-partition "$LastSectorP2"s ändern? Bitte die gewünschte Größe eingeben, oder einfach enter: " LastSector
if [[ $LastSector != "" ]] ; then
   LastSectorP2=$LastSector
fi
if echo $LastSectorP2 | egrep -q "^-?[0-9]+$"; then
   echo "Systempartition wird auf ${LastSectorP2}s gesetzt"
else
   echo "Ungülitige (nicht-numerische) Eingabe"
   exit
fi

# check and repair rootfs-filesystem if necessarry
e2fsck -fy "${device}2"

# resize the partition of rootfs
parted $device resizepart 2 "${LastSectorP2}s"

# make sure the rootfs-filesystem is conuming all space available in the partition
resize2fs "${device}2"

# create a data-partition on the remaining space
parted $device mkpart primary ext4 "${StartSectorP3}s" 100%

# create an ext4 filesystem on the new partition
mkfs.ext4 "${device}3"

# create a disk-label "NVMeData"
tune2fs -L $DataLabel "${device}3"

# show the result of the work performed
sudo parted -s "$device" print free unit s print free

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

# add the relevant line at the end of /etc/fstab
su -c "echo '# mount the NVMeData-volume' >> $tempdir/etc/fstab"
su -c "echo 'PARTUUID=$PARTUUID3  /mnt/NVMeData    ext4    defaults         0       2' >> $tempdir/etc/fstab"
su -c "echo '#' >> $tempdir/etc/fstab"

# now let's add the 2TB-HD attached via USB3 to /etc/fstab
su -c "echo '# mount share-volume' >> $tempdir/etc/fstab"
su -c "echo 'PARTUUID=ce5a4333-c0e8-4f38-a3b1-5d9c80c4ec79 /mnt/share  ext4 defaults   0   2' >> $tempdir/etc/fstab"

# now let's create the subdirectories within /mnt for the mount points and set owners where approbiate
if [ ! -d "$tempdir/mnt/share" ]; then
   mkdir $tempdir/mnt/share
fi

if [ ! -d "$tempdir/mnt/NVMeData" ]; then
   mkdir $tempdir/mnt/NVMeData
   mkdir $tempdir/mnt/NVMeData/compose
   mkdir $tempdir/mnt/NVMeData/compose/immich
   mkdir $tempdir/mnt/NVMeData/myopt
   mkdir $tempdir/mnt/NVMeData/myopt/certbot
   mkdir $tempdir/mnt/NVMeData/myopt/fhem
   mkdir $tempdir/mnt/NVMeData/myopt/homeassistant
   mkdir $tempdir/mnt/NVMeData/myopt/immich
   mkdir $tempdir/mnt/NVMeData/myopt/mosquitto
   mkdir $tempdir/mnt/NVMeData/myopt/nginx
   mkdir $tempdir/mnt/NVMeData/myopt/portainer
   mkdir $tempdir/mnt/NVMeData/sepp
   chown 1000:1000 -R /mnt/NVMeData/compose
   chown fhem:dialout -R /mnt/NVMeData/compose/fhem
   chown 1883:1883 -R /mnt/NVMeData/compose/mosquitto
   chown 1000:1000 -R /mnt/NVMeData/myopt
   chown 1000:1000 -R /mnt/NVMeData/sepp
fi

# SonosSpeak remains on /mnt for historical reasons but is planned to be moved to /mnt/NVMeData
if [ ! -d "$tempdir/mnt/SonosSpeak" ]; then
   mkdir $tempdir/mnt/SonosSpeak
fi

# boot-devise no longer needed, therefore unmount it from our system and remove temporary directory
umount /dev/sdb2
rm -r $tempdir

exit
