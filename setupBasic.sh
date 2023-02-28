#!/bin/sh
# run this Script as root https://www.linuxjournal.com/content/automatically-re>

# function copied from raspi-config  -  it's updating /boot/config.txt
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

### main body
if [ $(id -u) -ne 0 ]; then
   echo "$0 must run as 'root'"
   echo "restarting with correct permissions"
   sudo -p 'Restarting as root, password: ' bash $0 "$@"
   exit $?
fi

### Start Script
PACKAGE_LANG=(en_US.UTF-8 de_DE.UTF-8) # the first is fallback in LANGUAGE, the>

# first load the latest software
apt -y update
apt -y full-upgrade

# config the default language, raspi-config is this doing in a similar way
for lang in ${PACKAGE_LANG[*]}; do sed -i -e "s/# $lang/$lang/" /etc/locale.gen>
dpkg-reconfigure -f noninteractive locales     # ? locale-gen
update-locale LANG=${PACKAGE_LANG[-1]} LANGUAGE=${PACKAGE_LANG[-1]:0:2}:${PACKA>

# set GPU-Memory to 1GB as no GPU is needed in this RasPi
if [ -e /boot/start_cd.elf ]; then
    NEW_GPU_MEM=1
    set_config_var gpu_mem "$NEW_GPU_MEM" /boot/config.txt
fi

# as the RasPi doesn't have a system-clock let's install ntpdata
apt -y install ntpdate

# rpi-update shouldn't be part of regular maintenance but may be part when re-i>
rpi-update

# Reboot
echo "Ein reboot ist empfohlen!"
