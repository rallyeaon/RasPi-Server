#!/bin/bash
# run this Script as root https://www.linuxjournal.com/content/automatically-re-start-script-root-0
#
# download this script using the command:
# wget https://github.com/rallyeaon/RasPi-Server/raw/main/setupBasic5.sh
#
# function copied from raspi-config  -  it's updating /boot/config.txt

### main body
if [ $(id -u) -ne 0 ]; then
   echo "$0 must run as 'root'"
   echo "restarting with correct permissions"
   sudo -p 'Restarting as root, password: ' bash $0 "$@"
   exit $?
fi

### Start Script

# first load the latest software
apt -y update
apt -y full-upgrade

# config the default language, call raspi-config in background to perform this task
raspi-config nonint do_change_locale de_AT.UTF-8

# backup /etc/fstab
cp /etc/fstab /etc/fstab.ok

if [ ! -d "/mnt/share" ]; then
   mkdir /mnt/share
fi

if [ ! -d "/mnt/SonosSpeak" ]; then
   mkdir /mnt/SonosSpeak
fi
# add myself to group dialout - recommended for Phoscon
sudo usermod -aG dialout $USER

# Reboot
echo "A reboot is strongly recommended"

exit 0

# das ist für die Implementierung von PCI Gen 3 Support - kopiert aus 

if [ -e /boot/firmware/config.txt ] ; then
  FIRMWARE=/firmware
else
  FIRMWARE=
fi
CONFIG=/boot${FIRMWARE}/config.txt

set_config_var() {
  lua - "$1" "$2" "$3" <<EOF > "$3.bak"
local key=assert(arg[1])
local value=assert(arg[2])
local fn=assert(arg[3])
local file=assert(io.open(fn))
local made_change=false
for line in file:lines() do
  if line:match("^#?%s*"..key.."=.*$") then
    line=key.."="..value
    made_change=true
  end
  print(line)
end

if not made_change then
  print(key.."="..value)
end
EOF
mv "$3.bak" "$3"
}

get_pci() {
  if grep -q -E "^dtparam=pciex1_gen=3$" $CONFIG; then
    echo 0
  else
    echo 1
  fi
}

do_pci() {
  DEFAULT=--defaultno
  CURRENT=1
  if [ $(get_pci) -eq 0 ]; then
    DEFAULT=
    CURRENT=0
  fi
  if [ "$INTERACTIVE" = True ]; then
    whiptail --yesno "Would you like PCIe Gen 3 to be enabled?" $DEFAULT 20 60 2
    RET=$?
  else
    RET=$1
  fi
  if [ $RET -eq 0 ]; then
    set_config_var dtparam=pciex1_gen 3 $CONFIG
    STATUS=enabled
  elif [ $RET -eq 1 ]; then
    clear_config_var dtparam=pciex1_gen $CONFIG
    STATUS=disabled
  else
    return $RET
  fi
  if [ $RET -ne $CURRENT ]; then
    ASK_TO_REBOOT=1
  fi

  if [ "$INTERACTIVE" = True ]; then
    whiptail --msgbox "PCIe Gen 3 is $STATUS" 20 60 1
  fi
}


