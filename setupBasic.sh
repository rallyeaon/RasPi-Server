#!/bin/bash
# run this Script as root https://www.linuxjournal.com/content/automatically-re-start-script-root-0
#
# download this script using the command:
# wget https://raw.githubusercontent.com/rallyeaon/RasPi-Server/master/setupBasic.sh
#
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
PACKAGE_LANG=(en_US.UTF-8 de_DE.UTF-8) # the first is fallback in LANGUAGE, the last is set to default

# first load the latest software
apt -y update
apt -y full-upgrade

# config the default language, raspi-config is this doing in a similar way
for lang in ${PACKAGE_LANG[*]}; do sed -i -e "s/# $lang/$lang/" /etc/locale.gen; done 
dpkg-reconfigure -f noninteractive locales     # ? locale-gen
update-locale LANG=${PACKAGE_LANG[-1]} LANGUAGE=${PACKAGE_LANG[-1]:0:2}:${PACKAGE_LANG[0]:0:2}

# set GPU-Memory to 1GB as no GPU is needed in this RasPi
if [ -e /boot/start_cd.elf ]; then
    NEW_GPU_MEM=1
    set_config_var gpu_mem "$NEW_GPU_MEM" /boot/config.txt
fi

# as the RasPi doesn't have a system-clock let's install ntpdata
apt -y install ntpdate

# backup /etc/fstab
cp /etc/fstab /etc/fstab.ok

Last login: Wed Mar  1 08:36:53 on console
josef@Josefs-Mac-mini ~ % ssh josef@192.168.57.34
josef@192.168.57.34's password: 
Linux RasPi-Testsystem 5.15.84-v8+ #1613 SMP PREEMPT Thu Jan 5 12:03:08 GMT 2023 aarch64

The programs included with the Debian GNU/Linux system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Debian GNU/Linux comes with ABSOLUTELY NO WARRANTY, to the extent
permitted by applicable law.
Last login: Tue Feb 28 19:06:13 2023 from 192.168.57.103
josef@RasPi-Testsystem:~ $ ls
setupBasic.sh
josef@RasPi-Testsystem:~ $ nano setupBasic.sh 
josef@RasPi-Testsystem:~ $ nano setupBasic.sh 
josef@RasPi-Testsystem:~ $ nano setupBasic.sh 
josef@RasPi-Testsystem:~ $ nano setupBasic.sh 
josef@RasPi-Testsystem:~ $ ./setupBasic.sh 
./setupBasic.sh must run as 'root'
josef@RasPi-Testsystem:~ $ sudo ./setupBasic.sh 
./setupBasic.sh: 40: Syntax error: "(" unexpected
josef@RasPi-Testsystem:~ $ nano setupBasic.sh 
josef@RasPi-Testsystem:~ $ sudo ./setupBasic.sh 
./setupBasic.sh: 40: Syntax error: "(" unexpected
josef@RasPi-Testsystem:~ $ nano setupBasic.sh 
josef@RasPi-Testsystem:~ $ sudo sh ./setupBasic.sh 
./setupBasic.sh: 40: Syntax error: "(" unexpected
josef@RasPi-Testsystem:~ $ sudo sh setupBasic.sh 
setupBasic.sh: 40: Syntax error: "(" unexpected
josef@RasPi-Testsystem:~ $ nano setupBasic.sh 
josef@RasPi-Testsystem:~ $ sudo bash setupBasic.sh 
Holen:1 http://security.debian.org/debian-security bullseye-security InRelease [48,4 kB]
OK:2 http://deb.debian.org/debian bullseye InRelease                           
Holen:3 http://deb.debian.org/debian bullseye-updates InRelease [44,1 kB]      
OK:4 http://archive.raspberrypi.org/debian bullseye InRelease                  
Holen:5 http://deb.debian.org/debian bullseye/main Translation-de_DE [830 B]
Holen:6 http://deb.debian.org/debian bullseye/main Translation-de [1.718 kB]
Es wurden 1.811 kB in 3 s geholt (572 kB/s).
Paketlisten werden gelesen… Fertig
Abhängigkeitsbaum wird aufgebaut… Fertig
Statusinformationen werden eingelesen… Fertig
Alle Pakete sind aktuell.
Paketlisten werden gelesen… Fertig
Abhängigkeitsbaum wird aufgebaut… Fertig
Statusinformationen werden eingelesen… Fertig
Paketaktualisierung (Upgrade) wird berechnet… Fertig
0 aktualisiert, 0 neu installiert, 0 zu entfernen und 0 nicht aktualisiert.
Generating locales (this might take a while)...
  de_DE.UTF-8... done
  en_GB.UTF-8... done
  en_US.UTF-8... done
Generation complete.
Paketlisten werden gelesen… Fertig
Abhängigkeitsbaum wird aufgebaut… Fertig
Statusinformationen werden eingelesen… Fertig
ntpdate ist schon die neueste Version (1:4.2.8p15+dfsg-1).
0 aktualisiert, 0 neu installiert, 0 zu entfernen und 0 nicht aktualisiert.
Ein reboot ist empfohlen!
josef@RasPi-Testsystem:~ $ sudo  setupBasic.sh 
sudo: setupBasic.sh: Befehl nicht gefunden
josef@RasPi-Testsystem:~ $ sudo  ./setupBasic.sh 
OK:1 http://security.debian.org/debian-security bullseye-security InRelease
OK:2 http://deb.debian.org/debian bullseye InRelease
OK:3 http://deb.debian.org/debian bullseye-updates InRelease
OK:4 http://archive.raspberrypi.org/debian bullseye InRelease
Paketlisten werden gelesen… Fertig                
Abhängigkeitsbaum wird aufgebaut… Fertig
Statusinformationen werden eingelesen… Fertig
Alle Pakete sind aktuell.
Paketlisten werden gelesen… Fertig
Abhängigkeitsbaum wird aufgebaut… Fertig
Statusinformationen werden eingelesen… Fertig
Paketaktualisierung (Upgrade) wird berechnet… Fertig
0 aktualisiert, 0 neu installiert, 0 zu entfernen und 0 nicht aktualisiert.
Generating locales (this might take a while)...
  de_DE.UTF-8... done
  en_GB.UTF-8... done
  en_US.UTF-8... done
Generation complete.
Paketlisten werden gelesen… Fertig
Abhängigkeitsbaum wird aufgebaut… Fertig
Statusinformationen werden eingelesen… Fertig
ntpdate ist schon die neueste Version (1:4.2.8p15+dfsg-1).
0 aktualisiert, 0 neu installiert, 0 zu entfernen und 0 nicht aktualisiert.
Ein reboot ist empfohlen!
josef@RasPi-Testsystem:~ $ nano setupBasic.sh 
josef@RasPi-Testsystem:~ $ cp setupBasic.sh s.sh
josef@RasPi-Testsystem:~ $ nano s.sh
josef@RasPi-Testsystem:~ $ sudo  ./s.sh 
n
josef@RasPi-Testsystem:~ $ sudo  ./s.sh 
n
josef@RasPi-Testsystem:~ $ 
josef@RasPi-Testsystem:~ $ sudo  ./s.sh 
n
josef@RasPi-Testsystem:~ $ nano s.sh
josef@RasPi-Testsystem:~ $ sudo  ./s.sh 
n
josef@RasPi-Testsystem:~ $ nano s.sh
josef@RasPi-Testsystem:~ $ sudo  ./s.sh 
n
Update Raspberry firmware ? (y/N): 
Ein reboot ist empfohlen!
josef@RasPi-Testsystem:~ $ sudo  ./s.sh 
n
Update Raspberry firmware ? (y/N): n
Ein reboot ist empfohlen!
josef@RasPi-Testsystem:~ $ sudo  ./s.sh 
n
Update Raspberry firmware ? (y/N): g
Ein reboot ist empfohlen!
josef@RasPi-Testsystem:~ $ sudo  ./s.sh 
n
Update Raspberry firmware ? (y/N): y
rpi-update
Ein reboot ist empfohlen!
josef@RasPi-Testsystem:~ $ nano s.sh
josef@RasPi-Testsystem:~ $ sudo  ./s.sh 
./s.sh: Zeile 68: Syntaxfehler beim unerwarteten Symbol »]«
./s.sh: Zeile 68: `	[nN ] ) echo exiting...;'
josef@RasPi-Testsystem:~ $ sudo  ./s.sh 
./s.sh: Zeile 68: Syntaxfehler beim unerwarteten Symbol »]«
./s.sh: Zeile 68: `	[nN ] ) echo exiting...;'
josef@RasPi-Testsystem:~ $ nano s.sh
josef@RasPi-Testsystem:~ $ sudo  ./s.sh 
Update Raspberry firmware ? (y/N):  
invalid response
Update Raspberry firmware ? (y/N): 
invalid response
Update Raspberry firmware ? (y/N): n
exiting...
Ein reboot ist empfohlen!
josef@RasPi-Testsystem:~ $ sudo  ./s.sh 
Update Raspberry firmware ? (y/N): y
ok, we will proceed
rpi-update
Ein reboot ist empfohlen!
josef@RasPi-Testsystem:~ $ nano s.sh
josef@RasPi-Testsystem:~ $ sudo  ./s.sh 
Update Raspberry firmware ? (y/N): 
invalid response
Update Raspberry firmware ? (y/N): 
invalid response
Update Raspberry firmware ? (y/N): ^[[A
invalid response
Update Raspberry firmware ? (y/N):  
invalid response
Update Raspberry firmware ? (y/N):  
invalid response
Update Raspberry firmware ? (y/N): '
invalid response
Update Raspberry firmware ? (y/N): n
exiting...
Ein reboot ist empfohlen!
josef@RasPi-Testsystem:~ $ nano s.sh
josef@RasPi-Testsystem:~ $ sudo  ./s.sh 
Update Raspberry firmware ? (y/N): 
invalid response
Update Raspberry firmware ? (y/N): n
exiting...
Update Raspberry firmware ? (y/N): 
Ein reboot ist empfohlen!
josef@RasPi-Testsystem:~ $ sudo  ./s.sh 
Update Raspberry firmware ? (y/N): n
exiting...
Update Raspberry firmware ? (y/N): j
Ein reboot ist empfohlen!
josef@RasPi-Testsystem:~ $ sudo  ./s.sh 
Update Raspberry firmware ? (y/N): d
invalid response
Update Raspberry firmware ? (y/N): y
ok, we will proceed
rpi-update
Update Raspberry firmware ? (y/N): 
Ein reboot ist empfohlen!
josef@RasPi-Testsystem:~ $ sudo  ./s.sh 
Update Raspberry firmware ? (y/N): y
ok, we will proceed
rpi-update
Update Raspberry firmware ? (y/N): y
rpi-update1
Ein reboot ist empfohlen!
josef@RasPi-Testsystem:~ $ sudo  ./s.sh 
Update Raspberry firmware ? (y/N): y
ok, we will proceed
rpi-update
Update Raspberry firmware ? (y/N): Y
rpi-update1
Ein reboot ist empfohlen!
josef@RasPi-Testsystem:~ $ nano s.sh
josef@RasPi-Testsystem:~ $ sudo  ./s.sh 
Update Raspberry firmware ? (y/N): e
e
invalid response
Update Raspberry firmware ? (y/N): E
e
invalid response
Update Raspberry firmware ? (y/N): w
w
invalid response
Update Raspberry firmware ? (y/N): W
w
invalid response
Update Raspberry firmware ? (y/N): QW
qw
invalid response
Update Raspberry firmware ? (y/N): y
y
ok, we will proceed
rpi-update
Update Raspberry firmware ? (y/N): y
rpi-update1
Ein reboot ist empfohlen!
josef@RasPi-Testsystem:~ $ nano s.sh
josef@RasPi-Testsystem:~ $ sudo  ./s.sh 
Update Raspberry firmware ? (y/N): s
s
invalid response
Update Raspberry firmware ? (y/N): d
d
invalid response
Update Raspberry firmware ? (y/N): r
r
invalid response
Update Raspberry firmware ? (y/N): n
n
ok, we will proceed
rpi-update
Ein reboot ist empfohlen!
josef@RasPi-Testsystem:~ $ sudo  ./s.sh 
Update Raspberry firmware ? (y/N): y
y
ok, we will proceed
rpi-update
rpi-update1
Ein reboot ist empfohlen!
josef@RasPi-Testsystem:~ $ nano s.sh
josef@RasPi-Testsystem:~ $ sudo  ./s.sh 
Update Raspberry firmware ? (j/N): d
d
Unerwartete Eingabe
Update Raspberry firmware ? (j/N): f
f
Unerwartete Eingabe
Update Raspberry firmware ? (j/N): s
s
Unerwartete Eingabe
Update Raspberry firmware ? (j/N): n
n
Ein reboot ist empfohlen!
josef@RasPi-Testsystem:~ $ sudo  ./s.sh 
Update Raspberry firmware ? (j/N): j
j
rpi-update1
Ein reboot ist empfohlen!
josef@RasPi-Testsystem:~ $ nano s.sh
josef@RasPi-Testsystem:~ $ sudo  ./s.sh 
Update Raspberry firmware ? (y/N): d
d
Unexpected input
Update Raspberry firmware ? (y/N): e
e
Unexpected input
Update Raspberry firmware ? (y/N): w
w
Unexpected input
Update Raspberry firmware ? (y/N): bbb
bbb
Unexpected input
Update Raspberry firmware ? (y/N): ddd
ddd
Unexpected input
Update Raspberry firmware ? (y/N): n
n
Ein reboot ist empfohlen!
josef@RasPi-Testsystem:~ $ sudo  ./s.sh 
Update Raspberry firmware ? (y/N): y
y
rpi-update1
Ein reboot ist empfohlen!
josef@RasPi-Testsystem:~ $ nano s.sh
josef@RasPi-Testsystem:~ $ rm s.sh
josef@RasPi-Testsystem:~ $ argonone-config
--------------------------------------
Argon One Fan Speed Configuration Tool
--------------------------------------
WARNING: This will remove existing configuration.
Press Y to continue:n
Cancelled
josef@RasPi-Testsystem:~ $ cd /stc
-bash: cd: /stc: Datei oder Verzeichnis nicht gefunden
josef@RasPi-Testsystem:~ $ cd /etc
josef@RasPi-Testsystem:/etc $ ls aro*
ls: Zugriff auf 'aro*' nicht möglich: Datei oder Verzeichnis nicht gefunden
josef@RasPi-Testsystem:/etc $ ls argo*
argononed.conf
josef@RasPi-Testsystem:/etc $ cd /opt
josef@RasPi-Testsystem:/opt $ ls -al
insgesamt 8
drwxr-xr-x  2 root root 4096 21. Feb 04:51 .
drwxr-xr-x 19 root root 4096 28. Feb 18:24 ..
josef@RasPi-Testsystem:/opt $ cd
josef@RasPi-Testsystem:~ $ curl https://download.argon40.com/argon1.sh
#!/bin/bash


argon_create_file() {
	if [ -f $1 ]; then
		sudo rm $1
	fi
	sudo touch $1
	sudo chmod 666 $1
}
argon_check_pkg() {
	RESULT=$(dpkg-query -W -f='${Status}\n' "$1" 2> /dev/null | grep "installed")

	if [ "" == "$RESULT" ]; then
		echo "NG"
	else
		echo "OK"
	fi
}

# Check if Raspbian, Ubuntu, others
CHECKPLATFORM="Others"
if [ -f "/etc/os-release" ]
then
	source /etc/os-release
	if [ "$ID" = "raspbian" ]
	then
		CHECKPLATFORM="Raspbian"
	elif [ "$ID" = "ubuntu" ]
	then
		CHECKPLATFORM="Ubuntu"
	fi
fi


if [ "$CHECKPLATFORM" = "Raspbian" ]
then
	pkglist=(raspi-gpio python3-rpi.gpio python3-smbus i2c-tools)	
else
	# Todo handle lgpio
	# Ubuntu has serial and i2c enabled
	pkglist=(python3-rpi.gpio python3-smbus i2c-tools)
fi

for curpkg in ${pkglist[@]}; do
	sudo apt-get install -y $curpkg
	RESULT=$(argon_check_pkg "$curpkg")
	if [ "NG" == "$RESULT" ]
	then
		echo "********************************************************************"
		echo "Please also connect device to the internet and restart installation."
		echo "********************************************************************"
		exit
	fi
done

# Ubuntu Mate for RPi has raspi-config too
command -v raspi-config &> /dev/null
if [ $? -eq 0 ]
then
	# Enable i2c and serial
	sudo raspi-config nonint do_i2c 0
	sudo raspi-config nonint do_serial 2
fi

# Helper variables
daemonname="argononed"
powerbuttonscript=/usr/bin/$daemonname.py
shutdownscript="/lib/systemd/system-shutdown/"$daemonname"-poweroff.py"
daemonconfigfile=/etc/$daemonname.conf
configscript=/usr/bin/argonone-config
removescript=/usr/bin/argonone-uninstall

daemonfanservice=/lib/systemd/system/$daemonname.service
	
if [ ! -f $daemonconfigfile ]; then
	# Generate config file for fan speed
	sudo touch $daemonconfigfile
	sudo chmod 666 $daemonconfigfile
	echo '#' >> $daemonconfigfile
	echo '# Argon One Fan Configuration' >> $daemonconfigfile
	echo '#' >> $daemonconfigfile
	echo '# List below the temperature (Celsius) and fan speed (in percent) pairs' >> $daemonconfigfile
	echo '# Use the following form:' >> $daemonconfigfile
	echo '# min.temperature=speed' >> $daemonconfigfile
	echo '#' >> $daemonconfigfile
	echo '# Example:' >> $daemonconfigfile
	echo '# 55=10' >> $daemonconfigfile
	echo '# 60=55' >> $daemonconfigfile
	echo '# 65=100' >> $daemonconfigfile
	echo '#' >> $daemonconfigfile
	echo '# Above example sets the fan speed to' >> $daemonconfigfile
	echo '#' >> $daemonconfigfile
	echo '# NOTE: Lines begining with # are ignored' >> $daemonconfigfile
	echo '#' >> $daemonconfigfile
	echo '# Type the following at the command line for changes to take effect:' >> $daemonconfigfile
	echo '# sudo systemctl restart '$daemonname'.service' >> $daemonconfigfile
	echo '#' >> $daemonconfigfile
	echo '# Start below:' >> $daemonconfigfile
	echo '55=10' >> $daemonconfigfile
	echo '60=55' >> $daemonconfigfile
	echo '65=100' >> $daemonconfigfile
fi

# Generate script that runs every shutdown event
argon_create_file $shutdownscript

echo "#!/usr/bin/python3" >> $shutdownscript
echo 'import sys' >> $shutdownscript
echo 'import smbus' >> $shutdownscript
echo 'import RPi.GPIO as GPIO' >> $shutdownscript
echo 'rev = GPIO.RPI_REVISION' >> $shutdownscript
echo 'if rev == 2 or rev == 3:' >> $shutdownscript
echo '	bus = smbus.SMBus(1)' >> $shutdownscript
echo 'else:' >> $shutdownscript
echo '	bus = smbus.SMBus(0)' >> $shutdownscript

echo 'if len(sys.argv)>1:' >> $shutdownscript
echo "	bus.write_byte(0x1a,0)"  >> $shutdownscript

# powercut signal
echo '	if sys.argv[1] == "poweroff" or sys.argv[1] == "halt":'  >> $shutdownscript
echo "		try:"  >> $shutdownscript
echo "			bus.write_byte(0x1a,0xFF)"  >> $shutdownscript
echo "		except:"  >> $shutdownscript
echo "			rev=0"  >> $shutdownscript

sudo chmod 755 $shutdownscript

# Generate script to monitor shutdown button

argon_create_file $powerbuttonscript

echo "#!/usr/bin/python3" >> $powerbuttonscript
echo 'import smbus' >> $powerbuttonscript
echo 'import RPi.GPIO as GPIO' >> $powerbuttonscript
echo 'import os' >> $powerbuttonscript
echo 'import time' >> $powerbuttonscript
echo 'from threading import Thread' >> $powerbuttonscript
echo 'rev = GPIO.RPI_REVISION' >> $powerbuttonscript
echo 'if rev == 2 or rev == 3:' >> $powerbuttonscript
echo '	bus = smbus.SMBus(1)' >> $powerbuttonscript
echo 'else:' >> $powerbuttonscript
echo '	bus = smbus.SMBus(0)' >> $powerbuttonscript

echo 'GPIO.setwarnings(False)' >> $powerbuttonscript
echo 'GPIO.setmode(GPIO.BCM)' >> $powerbuttonscript
echo 'shutdown_pin=4' >> $powerbuttonscript
echo 'GPIO.setup(shutdown_pin, GPIO.IN,  pull_up_down=GPIO.PUD_DOWN)' >> $powerbuttonscript

echo 'def shutdown_check():' >> $powerbuttonscript
echo '	while True:' >> $powerbuttonscript
echo '		pulsetime = 1' >> $powerbuttonscript
echo '		GPIO.wait_for_edge(shutdown_pin, GPIO.RISING)' >> $powerbuttonscript
echo '		time.sleep(0.01)' >> $powerbuttonscript
echo '		while GPIO.input(shutdown_pin) == GPIO.HIGH:' >> $powerbuttonscript
echo '			time.sleep(0.01)' >> $powerbuttonscript
echo '			pulsetime += 1' >> $powerbuttonscript
echo '		if pulsetime >=2 and pulsetime <=3:' >> $powerbuttonscript
echo '			os.system("reboot")' >> $powerbuttonscript
echo '		elif pulsetime >=4 and pulsetime <=5:' >> $powerbuttonscript
echo '			os.system("shutdown now -h")' >> $powerbuttonscript

echo 'def get_fanspeed(tempval, configlist):' >> $powerbuttonscript
echo '	for curconfig in configlist:' >> $powerbuttonscript
echo '		curpair = curconfig.split("=")' >> $powerbuttonscript
echo '		tempcfg = float(curpair[0])' >> $powerbuttonscript
echo '		fancfg = int(float(curpair[1]))' >> $powerbuttonscript
echo '		if tempval >= tempcfg:' >> $powerbuttonscript
echo '			if fancfg < 1:' >> $powerbuttonscript
echo '				return 0' >> $powerbuttonscript
echo '			elif fancfg < 25:' >> $powerbuttonscript
echo '				return 25' >> $powerbuttonscript
echo '			return fancfg' >> $powerbuttonscript
echo '	return 0' >> $powerbuttonscript

echo 'def load_config(fname):' >> $powerbuttonscript
echo '	newconfig = []' >> $powerbuttonscript
echo '	try:' >> $powerbuttonscript
echo '		with open(fname, "r") as fp:' >> $powerbuttonscript
echo '			for curline in fp:' >> $powerbuttonscript
echo '				if not curline:' >> $powerbuttonscript
echo '					continue' >> $powerbuttonscript
echo '				tmpline = curline.strip()' >> $powerbuttonscript
echo '				if not tmpline:' >> $powerbuttonscript
echo '					continue' >> $powerbuttonscript
echo '				if tmpline[0] == "#":' >> $powerbuttonscript
echo '					continue' >> $powerbuttonscript
echo '				tmppair = tmpline.split("=")' >> $powerbuttonscript
echo '				if len(tmppair) != 2:' >> $powerbuttonscript
echo '					continue' >> $powerbuttonscript
echo '				tempval = 0' >> $powerbuttonscript
echo '				fanval = 0' >> $powerbuttonscript
echo '				try:' >> $powerbuttonscript
echo '					tempval = float(tmppair[0])' >> $powerbuttonscript
echo '					if tempval < 0 or tempval > 100:' >> $powerbuttonscript
echo '						continue' >> $powerbuttonscript
echo '				except:' >> $powerbuttonscript
echo '					continue' >> $powerbuttonscript
echo '				try:' >> $powerbuttonscript
echo '					fanval = int(float(tmppair[1]))' >> $powerbuttonscript
echo '					if fanval < 0 or fanval > 100:' >> $powerbuttonscript
echo '						continue' >> $powerbuttonscript
echo '				except:' >> $powerbuttonscript
echo '					continue' >> $powerbuttonscript
echo '				newconfig.append( "{:5.1f}={}".format(tempval,fanval))' >> $powerbuttonscript
echo '		if len(newconfig) > 0:' >> $powerbuttonscript
echo '			newconfig.sort(reverse=True)' >> $powerbuttonscript
echo '	except:' >> $powerbuttonscript
echo '		return []' >> $powerbuttonscript
echo '	return newconfig' >> $powerbuttonscript

echo 'def temp_check():' >> $powerbuttonscript
echo '	fanconfig = ["65=100", "60=55", "55=10"]' >> $powerbuttonscript
echo '	tmpconfig = load_config("'$daemonconfigfile'")' >> $powerbuttonscript
echo '	if len(tmpconfig) > 0:' >> $powerbuttonscript
echo '		fanconfig = tmpconfig' >> $powerbuttonscript
echo '	address=0x1a' >> $powerbuttonscript
echo '	prevblock=0' >> $powerbuttonscript
echo '	while True:' >> $powerbuttonscript

echo '		try:' >> $powerbuttonscript
echo '			tempfp = open("/sys/class/thermal/thermal_zone0/temp", "r")' >> $powerbuttonscript
echo '			temp = tempfp.readline()' >> $powerbuttonscript
echo '			tempfp.close()' >> $powerbuttonscript
echo '			val = float(int(temp)/1000)' >> $powerbuttonscript
echo '		except IOError:' >> $powerbuttonscript
echo '			val = 0' >> $powerbuttonscript

echo '		block = get_fanspeed(val, fanconfig)' >> $powerbuttonscript
echo '		if block < prevblock:' >> $powerbuttonscript
echo '			time.sleep(30)' >> $powerbuttonscript
echo '		prevblock = block' >> $powerbuttonscript
echo '		try:' >> $powerbuttonscript
echo '			if block > 0:' >> $powerbuttonscript
echo '				bus.write_byte(address,100)' >> $powerbuttonscript
echo '				time.sleep(1)' >> $powerbuttonscript
echo '			bus.write_byte(address,block)' >> $powerbuttonscript
echo '		except IOError:' >> $powerbuttonscript
echo '			temp=""' >> $powerbuttonscript
echo '		time.sleep(30)' >> $powerbuttonscript

echo 'try:' >> $powerbuttonscript
echo '	t1 = Thread(target = shutdown_check)' >> $powerbuttonscript
echo '	t2 = Thread(target = temp_check)' >> $powerbuttonscript
echo '	t1.start()' >> $powerbuttonscript
echo '	t2.start()' >> $powerbuttonscript
echo 'except:' >> $powerbuttonscript
echo '	t1.stop()' >> $powerbuttonscript
echo '	t2.stop()' >> $powerbuttonscript
echo '	GPIO.cleanup()' >> $powerbuttonscript

sudo chmod 755 $powerbuttonscript

argon_create_file $daemonfanservice

# Fan Daemon
echo "[Unit]" >> $daemonfanservice
echo "Description=Argon One Fan and Button Service" >> $daemonfanservice
echo "After=multi-user.target" >> $daemonfanservice
echo '[Service]' >> $daemonfanservice
echo 'Type=simple' >> $daemonfanservice
echo "Restart=always" >> $daemonfanservice
echo "RemainAfterExit=true" >> $daemonfanservice
echo "ExecStart=/usr/bin/python3 $powerbuttonscript" >> $daemonfanservice
echo '[Install]' >> $daemonfanservice
echo "WantedBy=multi-user.target" >> $daemonfanservice

sudo chmod 644 $daemonfanservice

argon_create_file $removescript

# Uninstall Script
echo '#!/bin/bash' >> $removescript
echo 'echo "-------------------------"' >> $removescript
echo 'echo "Argon One Uninstall Tool"' >> $removescript
echo 'echo "-------------------------"' >> $removescript
echo 'echo -n "Press Y to continue:"' >> $removescript
echo 'read -n 1 confirm' >> $removescript
echo 'echo' >> $removescript
echo 'if [ "$confirm" = "y" ]' >> $removescript
echo 'then' >> $removescript
echo '	confirm="Y"' >> $removescript
echo 'fi' >> $removescript
echo '' >> $removescript
echo 'if [ "$confirm" != "Y" ]' >> $removescript
echo 'then' >> $removescript
echo '	echo "Cancelled"' >> $removescript
echo '	exit' >> $removescript
echo 'fi' >> $removescript
echo 'if [ -d "/home/pi/Desktop" ]; then' >> $removescript
echo '	sudo rm "/home/pi/Desktop/argonone-config.desktop"' >> $removescript
echo '	sudo rm "/home/pi/Desktop/argonone-uninstall.desktop"' >> $removescript
echo 'fi' >> $removescript
echo 'if [ -f '$powerbuttonscript' ]; then' >> $removescript
echo '	sudo systemctl stop '$daemonname'.service' >> $removescript
echo '	sudo systemctl disable '$daemonname'.service' >> $removescript
echo '	sudo /usr/bin/python3 '$shutdownscript' uninstall' >> $removescript
echo '	sudo rm '$powerbuttonscript >> $removescript
echo '	sudo rm '$shutdownscript >> $removescript
echo '	sudo rm '$removescript >> $removescript
echo '	echo "Removed Argon One Services."' >> $removescript
echo '	echo "Cleanup will complete after restarting the device."' >> $removescript
echo 'fi' >> $removescript

sudo chmod 755 $removescript

argon_create_file $configscript

# Config Script
echo '#!/bin/bash' >> $configscript
echo 'daemonconfigfile='$daemonconfigfile >> $configscript
echo 'echo "--------------------------------------"' >> $configscript
echo 'echo "Argon One Fan Speed Configuration Tool"' >> $configscript
echo 'echo "--------------------------------------"' >> $configscript
echo 'echo "WARNING: This will remove existing configuration."' >> $configscript
echo 'echo -n "Press Y to continue:"' >> $configscript
echo 'read -n 1 confirm' >> $configscript
echo 'echo' >> $configscript
echo 'if [ "$confirm" = "y" ]' >> $configscript
echo 'then' >> $configscript
echo '	confirm="Y"' >> $configscript
echo 'fi' >> $configscript
echo '' >> $configscript
echo 'if [ "$confirm" != "Y" ]' >> $configscript
echo 'then' >> $configscript
echo '	echo "Cancelled"' >> $configscript
echo '	exit' >> $configscript
echo 'fi' >> $configscript
echo 'echo "Thank you."' >> $configscript

echo 'get_number () {' >> $configscript
echo '	read curnumber' >> $configscript
echo '	if [ -z "$curnumber" ]' >> $configscript
echo '	then' >> $configscript
echo '		echo "-2"' >> $configscript
echo '		return' >> $configscript
echo '	elif [[ $curnumber =~ ^[+-]?[0-9]+$ ]]' >> $configscript
echo '	then' >> $configscript
echo '		if [ $curnumber -lt 0 ]' >> $configscript
echo '		then' >> $configscript
echo '			echo "-1"' >> $configscript
echo '			return' >> $configscript
echo '		elif [ $curnumber -gt 100 ]' >> $configscript
echo '		then' >> $configscript
echo '			echo "-1"' >> $configscript
echo '			return' >> $configscript
echo '		fi	' >> $configscript
echo '		echo $curnumber' >> $configscript
echo '		return' >> $configscript
echo '	fi' >> $configscript
echo '	echo "-1"' >> $configscript
echo '	return' >> $configscript
echo '}' >> $configscript
echo '' >> $configscript

echo 'loopflag=1' >> $configscript
echo 'while [ $loopflag -eq 1 ]' >> $configscript
echo 'do' >> $configscript
echo '	echo' >> $configscript
echo '	echo "Select fan mode:"' >> $configscript
echo '	echo "  1. Always on"' >> $configscript
echo '	echo "  2. Adjust to temperatures (55C, 60C, and 65C)"' >> $configscript
echo '	echo "  3. Customize behavior"' >> $configscript
echo '	echo "  4. Cancel"' >> $configscript
echo '	echo "NOTE: You can also edit $daemonconfigfile directly"' >> $configscript
echo '	echo -n "Enter Number (1-4):"' >> $configscript
echo '	newmode=$( get_number )' >> $configscript
echo '	if [[ $newmode -ge 1 && $newmode -le 4 ]]' >> $configscript
echo '	then' >> $configscript
echo '		loopflag=0' >> $configscript
echo '	fi' >> $configscript
echo 'done' >> $configscript

echo 'echo' >> $configscript
echo 'if [ $newmode -eq 4 ]' >> $configscript
echo 'then' >> $configscript
echo '	echo "Cancelled"' >> $configscript
echo '	exit' >> $configscript
echo 'elif [ $newmode -eq 1 ]' >> $configscript
echo 'then' >> $configscript
echo '	echo "#" > $daemonconfigfile' >> $configscript
echo '	echo "# Argon One Fan Speed Configuration" >> $daemonconfigfile' >> $configscript
echo '	echo "#" >> $daemonconfigfile' >> $configscript
echo '	echo "# Min Temp=Fan Speed" >> $daemonconfigfile' >> $configscript
echo '	echo 1"="100 >> $daemonconfigfile' >> $configscript
echo '	sudo systemctl restart '$daemonname'.service' >> $configscript
echo '	echo "Fan always on."' >> $configscript
echo '	exit' >> $configscript
echo 'elif [ $newmode -eq 2 ]' >> $configscript
echo 'then' >> $configscript
echo '	echo "Please provide fan speeds for the following temperatures:"' >> $configscript
echo '	echo "#" > $daemonconfigfile' >> $configscript
echo '	echo "# Argon One Fan Speed Configuration" >> $daemonconfigfile' >> $configscript
echo '	echo "#" >> $daemonconfigfile' >> $configscript
echo '	echo "# Min Temp=Fan Speed" >> $daemonconfigfile' >> $configscript
echo '	curtemp=55' >> $configscript
echo '	while [ $curtemp -lt 70 ]' >> $configscript
echo '	do' >> $configscript
echo '		errorfanflag=1' >> $configscript
echo '		while [ $errorfanflag -eq 1 ]' >> $configscript
echo '		do' >> $configscript
echo '			echo -n ""$curtemp"C (0-100 only):"' >> $configscript
echo '			curfan=$( get_number )' >> $configscript
echo '			if [ $curfan -ge 0 ]' >> $configscript
echo '			then' >> $configscript
echo '				errorfanflag=0' >> $configscript
echo '			fi' >> $configscript
echo '		done' >> $configscript
echo '		echo $curtemp"="$curfan >> $daemonconfigfile' >> $configscript
echo '		curtemp=$((curtemp+5))' >> $configscript
echo '	done' >> $configscript

echo '	sudo systemctl restart '$daemonname'.service' >> $configscript
echo '	echo "Configuration updated."' >> $configscript
echo '	exit' >> $configscript
echo 'fi' >> $configscript

echo 'echo "Please provide fan speeds and temperature pairs"' >> $configscript
echo 'echo' >> $configscript

echo 'loopflag=1' >> $configscript
echo 'paircounter=0' >> $configscript
echo 'while [ $loopflag -eq 1 ]' >> $configscript
echo 'do' >> $configscript
echo '	errortempflag=1' >> $configscript
echo '	errorfanflag=1' >> $configscript
echo '	while [ $errortempflag -eq 1 ]' >> $configscript
echo '	do' >> $configscript
echo '		echo -n "Provide minimum temperature (in Celsius) then [ENTER]:"' >> $configscript
echo '		curtemp=$( get_number )' >> $configscript
echo '		if [ $curtemp -ge 0 ]' >> $configscript
echo '		then' >> $configscript
echo '			errortempflag=0' >> $configscript
echo '		elif [ $curtemp -eq -2 ]' >> $configscript
echo '		then' >> $configscript
echo '			errortempflag=0' >> $configscript
echo '			errorfanflag=0' >> $configscript
echo '			loopflag=0' >> $configscript
echo '		fi' >> $configscript
echo '	done' >> $configscript
echo '	while [ $errorfanflag -eq 1 ]' >> $configscript
echo '	do' >> $configscript
echo '		echo -n "Provide fan speed for "$curtemp"C (0-100) then [ENTER]:"' >> $configscript
echo '		curfan=$( get_number )' >> $configscript
echo '		if [ $curfan -ge 0 ]' >> $configscript
echo '		then' >> $configscript
echo '			errorfanflag=0' >> $configscript
echo '		elif [ $curfan -eq -2 ]' >> $configscript
echo '		then' >> $configscript
echo '			errortempflag=0' >> $configscript
echo '			errorfanflag=0' >> $configscript
echo '			loopflag=0' >> $configscript
echo '		fi' >> $configscript
echo '	done' >> $configscript
echo '	if [ $loopflag -eq 1 ]' >> $configscript
echo '	then' >> $configscript
echo '		if [ $paircounter -eq 0 ]' >> $configscript
echo '		then' >> $configscript
echo '			echo "#" > $daemonconfigfile' >> $configscript
echo '			echo "# Argon One Fan Speed Configuration" >> $daemonconfigfile' >> $configscript
echo '			echo "#" >> $daemonconfigfile' >> $configscript
echo '			echo "# Min Temp=Fan Speed" >> $daemonconfigfile' >> $configscript
echo '		fi' >> $configscript
echo '		echo $curtemp"="$curfan >> $daemonconfigfile' >> $configscript
echo '		' >> $configscript
echo '		paircounter=$((paircounter+1))' >> $configscript
echo '		' >> $configscript
echo '		echo "* Fan speed will be set to "$curfan" once temperature reaches "$curtemp" C"' >> $configscript
echo '		echo' >> $configscript
echo '	fi' >> $configscript
echo 'done' >> $configscript
echo '' >> $configscript
echo 'echo' >> $configscript
echo 'if [ $paircounter -gt 0 ]' >> $configscript
echo 'then' >> $configscript
echo '	echo "Thank you!  We saved "$paircounter" pairs."' >> $configscript
echo '	sudo systemctl restart '$daemonname'.service' >> $configscript
echo '	echo "Changes should take effect now."' >> $configscript
echo 'else' >> $configscript
echo '	echo "Cancelled, no data saved."' >> $configscript
echo 'fi' >> $configscript

sudo chmod 755 $configscript


sudo systemctl daemon-reload
sudo systemctl enable $daemonname.service

sudo systemctl start $daemonname.service


shortcutfile="/home/pi/Desktop/argonone-config.desktop"
if [ "$CHECKPLATFORM" = "Raspbian" ] && [ -d "/home/pi/Desktop" ]
then
	terminalcmd="lxterminal --working-directory=/home/pi/ -t"
	if  [ -f "/home/pi/.twisteros.twid" ]
	then
		terminalcmd="xfce4-terminal --default-working-directory=/home/pi/ -T"
	fi
	sudo wget http://download.argon40.com/ar1config.png -O /usr/share/pixmaps/ar1config.png --quiet
	sudo wget http://download.argon40.com/ar1uninstall.png -O /usr/share/pixmaps/ar1uninstall.png --quiet
	# Create Shortcuts
	echo "[Desktop Entry]" > $shortcutfile
	echo "Name=Argon One Configuration" >> $shortcutfile
	echo "Comment=Argon One Configuration" >> $shortcutfile
	echo "Icon=/usr/share/pixmaps/ar1config.png" >> $shortcutfile
	echo 'Exec='$terminalcmd' "Argon One Configuration" -e '$configscript >> $shortcutfile
	echo "Type=Application" >> $shortcutfile
	echo "Encoding=UTF-8" >> $shortcutfile
	echo "Terminal=false" >> $shortcutfile
	echo "Categories=None;" >> $shortcutfile
	chmod 755 $shortcutfile
	
	shortcutfile="/home/pi/Desktop/argonone-uninstall.desktop"
	echo "[Desktop Entry]" > $shortcutfile
	echo "Name=Argon One Uninstall" >> $shortcutfile
	echo "Comment=Argon One Uninstall" >> $shortcutfile
	echo "Icon=/usr/share/pixmaps/ar1uninstall.png" >> $shortcutfile
	echo 'Exec='$terminalcmd' -t "Argon One Uninstall" --working-directory=/home/pi/ -e '$removescript >> $shortcutfile
	echo "Type=Application" >> $shortcutfile
	echo "Encoding=UTF-8" >> $shortcutfile
	echo "Terminal=false" >> $shortcutfile
	echo "Categories=None;" >> $shortcutfile
	chmod 755 $shortcutfile
fi

# IR config script
sudo wget https://download.argon40.com/argonone-irconfig.sh -O /usr/bin/argonone-ir --quiet
sudo chmod 755 /usr/bin/argonone-ir

echo "***************************"
echo "Argon One Setup Completed."
echo "***************************"
echo
if [ ! "$CHECKPLATFORM" = "Raspbian" ]
then
		echo "You may need to reboot for changes to take effect"
		echo
fi 
if [ -f $shortcutfile ]; then
	echo Shortcuts created in your desktop.
else
	echo Use 'argonone-config' to configure fan
	echo Use 'argonone-uninstall' to uninstall
fi
echo
josef@RasPi-Testsystem:~ $ ls
setupBasic.sh
josef@RasPi-Testsystem:~ $ curl https://download.argon40.com/argon1.sh argon1.sh
#!/bin/bash


argon_create_file() {
	if [ -f $1 ]; then
		sudo rm $1
	fi
	sudo touch $1
	sudo chmod 666 $1
}
argon_check_pkg() {
	RESULT=$(dpkg-query -W -f='${Status}\n' "$1" 2> /dev/null | grep "installed")

	if [ "" == "$RESULT" ]; then
		echo "NG"
	else
		echo "OK"
	fi
}

# Check if Raspbian, Ubuntu, others
CHECKPLATFORM="Others"
if [ -f "/etc/os-release" ]
then
	source /etc/os-release
	if [ "$ID" = "raspbian" ]
	then
		CHECKPLATFORM="Raspbian"
	elif [ "$ID" = "ubuntu" ]
	then
		CHECKPLATFORM="Ubuntu"
	fi
fi


if [ "$CHECKPLATFORM" = "Raspbian" ]
then
	pkglist=(raspi-gpio python3-rpi.gpio python3-smbus i2c-tools)	
else
	# Todo handle lgpio
	# Ubuntu has serial and i2c enabled
	pkglist=(python3-rpi.gpio python3-smbus i2c-tools)
fi

for curpkg in ${pkglist[@]}; do
	sudo apt-get install -y $curpkg
	RESULT=$(argon_check_pkg "$curpkg")
	if [ "NG" == "$RESULT" ]
	then
		echo "********************************************************************"
		echo "Please also connect device to the internet and restart installation."
		echo "********************************************************************"
		exit
	fi
done

# Ubuntu Mate for RPi has raspi-config too
command -v raspi-config &> /dev/null
if [ $? -eq 0 ]
then
	# Enable i2c and serial
	sudo raspi-config nonint do_i2c 0
	sudo raspi-config nonint do_serial 2
fi

# Helper variables
daemonname="argononed"
powerbuttonscript=/usr/bin/$daemonname.py
shutdownscript="/lib/systemd/system-shutdown/"$daemonname"-poweroff.py"
daemonconfigfile=/etc/$daemonname.conf
configscript=/usr/bin/argonone-config
removescript=/usr/bin/argonone-uninstall

daemonfanservice=/lib/systemd/system/$daemonname.service
	
if [ ! -f $daemonconfigfile ]; then
	# Generate config file for fan speed
	sudo touch $daemonconfigfile
	sudo chmod 666 $daemonconfigfile
	echo '#' >> $daemonconfigfile
	echo '# Argon One Fan Configuration' >> $daemonconfigfile
	echo '#' >> $daemonconfigfile
	echo '# List below the temperature (Celsius) and fan speed (in percent) pairs' >> $daemonconfigfile
	echo '# Use the following form:' >> $daemonconfigfile
	echo '# min.temperature=speed' >> $daemonconfigfile
	echo '#' >> $daemonconfigfile
	echo '# Example:' >> $daemonconfigfile
	echo '# 55=10' >> $daemonconfigfile
	echo '# 60=55' >> $daemonconfigfile
	echo '# 65=100' >> $daemonconfigfile
	echo '#' >> $daemonconfigfile
	echo '# Above example sets the fan speed to' >> $daemonconfigfile
	echo '#' >> $daemonconfigfile
	echo '# NOTE: Lines begining with # are ignored' >> $daemonconfigfile
	echo '#' >> $daemonconfigfile
	echo '# Type the following at the command line for changes to take effect:' >> $daemonconfigfile
	echo '# sudo systemctl restart '$daemonname'.service' >> $daemonconfigfile
	echo '#' >> $daemonconfigfile
	echo '# Start below:' >> $daemonconfigfile
	echo '55=10' >> $daemonconfigfile
	echo '60=55' >> $daemonconfigfile
	echo '65=100' >> $daemonconfigfile
fi

# Generate script that runs every shutdown event
argon_create_file $shutdownscript

echo "#!/usr/bin/python3" >> $shutdownscript
echo 'import sys' >> $shutdownscript
echo 'import smbus' >> $shutdownscript
echo 'import RPi.GPIO as GPIO' >> $shutdownscript
echo 'rev = GPIO.RPI_REVISION' >> $shutdownscript
echo 'if rev == 2 or rev == 3:' >> $shutdownscript
echo '	bus = smbus.SMBus(1)' >> $shutdownscript
echo 'else:' >> $shutdownscript
echo '	bus = smbus.SMBus(0)' >> $shutdownscript

echo 'if len(sys.argv)>1:' >> $shutdownscript
echo "	bus.write_byte(0x1a,0)"  >> $shutdownscript

# powercut signal
echo '	if sys.argv[1] == "poweroff" or sys.argv[1] == "halt":'  >> $shutdownscript
echo "		try:"  >> $shutdownscript
echo "			bus.write_byte(0x1a,0xFF)"  >> $shutdownscript
echo "		except:"  >> $shutdownscript
echo "			rev=0"  >> $shutdownscript

sudo chmod 755 $shutdownscript

# Generate script to monitor shutdown button

argon_create_file $powerbuttonscript

echo "#!/usr/bin/python3" >> $powerbuttonscript
echo 'import smbus' >> $powerbuttonscript
echo 'import RPi.GPIO as GPIO' >> $powerbuttonscript
echo 'import os' >> $powerbuttonscript
echo 'import time' >> $powerbuttonscript
echo 'from threading import Thread' >> $powerbuttonscript
echo 'rev = GPIO.RPI_REVISION' >> $powerbuttonscript
echo 'if rev == 2 or rev == 3:' >> $powerbuttonscript
echo '	bus = smbus.SMBus(1)' >> $powerbuttonscript
echo 'else:' >> $powerbuttonscript
echo '	bus = smbus.SMBus(0)' >> $powerbuttonscript

echo 'GPIO.setwarnings(False)' >> $powerbuttonscript
echo 'GPIO.setmode(GPIO.BCM)' >> $powerbuttonscript
echo 'shutdown_pin=4' >> $powerbuttonscript
echo 'GPIO.setup(shutdown_pin, GPIO.IN,  pull_up_down=GPIO.PUD_DOWN)' >> $powerbuttonscript

echo 'def shutdown_check():' >> $powerbuttonscript
echo '	while True:' >> $powerbuttonscript
echo '		pulsetime = 1' >> $powerbuttonscript
echo '		GPIO.wait_for_edge(shutdown_pin, GPIO.RISING)' >> $powerbuttonscript
echo '		time.sleep(0.01)' >> $powerbuttonscript
echo '		while GPIO.input(shutdown_pin) == GPIO.HIGH:' >> $powerbuttonscript
echo '			time.sleep(0.01)' >> $powerbuttonscript
echo '			pulsetime += 1' >> $powerbuttonscript
echo '		if pulsetime >=2 and pulsetime <=3:' >> $powerbuttonscript
echo '			os.system("reboot")' >> $powerbuttonscript
echo '		elif pulsetime >=4 and pulsetime <=5:' >> $powerbuttonscript
echo '			os.system("shutdown now -h")' >> $powerbuttonscript

echo 'def get_fanspeed(tempval, configlist):' >> $powerbuttonscript
echo '	for curconfig in configlist:' >> $powerbuttonscript
echo '		curpair = curconfig.split("=")' >> $powerbuttonscript
echo '		tempcfg = float(curpair[0])' >> $powerbuttonscript
echo '		fancfg = int(float(curpair[1]))' >> $powerbuttonscript
echo '		if tempval >= tempcfg:' >> $powerbuttonscript
echo '			if fancfg < 1:' >> $powerbuttonscript
echo '				return 0' >> $powerbuttonscript
echo '			elif fancfg < 25:' >> $powerbuttonscript
echo '				return 25' >> $powerbuttonscript
echo '			return fancfg' >> $powerbuttonscript
echo '	return 0' >> $powerbuttonscript

echo 'def load_config(fname):' >> $powerbuttonscript
echo '	newconfig = []' >> $powerbuttonscript
echo '	try:' >> $powerbuttonscript
echo '		with open(fname, "r") as fp:' >> $powerbuttonscript
echo '			for curline in fp:' >> $powerbuttonscript
echo '				if not curline:' >> $powerbuttonscript
echo '					continue' >> $powerbuttonscript
echo '				tmpline = curline.strip()' >> $powerbuttonscript
echo '				if not tmpline:' >> $powerbuttonscript
echo '					continue' >> $powerbuttonscript
echo '				if tmpline[0] == "#":' >> $powerbuttonscript
echo '					continue' >> $powerbuttonscript
echo '				tmppair = tmpline.split("=")' >> $powerbuttonscript
echo '				if len(tmppair) != 2:' >> $powerbuttonscript
echo '					continue' >> $powerbuttonscript
echo '				tempval = 0' >> $powerbuttonscript
echo '				fanval = 0' >> $powerbuttonscript
echo '				try:' >> $powerbuttonscript
echo '					tempval = float(tmppair[0])' >> $powerbuttonscript
echo '					if tempval < 0 or tempval > 100:' >> $powerbuttonscript
echo '						continue' >> $powerbuttonscript
echo '				except:' >> $powerbuttonscript
echo '					continue' >> $powerbuttonscript
echo '				try:' >> $powerbuttonscript
echo '					fanval = int(float(tmppair[1]))' >> $powerbuttonscript
echo '					if fanval < 0 or fanval > 100:' >> $powerbuttonscript
echo '						continue' >> $powerbuttonscript
echo '				except:' >> $powerbuttonscript
echo '					continue' >> $powerbuttonscript
echo '				newconfig.append( "{:5.1f}={}".format(tempval,fanval))' >> $powerbuttonscript
echo '		if len(newconfig) > 0:' >> $powerbuttonscript
echo '			newconfig.sort(reverse=True)' >> $powerbuttonscript
echo '	except:' >> $powerbuttonscript
echo '		return []' >> $powerbuttonscript
echo '	return newconfig' >> $powerbuttonscript

echo 'def temp_check():' >> $powerbuttonscript
echo '	fanconfig = ["65=100", "60=55", "55=10"]' >> $powerbuttonscript
echo '	tmpconfig = load_config("'$daemonconfigfile'")' >> $powerbuttonscript
echo '	if len(tmpconfig) > 0:' >> $powerbuttonscript
echo '		fanconfig = tmpconfig' >> $powerbuttonscript
echo '	address=0x1a' >> $powerbuttonscript
echo '	prevblock=0' >> $powerbuttonscript
echo '	while True:' >> $powerbuttonscript

echo '		try:' >> $powerbuttonscript
echo '			tempfp = open("/sys/class/thermal/thermal_zone0/temp", "r")' >> $powerbuttonscript
echo '			temp = tempfp.readline()' >> $powerbuttonscript
echo '			tempfp.close()' >> $powerbuttonscript
echo '			val = float(int(temp)/1000)' >> $powerbuttonscript
echo '		except IOError:' >> $powerbuttonscript
echo '			val = 0' >> $powerbuttonscript

echo '		block = get_fanspeed(val, fanconfig)' >> $powerbuttonscript
echo '		if block < prevblock:' >> $powerbuttonscript
echo '			time.sleep(30)' >> $powerbuttonscript
echo '		prevblock = block' >> $powerbuttonscript
echo '		try:' >> $powerbuttonscript
echo '			if block > 0:' >> $powerbuttonscript
echo '				bus.write_byte(address,100)' >> $powerbuttonscript
echo '				time.sleep(1)' >> $powerbuttonscript
echo '			bus.write_byte(address,block)' >> $powerbuttonscript
echo '		except IOError:' >> $powerbuttonscript
echo '			temp=""' >> $powerbuttonscript
echo '		time.sleep(30)' >> $powerbuttonscript

echo 'try:' >> $powerbuttonscript
echo '	t1 = Thread(target = shutdown_check)' >> $powerbuttonscript
echo '	t2 = Thread(target = temp_check)' >> $powerbuttonscript
echo '	t1.start()' >> $powerbuttonscript
echo '	t2.start()' >> $powerbuttonscript
echo 'except:' >> $powerbuttonscript
echo '	t1.stop()' >> $powerbuttonscript
echo '	t2.stop()' >> $powerbuttonscript
echo '	GPIO.cleanup()' >> $powerbuttonscript

sudo chmod 755 $powerbuttonscript

argon_create_file $daemonfanservice

# Fan Daemon
echo "[Unit]" >> $daemonfanservice
echo "Description=Argon One Fan and Button Service" >> $daemonfanservice
echo "After=multi-user.target" >> $daemonfanservice
echo '[Service]' >> $daemonfanservice
echo 'Type=simple' >> $daemonfanservice
echo "Restart=always" >> $daemonfanservice
echo "RemainAfterExit=true" >> $daemonfanservice
echo "ExecStart=/usr/bin/python3 $powerbuttonscript" >> $daemonfanservice
echo '[Install]' >> $daemonfanservice
echo "WantedBy=multi-user.target" >> $daemonfanservice

sudo chmod 644 $daemonfanservice

argon_create_file $removescript

# Uninstall Script
echo '#!/bin/bash' >> $removescript
echo 'echo "-------------------------"' >> $removescript
echo 'echo "Argon One Uninstall Tool"' >> $removescript
echo 'echo "-------------------------"' >> $removescript
echo 'echo -n "Press Y to continue:"' >> $removescript
echo 'read -n 1 confirm' >> $removescript
echo 'echo' >> $removescript
echo 'if [ "$confirm" = "y" ]' >> $removescript
echo 'then' >> $removescript
echo '	confirm="Y"' >> $removescript
echo 'fi' >> $removescript
echo '' >> $removescript
echo 'if [ "$confirm" != "Y" ]' >> $removescript
echo 'then' >> $removescript
echo '	echo "Cancelled"' >> $removescript
echo '	exit' >> $removescript
echo 'fi' >> $removescript
echo 'if [ -d "/home/pi/Desktop" ]; then' >> $removescript
echo '	sudo rm "/home/pi/Desktop/argonone-config.desktop"' >> $removescript
echo '	sudo rm "/home/pi/Desktop/argonone-uninstall.desktop"' >> $removescript
echo 'fi' >> $removescript
echo 'if [ -f '$powerbuttonscript' ]; then' >> $removescript
echo '	sudo systemctl stop '$daemonname'.service' >> $removescript
echo '	sudo systemctl disable '$daemonname'.service' >> $removescript
echo '	sudo /usr/bin/python3 '$shutdownscript' uninstall' >> $removescript
echo '	sudo rm '$powerbuttonscript >> $removescript
echo '	sudo rm '$shutdownscript >> $removescript
echo '	sudo rm '$removescript >> $removescript
echo '	echo "Removed Argon One Services."' >> $removescript
echo '	echo "Cleanup will complete after restarting the device."' >> $removescript
echo 'fi' >> $removescript

sudo chmod 755 $removescript

argon_create_file $configscript

# Config Script
echo '#!/bin/bash' >> $configscript
echo 'daemonconfigfile='$daemonconfigfile >> $configscript
echo 'echo "--------------------------------------"' >> $configscript
echo 'echo "Argon One Fan Speed Configuration Tool"' >> $configscript
echo 'echo "--------------------------------------"' >> $configscript
echo 'echo "WARNING: This will remove existing configuration."' >> $configscript
echo 'echo -n "Press Y to continue:"' >> $configscript
echo 'read -n 1 confirm' >> $configscript
echo 'echo' >> $configscript
echo 'if [ "$confirm" = "y" ]' >> $configscript
echo 'then' >> $configscript
echo '	confirm="Y"' >> $configscript
echo 'fi' >> $configscript
echo '' >> $configscript
echo 'if [ "$confirm" != "Y" ]' >> $configscript
echo 'then' >> $configscript
echo '	echo "Cancelled"' >> $configscript
echo '	exit' >> $configscript
echo 'fi' >> $configscript
echo 'echo "Thank you."' >> $configscript

echo 'get_number () {' >> $configscript
echo '	read curnumber' >> $configscript
echo '	if [ -z "$curnumber" ]' >> $configscript
echo '	then' >> $configscript
echo '		echo "-2"' >> $configscript
echo '		return' >> $configscript
echo '	elif [[ $curnumber =~ ^[+-]?[0-9]+$ ]]' >> $configscript
echo '	then' >> $configscript
echo '		if [ $curnumber -lt 0 ]' >> $configscript
echo '		then' >> $configscript
echo '			echo "-1"' >> $configscript
echo '			return' >> $configscript
echo '		elif [ $curnumber -gt 100 ]' >> $configscript
echo '		then' >> $configscript
echo '			echo "-1"' >> $configscript
echo '			return' >> $configscript
echo '		fi	' >> $configscript
echo '		echo $curnumber' >> $configscript
echo '		return' >> $configscript
echo '	fi' >> $configscript
echo '	echo "-1"' >> $configscript
echo '	return' >> $configscript
echo '}' >> $configscript
echo '' >> $configscript

echo 'loopflag=1' >> $configscript
echo 'while [ $loopflag -eq 1 ]' >> $configscript
echo 'do' >> $configscript
echo '	echo' >> $configscript
echo '	echo "Select fan mode:"' >> $configscript
echo '	echo "  1. Always on"' >> $configscript
echo '	echo "  2. Adjust to temperatures (55C, 60C, and 65C)"' >> $configscript
echo '	echo "  3. Customize behavior"' >> $configscript
echo '	echo "  4. Cancel"' >> $configscript
echo '	echo "NOTE: You can also edit $daemonconfigfile directly"' >> $configscript
echo '	echo -n "Enter Number (1-4):"' >> $configscript
echo '	newmode=$( get_number )' >> $configscript
echo '	if [[ $newmode -ge 1 && $newmode -le 4 ]]' >> $configscript
echo '	then' >> $configscript
echo '		loopflag=0' >> $configscript
echo '	fi' >> $configscript
echo 'done' >> $configscript

echo 'echo' >> $configscript
echo 'if [ $newmode -eq 4 ]' >> $configscript
echo 'then' >> $configscript
echo '	echo "Cancelled"' >> $configscript
echo '	exit' >> $configscript
echo 'elif [ $newmode -eq 1 ]' >> $configscript
echo 'then' >> $configscript
echo '	echo "#" > $daemonconfigfile' >> $configscript
echo '	echo "# Argon One Fan Speed Configuration" >> $daemonconfigfile' >> $configscript
echo '	echo "#" >> $daemonconfigfile' >> $configscript
echo '	echo "# Min Temp=Fan Speed" >> $daemonconfigfile' >> $configscript
echo '	echo 1"="100 >> $daemonconfigfile' >> $configscript
echo '	sudo systemctl restart '$daemonname'.service' >> $configscript
echo '	echo "Fan always on."' >> $configscript
echo '	exit' >> $configscript
echo 'elif [ $newmode -eq 2 ]' >> $configscript
echo 'then' >> $configscript
echo '	echo "Please provide fan speeds for the following temperatures:"' >> $configscript
echo '	echo "#" > $daemonconfigfile' >> $configscript
echo '	echo "# Argon One Fan Speed Configuration" >> $daemonconfigfile' >> $configscript
echo '	echo "#" >> $daemonconfigfile' >> $configscript
echo '	echo "# Min Temp=Fan Speed" >> $daemonconfigfile' >> $configscript
echo '	curtemp=55' >> $configscript
echo '	while [ $curtemp -lt 70 ]' >> $configscript
echo '	do' >> $configscript
echo '		errorfanflag=1' >> $configscript
echo '		while [ $errorfanflag -eq 1 ]' >> $configscript
echo '		do' >> $configscript
echo '			echo -n ""$curtemp"C (0-100 only):"' >> $configscript
echo '			curfan=$( get_number )' >> $configscript
echo '			if [ $curfan -ge 0 ]' >> $configscript
echo '			then' >> $configscript
echo '				errorfanflag=0' >> $configscript
echo '			fi' >> $configscript
echo '		done' >> $configscript
echo '		echo $curtemp"="$curfan >> $daemonconfigfile' >> $configscript
echo '		curtemp=$((curtemp+5))' >> $configscript
echo '	done' >> $configscript

echo '	sudo systemctl restart '$daemonname'.service' >> $configscript
echo '	echo "Configuration updated."' >> $configscript
echo '	exit' >> $configscript
echo 'fi' >> $configscript

echo 'echo "Please provide fan speeds and temperature pairs"' >> $configscript
echo 'echo' >> $configscript

echo 'loopflag=1' >> $configscript
echo 'paircounter=0' >> $configscript
echo 'while [ $loopflag -eq 1 ]' >> $configscript
echo 'do' >> $configscript
echo '	errortempflag=1' >> $configscript
echo '	errorfanflag=1' >> $configscript
echo '	while [ $errortempflag -eq 1 ]' >> $configscript
echo '	do' >> $configscript
echo '		echo -n "Provide minimum temperature (in Celsius) then [ENTER]:"' >> $configscript
echo '		curtemp=$( get_number )' >> $configscript
echo '		if [ $curtemp -ge 0 ]' >> $configscript
echo '		then' >> $configscript
echo '			errortempflag=0' >> $configscript
echo '		elif [ $curtemp -eq -2 ]' >> $configscript
echo '		then' >> $configscript
echo '			errortempflag=0' >> $configscript
echo '			errorfanflag=0' >> $configscript
echo '			loopflag=0' >> $configscript
echo '		fi' >> $configscript
echo '	done' >> $configscript
echo '	while [ $errorfanflag -eq 1 ]' >> $configscript
echo '	do' >> $configscript
echo '		echo -n "Provide fan speed for "$curtemp"C (0-100) then [ENTER]:"' >> $configscript
echo '		curfan=$( get_number )' >> $configscript
echo '		if [ $curfan -ge 0 ]' >> $configscript
echo '		then' >> $configscript
echo '			errorfanflag=0' >> $configscript
echo '		elif [ $curfan -eq -2 ]' >> $configscript
echo '		then' >> $configscript
echo '			errortempflag=0' >> $configscript
echo '			errorfanflag=0' >> $configscript
echo '			loopflag=0' >> $configscript
echo '		fi' >> $configscript
echo '	done' >> $configscript
echo '	if [ $loopflag -eq 1 ]' >> $configscript
echo '	then' >> $configscript
echo '		if [ $paircounter -eq 0 ]' >> $configscript
echo '		then' >> $configscript
echo '			echo "#" > $daemonconfigfile' >> $configscript
echo '			echo "# Argon One Fan Speed Configuration" >> $daemonconfigfile' >> $configscript
echo '			echo "#" >> $daemonconfigfile' >> $configscript
echo '			echo "# Min Temp=Fan Speed" >> $daemonconfigfile' >> $configscript
echo '		fi' >> $configscript
echo '		echo $curtemp"="$curfan >> $daemonconfigfile' >> $configscript
echo '		' >> $configscript
echo '		paircounter=$((paircounter+1))' >> $configscript
echo '		' >> $configscript
echo '		echo "* Fan speed will be set to "$curfan" once temperature reaches "$curtemp" C"' >> $configscript
echo '		echo' >> $configscript
echo '	fi' >> $configscript
echo 'done' >> $configscript
echo '' >> $configscript
echo 'echo' >> $configscript
echo 'if [ $paircounter -gt 0 ]' >> $configscript
echo 'then' >> $configscript
echo '	echo "Thank you!  We saved "$paircounter" pairs."' >> $configscript
echo '	sudo systemctl restart '$daemonname'.service' >> $configscript
echo '	echo "Changes should take effect now."' >> $configscript
echo 'else' >> $configscript
echo '	echo "Cancelled, no data saved."' >> $configscript
echo 'fi' >> $configscript

sudo chmod 755 $configscript


sudo systemctl daemon-reload
sudo systemctl enable $daemonname.service

sudo systemctl start $daemonname.service


shortcutfile="/home/pi/Desktop/argonone-config.desktop"
if [ "$CHECKPLATFORM" = "Raspbian" ] && [ -d "/home/pi/Desktop" ]
then
	terminalcmd="lxterminal --working-directory=/home/pi/ -t"
	if  [ -f "/home/pi/.twisteros.twid" ]
	then
		terminalcmd="xfce4-terminal --default-working-directory=/home/pi/ -T"
	fi
	sudo wget http://download.argon40.com/ar1config.png -O /usr/share/pixmaps/ar1config.png --quiet
	sudo wget http://download.argon40.com/ar1uninstall.png -O /usr/share/pixmaps/ar1uninstall.png --quiet
	# Create Shortcuts
	echo "[Desktop Entry]" > $shortcutfile
	echo "Name=Argon One Configuration" >> $shortcutfile
	echo "Comment=Argon One Configuration" >> $shortcutfile
	echo "Icon=/usr/share/pixmaps/ar1config.png" >> $shortcutfile
	echo 'Exec='$terminalcmd' "Argon One Configuration" -e '$configscript >> $shortcutfile
	echo "Type=Application" >> $shortcutfile
	echo "Encoding=UTF-8" >> $shortcutfile
	echo "Terminal=false" >> $shortcutfile
	echo "Categories=None;" >> $shortcutfile
	chmod 755 $shortcutfile
	
	shortcutfile="/home/pi/Desktop/argonone-uninstall.desktop"
	echo "[Desktop Entry]" > $shortcutfile
	echo "Name=Argon One Uninstall" >> $shortcutfile
	echo "Comment=Argon One Uninstall" >> $shortcutfile
	echo "Icon=/usr/share/pixmaps/ar1uninstall.png" >> $shortcutfile
	echo 'Exec='$terminalcmd' -t "Argon One Uninstall" --working-directory=/home/pi/ -e '$removescript >> $shortcutfile
	echo "Type=Application" >> $shortcutfile
	echo "Encoding=UTF-8" >> $shortcutfile
	echo "Terminal=false" >> $shortcutfile
	echo "Categories=None;" >> $shortcutfile
	chmod 755 $shortcutfile
fi

# IR config script
sudo wget https://download.argon40.com/argonone-irconfig.sh -O /usr/bin/argonone-ir --quiet
sudo chmod 755 /usr/bin/argonone-ir

echo "***************************"
echo "Argon One Setup Completed."
echo "***************************"
echo
if [ ! "$CHECKPLATFORM" = "Raspbian" ]
then
		echo "You may need to reboot for changes to take effect"
		echo
fi 
if [ -f $shortcutfile ]; then
	echo Shortcuts created in your desktop.
else
	echo Use 'argonone-config' to configure fan
	echo Use 'argonone-uninstall' to uninstall
fi
echo
curl: (6) Could not resolve host: argon1.sh
josef@RasPi-Testsystem:~ $ curl
curl: try 'curl --help' or 'curl --manual' for more information
josef@RasPi-Testsystem:~ $ curl --help
Usage: curl [options...] <url>
 -d, --data <data>   HTTP POST data
 -f, --fail          Fail silently (no output at all) on HTTP errors
 -h, --help <category> Get help for commands
 -i, --include       Include protocol response headers in the output
 -o, --output <file> Write to file instead of stdout
 -O, --remote-name   Write output to a file named as the remote file
 -s, --silent        Silent mode
 -T, --upload-file <file> Transfer local FILE to destination
 -u, --user <user:password> Server user and password
 -A, --user-agent <name> Send User-Agent <name> to server
 -v, --verbose       Make the operation more talkative
 -V, --version       Show version number and quit

This is not the full help, this menu is stripped into categories.
Use "--help category" to get an overview of all categories.
For all options use the manual or "--help all".
josef@RasPi-Testsystem:~ $ curl https://download.argon40.com/argon1.sh
#!/bin/bash


argon_create_file() {
	if [ -f $1 ]; then
		sudo rm $1
	fi
	sudo touch $1
	sudo chmod 666 $1
}
argon_check_pkg() {
	RESULT=$(dpkg-query -W -f='${Status}\n' "$1" 2> /dev/null | grep "installed")

	if [ "" == "$RESULT" ]; then
		echo "NG"
	else
		echo "OK"
	fi
}

# Check if Raspbian, Ubuntu, others
CHECKPLATFORM="Others"
if [ -f "/etc/os-release" ]
then
	source /etc/os-release
	if [ "$ID" = "raspbian" ]
	then
		CHECKPLATFORM="Raspbian"
	elif [ "$ID" = "ubuntu" ]
	then
		CHECKPLATFORM="Ubuntu"
	fi
fi


if [ "$CHECKPLATFORM" = "Raspbian" ]
then
	pkglist=(raspi-gpio python3-rpi.gpio python3-smbus i2c-tools)	
else
	# Todo handle lgpio
	# Ubuntu has serial and i2c enabled
	pkglist=(python3-rpi.gpio python3-smbus i2c-tools)
fi

for curpkg in ${pkglist[@]}; do
	sudo apt-get install -y $curpkg
	RESULT=$(argon_check_pkg "$curpkg")
	if [ "NG" == "$RESULT" ]
	then
		echo "********************************************************************"
		echo "Please also connect device to the internet and restart installation."
		echo "********************************************************************"
		exit
	fi
done

# Ubuntu Mate for RPi has raspi-config too
command -v raspi-config &> /dev/null
if [ $? -eq 0 ]
then
	# Enable i2c and serial
	sudo raspi-config nonint do_i2c 0
	sudo raspi-config nonint do_serial 2
fi

# Helper variables
daemonname="argononed"
powerbuttonscript=/usr/bin/$daemonname.py
shutdownscript="/lib/systemd/system-shutdown/"$daemonname"-poweroff.py"
daemonconfigfile=/etc/$daemonname.conf
configscript=/usr/bin/argonone-config
removescript=/usr/bin/argonone-uninstall

daemonfanservice=/lib/systemd/system/$daemonname.service
	
if [ ! -f $daemonconfigfile ]; then
	# Generate config file for fan speed
	sudo touch $daemonconfigfile
	sudo chmod 666 $daemonconfigfile
	echo '#' >> $daemonconfigfile
	echo '# Argon One Fan Configuration' >> $daemonconfigfile
	echo '#' >> $daemonconfigfile
	echo '# List below the temperature (Celsius) and fan speed (in percent) pairs' >> $daemonconfigfile
	echo '# Use the following form:' >> $daemonconfigfile
	echo '# min.temperature=speed' >> $daemonconfigfile
	echo '#' >> $daemonconfigfile
	echo '# Example:' >> $daemonconfigfile
	echo '# 55=10' >> $daemonconfigfile
	echo '# 60=55' >> $daemonconfigfile
	echo '# 65=100' >> $daemonconfigfile
	echo '#' >> $daemonconfigfile
	echo '# Above example sets the fan speed to' >> $daemonconfigfile
	echo '#' >> $daemonconfigfile
	echo '# NOTE: Lines begining with # are ignored' >> $daemonconfigfile
	echo '#' >> $daemonconfigfile
	echo '# Type the following at the command line for changes to take effect:' >> $daemonconfigfile
	echo '# sudo systemctl restart '$daemonname'.service' >> $daemonconfigfile
	echo '#' >> $daemonconfigfile
	echo '# Start below:' >> $daemonconfigfile
	echo '55=10' >> $daemonconfigfile
	echo '60=55' >> $daemonconfigfile
	echo '65=100' >> $daemonconfigfile
fi

# Generate script that runs every shutdown event
argon_create_file $shutdownscript

echo "#!/usr/bin/python3" >> $shutdownscript
echo 'import sys' >> $shutdownscript
echo 'import smbus' >> $shutdownscript
echo 'import RPi.GPIO as GPIO' >> $shutdownscript
echo 'rev = GPIO.RPI_REVISION' >> $shutdownscript
echo 'if rev == 2 or rev == 3:' >> $shutdownscript
echo '	bus = smbus.SMBus(1)' >> $shutdownscript
echo 'else:' >> $shutdownscript
echo '	bus = smbus.SMBus(0)' >> $shutdownscript

echo 'if len(sys.argv)>1:' >> $shutdownscript
echo "	bus.write_byte(0x1a,0)"  >> $shutdownscript

# powercut signal
echo '	if sys.argv[1] == "poweroff" or sys.argv[1] == "halt":'  >> $shutdownscript
echo "		try:"  >> $shutdownscript
echo "			bus.write_byte(0x1a,0xFF)"  >> $shutdownscript
echo "		except:"  >> $shutdownscript
echo "			rev=0"  >> $shutdownscript

sudo chmod 755 $shutdownscript

# Generate script to monitor shutdown button

argon_create_file $powerbuttonscript

echo "#!/usr/bin/python3" >> $powerbuttonscript
echo 'import smbus' >> $powerbuttonscript
echo 'import RPi.GPIO as GPIO' >> $powerbuttonscript
echo 'import os' >> $powerbuttonscript
echo 'import time' >> $powerbuttonscript
echo 'from threading import Thread' >> $powerbuttonscript
echo 'rev = GPIO.RPI_REVISION' >> $powerbuttonscript
echo 'if rev == 2 or rev == 3:' >> $powerbuttonscript
echo '	bus = smbus.SMBus(1)' >> $powerbuttonscript
echo 'else:' >> $powerbuttonscript
echo '	bus = smbus.SMBus(0)' >> $powerbuttonscript

echo 'GPIO.setwarnings(False)' >> $powerbuttonscript
echo 'GPIO.setmode(GPIO.BCM)' >> $powerbuttonscript
echo 'shutdown_pin=4' >> $powerbuttonscript
echo 'GPIO.setup(shutdown_pin, GPIO.IN,  pull_up_down=GPIO.PUD_DOWN)' >> $powerbuttonscript

echo 'def shutdown_check():' >> $powerbuttonscript
echo '	while True:' >> $powerbuttonscript
echo '		pulsetime = 1' >> $powerbuttonscript
echo '		GPIO.wait_for_edge(shutdown_pin, GPIO.RISING)' >> $powerbuttonscript
echo '		time.sleep(0.01)' >> $powerbuttonscript
echo '		while GPIO.input(shutdown_pin) == GPIO.HIGH:' >> $powerbuttonscript
echo '			time.sleep(0.01)' >> $powerbuttonscript
echo '			pulsetime += 1' >> $powerbuttonscript
echo '		if pulsetime >=2 and pulsetime <=3:' >> $powerbuttonscript
echo '			os.system("reboot")' >> $powerbuttonscript
echo '		elif pulsetime >=4 and pulsetime <=5:' >> $powerbuttonscript
echo '			os.system("shutdown now -h")' >> $powerbuttonscript

echo 'def get_fanspeed(tempval, configlist):' >> $powerbuttonscript
echo '	for curconfig in configlist:' >> $powerbuttonscript
echo '		curpair = curconfig.split("=")' >> $powerbuttonscript
echo '		tempcfg = float(curpair[0])' >> $powerbuttonscript
echo '		fancfg = int(float(curpair[1]))' >> $powerbuttonscript
echo '		if tempval >= tempcfg:' >> $powerbuttonscript
echo '			if fancfg < 1:' >> $powerbuttonscript
echo '				return 0' >> $powerbuttonscript
echo '			elif fancfg < 25:' >> $powerbuttonscript
echo '				return 25' >> $powerbuttonscript
echo '			return fancfg' >> $powerbuttonscript
echo '	return 0' >> $powerbuttonscript

echo 'def load_config(fname):' >> $powerbuttonscript
echo '	newconfig = []' >> $powerbuttonscript
echo '	try:' >> $powerbuttonscript
echo '		with open(fname, "r") as fp:' >> $powerbuttonscript
echo '			for curline in fp:' >> $powerbuttonscript
echo '				if not curline:' >> $powerbuttonscript
echo '					continue' >> $powerbuttonscript
echo '				tmpline = curline.strip()' >> $powerbuttonscript
echo '				if not tmpline:' >> $powerbuttonscript
echo '					continue' >> $powerbuttonscript
echo '				if tmpline[0] == "#":' >> $powerbuttonscript
echo '					continue' >> $powerbuttonscript
echo '				tmppair = tmpline.split("=")' >> $powerbuttonscript
echo '				if len(tmppair) != 2:' >> $powerbuttonscript
echo '					continue' >> $powerbuttonscript
echo '				tempval = 0' >> $powerbuttonscript
echo '				fanval = 0' >> $powerbuttonscript
echo '				try:' >> $powerbuttonscript
echo '					tempval = float(tmppair[0])' >> $powerbuttonscript
echo '					if tempval < 0 or tempval > 100:' >> $powerbuttonscript
echo '						continue' >> $powerbuttonscript
echo '				except:' >> $powerbuttonscript
echo '					continue' >> $powerbuttonscript
echo '				try:' >> $powerbuttonscript
echo '					fanval = int(float(tmppair[1]))' >> $powerbuttonscript
echo '					if fanval < 0 or fanval > 100:' >> $powerbuttonscript
echo '						continue' >> $powerbuttonscript
echo '				except:' >> $powerbuttonscript
echo '					continue' >> $powerbuttonscript
echo '				newconfig.append( "{:5.1f}={}".format(tempval,fanval))' >> $powerbuttonscript
echo '		if len(newconfig) > 0:' >> $powerbuttonscript
echo '			newconfig.sort(reverse=True)' >> $powerbuttonscript
echo '	except:' >> $powerbuttonscript
echo '		return []' >> $powerbuttonscript
echo '	return newconfig' >> $powerbuttonscript

echo 'def temp_check():' >> $powerbuttonscript
echo '	fanconfig = ["65=100", "60=55", "55=10"]' >> $powerbuttonscript
echo '	tmpconfig = load_config("'$daemonconfigfile'")' >> $powerbuttonscript
echo '	if len(tmpconfig) > 0:' >> $powerbuttonscript
echo '		fanconfig = tmpconfig' >> $powerbuttonscript
echo '	address=0x1a' >> $powerbuttonscript
echo '	prevblock=0' >> $powerbuttonscript
echo '	while True:' >> $powerbuttonscript

echo '		try:' >> $powerbuttonscript
echo '			tempfp = open("/sys/class/thermal/thermal_zone0/temp", "r")' >> $powerbuttonscript
echo '			temp = tempfp.readline()' >> $powerbuttonscript
echo '			tempfp.close()' >> $powerbuttonscript
echo '			val = float(int(temp)/1000)' >> $powerbuttonscript
echo '		except IOError:' >> $powerbuttonscript
echo '			val = 0' >> $powerbuttonscript

echo '		block = get_fanspeed(val, fanconfig)' >> $powerbuttonscript
echo '		if block < prevblock:' >> $powerbuttonscript
echo '			time.sleep(30)' >> $powerbuttonscript
echo '		prevblock = block' >> $powerbuttonscript
echo '		try:' >> $powerbuttonscript
echo '			if block > 0:' >> $powerbuttonscript
echo '				bus.write_byte(address,100)' >> $powerbuttonscript
echo '				time.sleep(1)' >> $powerbuttonscript
echo '			bus.write_byte(address,block)' >> $powerbuttonscript
echo '		except IOError:' >> $powerbuttonscript
echo '			temp=""' >> $powerbuttonscript
echo '		time.sleep(30)' >> $powerbuttonscript

echo 'try:' >> $powerbuttonscript
echo '	t1 = Thread(target = shutdown_check)' >> $powerbuttonscript
echo '	t2 = Thread(target = temp_check)' >> $powerbuttonscript
echo '	t1.start()' >> $powerbuttonscript
echo '	t2.start()' >> $powerbuttonscript
echo 'except:' >> $powerbuttonscript
echo '	t1.stop()' >> $powerbuttonscript
echo '	t2.stop()' >> $powerbuttonscript
echo '	GPIO.cleanup()' >> $powerbuttonscript

sudo chmod 755 $powerbuttonscript

argon_create_file $daemonfanservice

# Fan Daemon
echo "[Unit]" >> $daemonfanservice
echo "Description=Argon One Fan and Button Service" >> $daemonfanservice
echo "After=multi-user.target" >> $daemonfanservice
echo '[Service]' >> $daemonfanservice
echo 'Type=simple' >> $daemonfanservice
echo "Restart=always" >> $daemonfanservice
echo "RemainAfterExit=true" >> $daemonfanservice
echo "ExecStart=/usr/bin/python3 $powerbuttonscript" >> $daemonfanservice
echo '[Install]' >> $daemonfanservice
echo "WantedBy=multi-user.target" >> $daemonfanservice

sudo chmod 644 $daemonfanservice

argon_create_file $removescript

# Uninstall Script
echo '#!/bin/bash' >> $removescript
echo 'echo "-------------------------"' >> $removescript
echo 'echo "Argon One Uninstall Tool"' >> $removescript
echo 'echo "-------------------------"' >> $removescript
echo 'echo -n "Press Y to continue:"' >> $removescript
echo 'read -n 1 confirm' >> $removescript
echo 'echo' >> $removescript
echo 'if [ "$confirm" = "y" ]' >> $removescript
echo 'then' >> $removescript
echo '	confirm="Y"' >> $removescript
echo 'fi' >> $removescript
echo '' >> $removescript
echo 'if [ "$confirm" != "Y" ]' >> $removescript
echo 'then' >> $removescript
echo '	echo "Cancelled"' >> $removescript
echo '	exit' >> $removescript
echo 'fi' >> $removescript
echo 'if [ -d "/home/pi/Desktop" ]; then' >> $removescript
echo '	sudo rm "/home/pi/Desktop/argonone-config.desktop"' >> $removescript
echo '	sudo rm "/home/pi/Desktop/argonone-uninstall.desktop"' >> $removescript
echo 'fi' >> $removescript
echo 'if [ -f '$powerbuttonscript' ]; then' >> $removescript
echo '	sudo systemctl stop '$daemonname'.service' >> $removescript
echo '	sudo systemctl disable '$daemonname'.service' >> $removescript
echo '	sudo /usr/bin/python3 '$shutdownscript' uninstall' >> $removescript
echo '	sudo rm '$powerbuttonscript >> $removescript
echo '	sudo rm '$shutdownscript >> $removescript
echo '	sudo rm '$removescript >> $removescript
echo '	echo "Removed Argon One Services."' >> $removescript
echo '	echo "Cleanup will complete after restarting the device."' >> $removescript
echo 'fi' >> $removescript

sudo chmod 755 $removescript

argon_create_file $configscript

# Config Script
echo '#!/bin/bash' >> $configscript
echo 'daemonconfigfile='$daemonconfigfile >> $configscript
echo 'echo "--------------------------------------"' >> $configscript
echo 'echo "Argon One Fan Speed Configuration Tool"' >> $configscript
echo 'echo "--------------------------------------"' >> $configscript
echo 'echo "WARNING: This will remove existing configuration."' >> $configscript
echo 'echo -n "Press Y to continue:"' >> $configscript
echo 'read -n 1 confirm' >> $configscript
echo 'echo' >> $configscript
echo 'if [ "$confirm" = "y" ]' >> $configscript
echo 'then' >> $configscript
echo '	confirm="Y"' >> $configscript
echo 'fi' >> $configscript
echo '' >> $configscript
echo 'if [ "$confirm" != "Y" ]' >> $configscript
echo 'then' >> $configscript
echo '	echo "Cancelled"' >> $configscript
echo '	exit' >> $configscript
echo 'fi' >> $configscript
echo 'echo "Thank you."' >> $configscript

echo 'get_number () {' >> $configscript
echo '	read curnumber' >> $configscript
echo '	if [ -z "$curnumber" ]' >> $configscript
echo '	then' >> $configscript
echo '		echo "-2"' >> $configscript
echo '		return' >> $configscript
echo '	elif [[ $curnumber =~ ^[+-]?[0-9]+$ ]]' >> $configscript
echo '	then' >> $configscript
echo '		if [ $curnumber -lt 0 ]' >> $configscript
echo '		then' >> $configscript
echo '			echo "-1"' >> $configscript
echo '			return' >> $configscript
echo '		elif [ $curnumber -gt 100 ]' >> $configscript
echo '		then' >> $configscript
echo '			echo "-1"' >> $configscript
echo '			return' >> $configscript
echo '		fi	' >> $configscript
echo '		echo $curnumber' >> $configscript
echo '		return' >> $configscript
echo '	fi' >> $configscript
echo '	echo "-1"' >> $configscript
echo '	return' >> $configscript
echo '}' >> $configscript
echo '' >> $configscript

echo 'loopflag=1' >> $configscript
echo 'while [ $loopflag -eq 1 ]' >> $configscript
echo 'do' >> $configscript
echo '	echo' >> $configscript
echo '	echo "Select fan mode:"' >> $configscript
echo '	echo "  1. Always on"' >> $configscript
echo '	echo "  2. Adjust to temperatures (55C, 60C, and 65C)"' >> $configscript
echo '	echo "  3. Customize behavior"' >> $configscript
echo '	echo "  4. Cancel"' >> $configscript
echo '	echo "NOTE: You can also edit $daemonconfigfile directly"' >> $configscript
echo '	echo -n "Enter Number (1-4):"' >> $configscript
echo '	newmode=$( get_number )' >> $configscript
echo '	if [[ $newmode -ge 1 && $newmode -le 4 ]]' >> $configscript
echo '	then' >> $configscript
echo '		loopflag=0' >> $configscript
echo '	fi' >> $configscript
echo 'done' >> $configscript

echo 'echo' >> $configscript
echo 'if [ $newmode -eq 4 ]' >> $configscript
echo 'then' >> $configscript
echo '	echo "Cancelled"' >> $configscript
echo '	exit' >> $configscript
echo 'elif [ $newmode -eq 1 ]' >> $configscript
echo 'then' >> $configscript
echo '	echo "#" > $daemonconfigfile' >> $configscript
echo '	echo "# Argon One Fan Speed Configuration" >> $daemonconfigfile' >> $configscript
echo '	echo "#" >> $daemonconfigfile' >> $configscript
echo '	echo "# Min Temp=Fan Speed" >> $daemonconfigfile' >> $configscript
echo '	echo 1"="100 >> $daemonconfigfile' >> $configscript
echo '	sudo systemctl restart '$daemonname'.service' >> $configscript
echo '	echo "Fan always on."' >> $configscript
echo '	exit' >> $configscript
echo 'elif [ $newmode -eq 2 ]' >> $configscript
echo 'then' >> $configscript
echo '	echo "Please provide fan speeds for the following temperatures:"' >> $configscript
echo '	echo "#" > $daemonconfigfile' >> $configscript
echo '	echo "# Argon One Fan Speed Configuration" >> $daemonconfigfile' >> $configscript
echo '	echo "#" >> $daemonconfigfile' >> $configscript
echo '	echo "# Min Temp=Fan Speed" >> $daemonconfigfile' >> $configscript
echo '	curtemp=55' >> $configscript
echo '	while [ $curtemp -lt 70 ]' >> $configscript
echo '	do' >> $configscript
echo '		errorfanflag=1' >> $configscript
echo '		while [ $errorfanflag -eq 1 ]' >> $configscript
echo '		do' >> $configscript
echo '			echo -n ""$curtemp"C (0-100 only):"' >> $configscript
echo '			curfan=$( get_number )' >> $configscript
echo '			if [ $curfan -ge 0 ]' >> $configscript
echo '			then' >> $configscript
echo '				errorfanflag=0' >> $configscript
echo '			fi' >> $configscript
echo '		done' >> $configscript
echo '		echo $curtemp"="$curfan >> $daemonconfigfile' >> $configscript
echo '		curtemp=$((curtemp+5))' >> $configscript
echo '	done' >> $configscript

echo '	sudo systemctl restart '$daemonname'.service' >> $configscript
echo '	echo "Configuration updated."' >> $configscript
echo '	exit' >> $configscript
echo 'fi' >> $configscript

echo 'echo "Please provide fan speeds and temperature pairs"' >> $configscript
echo 'echo' >> $configscript

echo 'loopflag=1' >> $configscript
echo 'paircounter=0' >> $configscript
echo 'while [ $loopflag -eq 1 ]' >> $configscript
echo 'do' >> $configscript
echo '	errortempflag=1' >> $configscript
echo '	errorfanflag=1' >> $configscript
echo '	while [ $errortempflag -eq 1 ]' >> $configscript
echo '	do' >> $configscript
echo '		echo -n "Provide minimum temperature (in Celsius) then [ENTER]:"' >> $configscript
echo '		curtemp=$( get_number )' >> $configscript
echo '		if [ $curtemp -ge 0 ]' >> $configscript
echo '		then' >> $configscript
echo '			errortempflag=0' >> $configscript
echo '		elif [ $curtemp -eq -2 ]' >> $configscript
echo '		then' >> $configscript
echo '			errortempflag=0' >> $configscript
echo '			errorfanflag=0' >> $configscript
echo '			loopflag=0' >> $configscript
echo '		fi' >> $configscript
echo '	done' >> $configscript
echo '	while [ $errorfanflag -eq 1 ]' >> $configscript
echo '	do' >> $configscript
echo '		echo -n "Provide fan speed for "$curtemp"C (0-100) then [ENTER]:"' >> $configscript
echo '		curfan=$( get_number )' >> $configscript
echo '		if [ $curfan -ge 0 ]' >> $configscript
echo '		then' >> $configscript
echo '			errorfanflag=0' >> $configscript
echo '		elif [ $curfan -eq -2 ]' >> $configscript
echo '		then' >> $configscript
echo '			errortempflag=0' >> $configscript
echo '			errorfanflag=0' >> $configscript
echo '			loopflag=0' >> $configscript
echo '		fi' >> $configscript
echo '	done' >> $configscript
echo '	if [ $loopflag -eq 1 ]' >> $configscript
echo '	then' >> $configscript
echo '		if [ $paircounter -eq 0 ]' >> $configscript
echo '		then' >> $configscript
echo '			echo "#" > $daemonconfigfile' >> $configscript
echo '			echo "# Argon One Fan Speed Configuration" >> $daemonconfigfile' >> $configscript
echo '			echo "#" >> $daemonconfigfile' >> $configscript
echo '			echo "# Min Temp=Fan Speed" >> $daemonconfigfile' >> $configscript
echo '		fi' >> $configscript
echo '		echo $curtemp"="$curfan >> $daemonconfigfile' >> $configscript
echo '		' >> $configscript
echo '		paircounter=$((paircounter+1))' >> $configscript
echo '		' >> $configscript
echo '		echo "* Fan speed will be set to "$curfan" once temperature reaches "$curtemp" C"' >> $configscript
echo '		echo' >> $configscript
echo '	fi' >> $configscript
echo 'done' >> $configscript
echo '' >> $configscript
echo 'echo' >> $configscript
echo 'if [ $paircounter -gt 0 ]' >> $configscript
echo 'then' >> $configscript
echo '	echo "Thank you!  We saved "$paircounter" pairs."' >> $configscript
echo '	sudo systemctl restart '$daemonname'.service' >> $configscript
echo '	echo "Changes should take effect now."' >> $configscript
echo 'else' >> $configscript
echo '	echo "Cancelled, no data saved."' >> $configscript
echo 'fi' >> $configscript

sudo chmod 755 $configscript


sudo systemctl daemon-reload
sudo systemctl enable $daemonname.service

sudo systemctl start $daemonname.service


shortcutfile="/home/pi/Desktop/argonone-config.desktop"
if [ "$CHECKPLATFORM" = "Raspbian" ] && [ -d "/home/pi/Desktop" ]
then
	terminalcmd="lxterminal --working-directory=/home/pi/ -t"
	if  [ -f "/home/pi/.twisteros.twid" ]
	then
		terminalcmd="xfce4-terminal --default-working-directory=/home/pi/ -T"
	fi
	sudo wget http://download.argon40.com/ar1config.png -O /usr/share/pixmaps/ar1config.png --quiet
	sudo wget http://download.argon40.com/ar1uninstall.png -O /usr/share/pixmaps/ar1uninstall.png --quiet
	# Create Shortcuts
	echo "[Desktop Entry]" > $shortcutfile
	echo "Name=Argon One Configuration" >> $shortcutfile
	echo "Comment=Argon One Configuration" >> $shortcutfile
	echo "Icon=/usr/share/pixmaps/ar1config.png" >> $shortcutfile
	echo 'Exec='$terminalcmd' "Argon One Configuration" -e '$configscript >> $shortcutfile
	echo "Type=Application" >> $shortcutfile
	echo "Encoding=UTF-8" >> $shortcutfile
	echo "Terminal=false" >> $shortcutfile
	echo "Categories=None;" >> $shortcutfile
	chmod 755 $shortcutfile
	
	shortcutfile="/home/pi/Desktop/argonone-uninstall.desktop"
	echo "[Desktop Entry]" > $shortcutfile
	echo "Name=Argon One Uninstall" >> $shortcutfile
	echo "Comment=Argon One Uninstall" >> $shortcutfile
	echo "Icon=/usr/share/pixmaps/ar1uninstall.png" >> $shortcutfile
	echo 'Exec='$terminalcmd' -t "Argon One Uninstall" --working-directory=/home/pi/ -e '$removescript >> $shortcutfile
	echo "Type=Application" >> $shortcutfile
	echo "Encoding=UTF-8" >> $shortcutfile
	echo "Terminal=false" >> $shortcutfile
	echo "Categories=None;" >> $shortcutfile
	chmod 755 $shortcutfile
fi

# IR config script
sudo wget https://download.argon40.com/argonone-irconfig.sh -O /usr/bin/argonone-ir --quiet
sudo chmod 755 /usr/bin/argonone-ir

echo "***************************"
echo "Argon One Setup Completed."
echo "***************************"
echo
if [ ! "$CHECKPLATFORM" = "Raspbian" ]
then
		echo "You may need to reboot for changes to take effect"
		echo
fi 
if [ -f $shortcutfile ]; then
	echo Shortcuts created in your desktop.
else
	echo Use 'argonone-config' to configure fan
	echo Use 'argonone-uninstall' to uninstall
fi
echo
josef@RasPi-Testsystem:~ $ curl https://download.argon40.com/argon1.sh | bash
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100 21560  100 21560    0     0  23009      0 --:--:-- --:--:-- --:--:-- 23009
Paketlisten werden gelesen… Fertig
Abhängigkeitsbaum wird aufgebaut… Fertig
Statusinformationen werden eingelesen… Fertig
python3-rpi.gpio ist schon die neueste Version (0.7.0-0.2+b2).
0 aktualisiert, 0 neu installiert, 0 zu entfernen und 0 nicht aktualisiert.
Paketlisten werden gelesen… Fertig
Abhängigkeitsbaum wird aufgebaut… Fertig
Statusinformationen werden eingelesen… Fertig
python3-smbus ist schon die neueste Version (4.2-1+b1).
0 aktualisiert, 0 neu installiert, 0 zu entfernen und 0 nicht aktualisiert.
Paketlisten werden gelesen… Fertig
Abhängigkeitsbaum wird aufgebaut… Fertig
Statusinformationen werden eingelesen… Fertig
i2c-tools ist schon die neueste Version (4.2-1+b1).
0 aktualisiert, 0 neu installiert, 0 zu entfernen und 0 nicht aktualisiert.
***************************
Argon One Setup Completed.
***************************

You may need to reboot for changes to take effect

Use argonone-config to configure fan
Use argonone-uninstall to uninstall

josef@RasPi-Testsystem:~ $ sudo curl https://download.argon40.com/argon1.sh | bash
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100 21560  100 21560    0     0  22766      0 --:--:-- --:--:-- --:--:-- 22742
Paketlisten werden gelesen… Fertig
Abhängigkeitsbaum wird aufgebaut… Fertig
Statusinformationen werden eingelesen… Fertig
python3-rpi.gpio ist schon die neueste Version (0.7.0-0.2+b2).
0 aktualisiert, 0 neu installiert, 0 zu entfernen und 0 nicht aktualisiert.
Paketlisten werden gelesen… Fertig
Abhängigkeitsbaum wird aufgebaut… Fertig
Statusinformationen werden eingelesen… Fertig
python3-smbus ist schon die neueste Version (4.2-1+b1).
0 aktualisiert, 0 neu installiert, 0 zu entfernen und 0 nicht aktualisiert.
Paketlisten werden gelesen… Fertig
Abhängigkeitsbaum wird aufgebaut… Fertig
Statusinformationen werden eingelesen… Fertig
i2c-tools ist schon die neueste Version (4.2-1+b1).
0 aktualisiert, 0 neu installiert, 0 zu entfernen und 0 nicht aktualisiert.
***************************
Argon One Setup Completed.
***************************

You may need to reboot for changes to take effect

Use argonone-config to configure fan
Use argonone-uninstall to uninstall

josef@RasPi-Testsystem:~ $ nano setupBasic.sh 
josef@RasPi-Testsystem:~ $ nano rm setupBasic.sh 
josef@RasPi-Testsystem:~ $ rm setupBasic.sh 
josef@RasPi-Testsystem:~ $ wget https://raw.githubusercontent.com/rallyeaon/RasPi-Server/master/setupBasic.sh
--2023-03-01 11:37:07--  https://raw.githubusercontent.com/rallyeaon/RasPi-Server/master/setupBasic.sh
Auflösen des Hostnamens raw.githubusercontent.com (raw.githubusercontent.com)… 185.199.108.133, 185.199.109.133, 185.199.110.133, ...
Verbindungsaufbau zu raw.githubusercontent.com (raw.githubusercontent.com)|185.199.108.133|:443 … verbunden.
HTTP-Anforderung gesendet, auf Antwort wird gewartet … 200 OK
Länge: 2228 (2,2K) [text/plain]
Wird in »setupBasic.sh« gespeichert.

setupBasic.sh       100%[===================>]   2,18K  --.-KB/s    in 0,001s  

2023-03-01 11:37:07 (1,65 MB/s) - »setupBasic.sh« gespeichert [2228/2228]

josef@RasPi-Testsystem:~ $ chmod 755 setupBasic.sh 
josef@RasPi-Testsystem:~ $ nano setupBasic.sh 
josef@RasPi-Testsystem:~ $ sudo ./setupBasic.sh 
OK:1 http://deb.debian.org/debian bullseye InRelease
OK:2 http://deb.debian.org/debian bullseye-updates InRelease
OK:3 http://security.debian.org/debian-security bullseye-security InRelease
OK:4 http://archive.raspberrypi.org/debian bullseye InRelease
Paketlisten werden gelesen… Fertig                
Abhängigkeitsbaum wird aufgebaut… Fertig
Statusinformationen werden eingelesen… Fertig
Alle Pakete sind aktuell.
Paketlisten werden gelesen… Fertig
Abhängigkeitsbaum wird aufgebaut… Fertig
Statusinformationen werden eingelesen… Fertig
Paketaktualisierung (Upgrade) wird berechnet… Fertig
0 aktualisiert, 0 neu installiert, 0 zu entfernen und 0 nicht aktualisiert.
Generating locales (this might take a while)...
  de_DE.UTF-8... done
  en_GB.UTF-8... done
  en_US.UTF-8... done
Generation complete.
Paketlisten werden gelesen… Fertig
Abhängigkeitsbaum wird aufgebaut… Fertig
Statusinformationen werden eingelesen… Fertig
ntpdate ist schon die neueste Version (1:4.2.8p15+dfsg-1).
0 aktualisiert, 0 neu installiert, 0 zu entfernen und 0 nicht aktualisiert.
mkdir: das Verzeichnis „/mnt/M2Data“ kann nicht angelegt werden: Die Datei existiert bereits
mkdir: das Verzeichnis „/mnt/share“ kann nicht angelegt werden: Die Datei existiert bereits
mkdir: das Verzeichnis „/mnt/SonosSpeak“ kann nicht angelegt werden: Die Datei existiert bereits
Update Raspberry firmware ? (y/N): 
#!/bin/bash


argon_create_file() {
	if [ -f $1 ]; then
		sudo rm $1
	fi
	sudo touch $1
	sudo chmod 666 $1
}
argon_check_pkg() {
	RESULT=$(dpkg-query -W -f='${Status}\n' "$1" 2> /dev/null | grep "installed")

	if [ "" == "$RESULT" ]; then
		echo "NG"
	else
		echo "OK"
	fi
}

# Check if Raspbian, Ubuntu, others
CHECKPLATFORM="Others"
if [ -f "/etc/os-release" ]
then
	source /etc/os-release
	if [ "$ID" = "raspbian" ]
	then
		CHECKPLATFORM="Raspbian"
	elif [ "$ID" = "ubuntu" ]
	then
		CHECKPLATFORM="Ubuntu"
	fi
fi


if [ "$CHECKPLATFORM" = "Raspbian" ]
then
	pkglist=(raspi-gpio python3-rpi.gpio python3-smbus i2c-tools)	
else
	# Todo handle lgpio
	# Ubuntu has serial and i2c enabled
	pkglist=(python3-rpi.gpio python3-smbus i2c-tools)
fi

for curpkg in ${pkglist[@]}; do
	sudo apt-get install -y $curpkg
	RESULT=$(argon_check_pkg "$curpkg")
	if [ "NG" == "$RESULT" ]
	then
		echo "********************************************************************"
		echo "Please also connect device to the internet and restart installation."
		echo "********************************************************************"
		exit
	fi
done

# Ubuntu Mate for RPi has raspi-config too
command -v raspi-config &> /dev/null
if [ $? -eq 0 ]
then
	# Enable i2c and serial
	sudo raspi-config nonint do_i2c 0
	sudo raspi-config nonint do_serial 2
fi

# Helper variables
daemonname="argononed"
powerbuttonscript=/usr/bin/$daemonname.py
shutdownscript="/lib/systemd/system-shutdown/"$daemonname"-poweroff.py"
daemonconfigfile=/etc/$daemonname.conf
configscript=/usr/bin/argonone-config
removescript=/usr/bin/argonone-uninstall

daemonfanservice=/lib/systemd/system/$daemonname.service
	
if [ ! -f $daemonconfigfile ]; then
	# Generate config file for fan speed
	sudo touch $daemonconfigfile
	sudo chmod 666 $daemonconfigfile
	echo '#' >> $daemonconfigfile
	echo '# Argon One Fan Configuration' >> $daemonconfigfile
	echo '#' >> $daemonconfigfile
	echo '# List below the temperature (Celsius) and fan speed (in percent) pairs' >> $daemonconfigfile
	echo '# Use the following form:' >> $daemonconfigfile
	echo '# min.temperature=speed' >> $daemonconfigfile
	echo '#' >> $daemonconfigfile
	echo '# Example:' >> $daemonconfigfile
	echo '# 55=10' >> $daemonconfigfile
	echo '# 60=55' >> $daemonconfigfile
	echo '# 65=100' >> $daemonconfigfile
	echo '#' >> $daemonconfigfile
	echo '# Above example sets the fan speed to' >> $daemonconfigfile
	echo '#' >> $daemonconfigfile
	echo '# NOTE: Lines begining with # are ignored' >> $daemonconfigfile
	echo '#' >> $daemonconfigfile
	echo '# Type the following at the command line for changes to take effect:' >> $daemonconfigfile
	echo '# sudo systemctl restart '$daemonname'.service' >> $daemonconfigfile
	echo '#' >> $daemonconfigfile
	echo '# Start below:' >> $daemonconfigfile
	echo '55=10' >> $daemonconfigfile
	echo '60=55' >> $daemonconfigfile
	echo '65=100' >> $daemonconfigfile
fi

# Generate script that runs every shutdown event
argon_create_file $shutdownscript

echo "#!/usr/bin/python3" >> $shutdownscript
echo 'import sys' >> $shutdownscript
echo 'import smbus' >> $shutdownscript
echo 'import RPi.GPIO as GPIO' >> $shutdownscript
echo 'rev = GPIO.RPI_REVISION' >> $shutdownscript
echo 'if rev == 2 or rev == 3:' >> $shutdownscript
echo '	bus = smbus.SMBus(1)' >> $shutdownscript
echo 'else:' >> $shutdownscript
echo '	bus = smbus.SMBus(0)' >> $shutdownscript

echo 'if len(sys.argv)>1:' >> $shutdownscript
echo "	bus.write_byte(0x1a,0)"  >> $shutdownscript

# powercut signal
echo '	if sys.argv[1] == "poweroff" or sys.argv[1] == "halt":'  >> $shutdownscript
echo "		try:"  >> $shutdownscript
echo "			bus.write_byte(0x1a,0xFF)"  >> $shutdownscript
echo "		except:"  >> $shutdownscript
echo "			rev=0"  >> $shutdownscript

sudo chmod 755 $shutdownscript

# Generate script to monitor shutdown button

argon_create_file $powerbuttonscript

echo "#!/usr/bin/python3" >> $powerbuttonscript
echo 'import smbus' >> $powerbuttonscript
echo 'import RPi.GPIO as GPIO' >> $powerbuttonscript
echo 'import os' >> $powerbuttonscript
echo 'import time' >> $powerbuttonscript
echo 'from threading import Thread' >> $powerbuttonscript
echo 'rev = GPIO.RPI_REVISION' >> $powerbuttonscript
echo 'if rev == 2 or rev == 3:' >> $powerbuttonscript
echo '	bus = smbus.SMBus(1)' >> $powerbuttonscript
echo 'else:' >> $powerbuttonscript
echo '	bus = smbus.SMBus(0)' >> $powerbuttonscript

echo 'GPIO.setwarnings(False)' >> $powerbuttonscript
echo 'GPIO.setmode(GPIO.BCM)' >> $powerbuttonscript
echo 'shutdown_pin=4' >> $powerbuttonscript
echo 'GPIO.setup(shutdown_pin, GPIO.IN,  pull_up_down=GPIO.PUD_DOWN)' >> $powerbuttonscript

echo 'def shutdown_check():' >> $powerbuttonscript
echo '	while True:' >> $powerbuttonscript
echo '		pulsetime = 1' >> $powerbuttonscript
echo '		GPIO.wait_for_edge(shutdown_pin, GPIO.RISING)' >> $powerbuttonscript
echo '		time.sleep(0.01)' >> $powerbuttonscript
echo '		while GPIO.input(shutdown_pin) == GPIO.HIGH:' >> $powerbuttonscript
echo '			time.sleep(0.01)' >> $powerbuttonscript
echo '			pulsetime += 1' >> $powerbuttonscript
echo '		if pulsetime >=2 and pulsetime <=3:' >> $powerbuttonscript
echo '			os.system("reboot")' >> $powerbuttonscript
echo '		elif pulsetime >=4 and pulsetime <=5:' >> $powerbuttonscript
echo '			os.system("shutdown now -h")' >> $powerbuttonscript

echo 'def get_fanspeed(tempval, configlist):' >> $powerbuttonscript
echo '	for curconfig in configlist:' >> $powerbuttonscript
echo '		curpair = curconfig.split("=")' >> $powerbuttonscript
echo '		tempcfg = float(curpair[0])' >> $powerbuttonscript
echo '		fancfg = int(float(curpair[1]))' >> $powerbuttonscript
echo '		if tempval >= tempcfg:' >> $powerbuttonscript
echo '			if fancfg < 1:' >> $powerbuttonscript
echo '				return 0' >> $powerbuttonscript
echo '			elif fancfg < 25:' >> $powerbuttonscript
echo '				return 25' >> $powerbuttonscript
echo '			return fancfg' >> $powerbuttonscript
echo '	return 0' >> $powerbuttonscript

echo 'def load_config(fname):' >> $powerbuttonscript
echo '	newconfig = []' >> $powerbuttonscript
echo '	try:' >> $powerbuttonscript
echo '		with open(fname, "r") as fp:' >> $powerbuttonscript
echo '			for curline in fp:' >> $powerbuttonscript
echo '				if not curline:' >> $powerbuttonscript
echo '					continue' >> $powerbuttonscript
echo '				tmpline = curline.strip()' >> $powerbuttonscript
echo '				if not tmpline:' >> $powerbuttonscript
echo '					continue' >> $powerbuttonscript
echo '				if tmpline[0] == "#":' >> $powerbuttonscript
echo '					continue' >> $powerbuttonscript
echo '				tmppair = tmpline.split("=")' >> $powerbuttonscript
echo '				if len(tmppair) != 2:' >> $powerbuttonscript
echo '					continue' >> $powerbuttonscript
echo '				tempval = 0' >> $powerbuttonscript
echo '				fanval = 0' >> $powerbuttonscript
echo '				try:' >> $powerbuttonscript
echo '					tempval = float(tmppair[0])' >> $powerbuttonscript
echo '					if tempval < 0 or tempval > 100:' >> $powerbuttonscript
echo '						continue' >> $powerbuttonscript
echo '				except:' >> $powerbuttonscript
echo '					continue' >> $powerbuttonscript
echo '				try:' >> $powerbuttonscript
echo '					fanval = int(float(tmppair[1]))' >> $powerbuttonscript
echo '					if fanval < 0 or fanval > 100:' >> $powerbuttonscript
echo '						continue' >> $powerbuttonscript
echo '				except:' >> $powerbuttonscript
echo '					continue' >> $powerbuttonscript
echo '				newconfig.append( "{:5.1f}={}".format(tempval,fanval))' >> $powerbuttonscript
echo '		if len(newconfig) > 0:' >> $powerbuttonscript
echo '			newconfig.sort(reverse=True)' >> $powerbuttonscript
echo '	except:' >> $powerbuttonscript
echo '		return []' >> $powerbuttonscript
echo '	return newconfig' >> $powerbuttonscript

echo 'def temp_check():' >> $powerbuttonscript
echo '	fanconfig = ["65=100", "60=55", "55=10"]' >> $powerbuttonscript
echo '	tmpconfig = load_config("'$daemonconfigfile'")' >> $powerbuttonscript
echo '	if len(tmpconfig) > 0:' >> $powerbuttonscript
echo '		fanconfig = tmpconfig' >> $powerbuttonscript
echo '	address=0x1a' >> $powerbuttonscript
echo '	prevblock=0' >> $powerbuttonscript
echo '	while True:' >> $powerbuttonscript

echo '		try:' >> $powerbuttonscript
echo '			tempfp = open("/sys/class/thermal/thermal_zone0/temp", "r")' >> $powerbuttonscript
echo '			temp = tempfp.readline()' >> $powerbuttonscript
echo '			tempfp.close()' >> $powerbuttonscript
echo '			val = float(int(temp)/1000)' >> $powerbuttonscript
echo '		except IOError:' >> $powerbuttonscript
echo '			val = 0' >> $powerbuttonscript

echo '		block = get_fanspeed(val, fanconfig)' >> $powerbuttonscript
echo '		if block < prevblock:' >> $powerbuttonscript
echo '			time.sleep(30)' >> $powerbuttonscript
echo '		prevblock = block' >> $powerbuttonscript
echo '		try:' >> $powerbuttonscript
echo '			if block > 0:' >> $powerbuttonscript
echo '				bus.write_byte(address,100)' >> $powerbuttonscript
echo '				time.sleep(1)' >> $powerbuttonscript
echo '			bus.write_byte(address,block)' >> $powerbuttonscript
echo '		except IOError:' >> $powerbuttonscript
echo '			temp=""' >> $powerbuttonscript
echo '		time.sleep(30)' >> $powerbuttonscript

echo 'try:' >> $powerbuttonscript
echo '	t1 = Thread(target = shutdown_check)' >> $powerbuttonscript
echo '	t2 = Thread(target = temp_check)' >> $powerbuttonscript
echo '	t1.start()' >> $powerbuttonscript
echo '	t2.start()' >> $powerbuttonscript
echo 'except:' >> $powerbuttonscript
echo '	t1.stop()' >> $powerbuttonscript
echo '	t2.stop()' >> $powerbuttonscript
echo '	GPIO.cleanup()' >> $powerbuttonscript

sudo chmod 755 $powerbuttonscript

argon_create_file $daemonfanservice

# Fan Daemon
echo "[Unit]" >> $daemonfanservice
echo "Description=Argon One Fan and Button Service" >> $daemonfanservice
echo "After=multi-user.target" >> $daemonfanservice
echo '[Service]' >> $daemonfanservice
echo 'Type=simple' >> $daemonfanservice
echo "Restart=always" >> $daemonfanservice
echo "RemainAfterExit=true" >> $daemonfanservice
echo "ExecStart=/usr/bin/python3 $powerbuttonscript" >> $daemonfanservice
echo '[Install]' >> $daemonfanservice
echo "WantedBy=multi-user.target" >> $daemonfanservice

sudo chmod 644 $daemonfanservice

argon_create_file $removescript

# Uninstall Script
echo '#!/bin/bash' >> $removescript
echo 'echo "-------------------------"' >> $removescript
echo 'echo "Argon One Uninstall Tool"' >> $removescript
echo 'echo "-------------------------"' >> $removescript
echo 'echo -n "Press Y to continue:"' >> $removescript
echo 'read -n 1 confirm' >> $removescript
echo 'echo' >> $removescript
echo 'if [ "$confirm" = "y" ]' >> $removescript
echo 'then' >> $removescript
echo '	confirm="Y"' >> $removescript
echo 'fi' >> $removescript
echo '' >> $removescript
echo 'if [ "$confirm" != "Y" ]' >> $removescript
echo 'then' >> $removescript
echo '	echo "Cancelled"' >> $removescript
echo '	exit' >> $removescript
echo 'fi' >> $removescript
echo 'if [ -d "/home/pi/Desktop" ]; then' >> $removescript
echo '	sudo rm "/home/pi/Desktop/argonone-config.desktop"' >> $removescript
echo '	sudo rm "/home/pi/Desktop/argonone-uninstall.desktop"' >> $removescript
echo 'fi' >> $removescript
echo 'if [ -f '$powerbuttonscript' ]; then' >> $removescript
echo '	sudo systemctl stop '$daemonname'.service' >> $removescript
echo '	sudo systemctl disable '$daemonname'.service' >> $removescript
echo '	sudo /usr/bin/python3 '$shutdownscript' uninstall' >> $removescript
echo '	sudo rm '$powerbuttonscript >> $removescript
echo '	sudo rm '$shutdownscript >> $removescript
echo '	sudo rm '$removescript >> $removescript
echo '	echo "Removed Argon One Services."' >> $removescript
echo '	echo "Cleanup will complete after restarting the device."' >> $removescript
echo 'fi' >> $removescript

sudo chmod 755 $removescript

argon_create_file $configscript

# Config Script
echo '#!/bin/bash' >> $configscript
echo 'daemonconfigfile='$daemonconfigfile >> $configscript
echo 'echo "--------------------------------------"' >> $configscript
echo 'echo "Argon One Fan Speed Configuration Tool"' >> $configscript
echo 'echo "--------------------------------------"' >> $configscript
echo 'echo "WARNING: This will remove existing configuration."' >> $configscript
echo 'echo -n "Press Y to continue:"' >> $configscript
echo 'read -n 1 confirm' >> $configscript
echo 'echo' >> $configscript
echo 'if [ "$confirm" = "y" ]' >> $configscript
echo 'then' >> $configscript
echo '	confirm="Y"' >> $configscript
echo 'fi' >> $configscript
echo '' >> $configscript
echo 'if [ "$confirm" != "Y" ]' >> $configscript
echo 'then' >> $configscript
echo '	echo "Cancelled"' >> $configscript
echo '	exit' >> $configscript
echo 'fi' >> $configscript
echo 'echo "Thank you."' >> $configscript

echo 'get_number () {' >> $configscript
echo '	read curnumber' >> $configscript
echo '	if [ -z "$curnumber" ]' >> $configscript
echo '	then' >> $configscript
echo '		echo "-2"' >> $configscript
echo '		return' >> $configscript
echo '	elif [[ $curnumber =~ ^[+-]?[0-9]+$ ]]' >> $configscript
echo '	then' >> $configscript
echo '		if [ $curnumber -lt 0 ]' >> $configscript
echo '		then' >> $configscript
echo '			echo "-1"' >> $configscript
echo '			return' >> $configscript
echo '		elif [ $curnumber -gt 100 ]' >> $configscript
echo '		then' >> $configscript
echo '			echo "-1"' >> $configscript
echo '			return' >> $configscript
echo '		fi	' >> $configscript
echo '		echo $curnumber' >> $configscript
echo '		return' >> $configscript
echo '	fi' >> $configscript
echo '	echo "-1"' >> $configscript
echo '	return' >> $configscript
echo '}' >> $configscript
echo '' >> $configscript

echo 'loopflag=1' >> $configscript
echo 'while [ $loopflag -eq 1 ]' >> $configscript
echo 'do' >> $configscript
echo '	echo' >> $configscript
echo '	echo "Select fan mode:"' >> $configscript
echo '	echo "  1. Always on"' >> $configscript
echo '	echo "  2. Adjust to temperatures (55C, 60C, and 65C)"' >> $configscript
echo '	echo "  3. Customize behavior"' >> $configscript
echo '	echo "  4. Cancel"' >> $configscript
echo '	echo "NOTE: You can also edit $daemonconfigfile directly"' >> $configscript
echo '	echo -n "Enter Number (1-4):"' >> $configscript
echo '	newmode=$( get_number )' >> $configscript
echo '	if [[ $newmode -ge 1 && $newmode -le 4 ]]' >> $configscript
echo '	then' >> $configscript
echo '		loopflag=0' >> $configscript
echo '	fi' >> $configscript
echo 'done' >> $configscript

echo 'echo' >> $configscript
echo 'if [ $newmode -eq 4 ]' >> $configscript
echo 'then' >> $configscript
echo '	echo "Cancelled"' >> $configscript
echo '	exit' >> $configscript
echo 'elif [ $newmode -eq 1 ]' >> $configscript
echo 'then' >> $configscript
echo '	echo "#" > $daemonconfigfile' >> $configscript
echo '	echo "# Argon One Fan Speed Configuration" >> $daemonconfigfile' >> $configscript
echo '	echo "#" >> $daemonconfigfile' >> $configscript
echo '	echo "# Min Temp=Fan Speed" >> $daemonconfigfile' >> $configscript
echo '	echo 1"="100 >> $daemonconfigfile' >> $configscript
echo '	sudo systemctl restart '$daemonname'.service' >> $configscript
echo '	echo "Fan always on."' >> $configscript
echo '	exit' >> $configscript
echo 'elif [ $newmode -eq 2 ]' >> $configscript
echo 'then' >> $configscript
echo '	echo "Please provide fan speeds for the following temperatures:"' >> $configscript
echo '	echo "#" > $daemonconfigfile' >> $configscript
echo '	echo "# Argon One Fan Speed Configuration" >> $daemonconfigfile' >> $configscript
echo '	echo "#" >> $daemonconfigfile' >> $configscript
echo '	echo "# Min Temp=Fan Speed" >> $daemonconfigfile' >> $configscript
echo '	curtemp=55' >> $configscript
echo '	while [ $curtemp -lt 70 ]' >> $configscript
echo '	do' >> $configscript
echo '		errorfanflag=1' >> $configscript
echo '		while [ $errorfanflag -eq 1 ]' >> $configscript
echo '		do' >> $configscript
echo '			echo -n ""$curtemp"C (0-100 only):"' >> $configscript
echo '			curfan=$( get_number )' >> $configscript
echo '			if [ $curfan -ge 0 ]' >> $configscript
echo '			then' >> $configscript
echo '				errorfanflag=0' >> $configscript
echo '			fi' >> $configscript
echo '		done' >> $configscript
echo '		echo $curtemp"="$curfan >> $daemonconfigfile' >> $configscript
echo '		curtemp=$((curtemp+5))' >> $configscript
echo '	done' >> $configscript

echo '	sudo systemctl restart '$daemonname'.service' >> $configscript
echo '	echo "Configuration updated."' >> $configscript
echo '	exit' >> $configscript
echo 'fi' >> $configscript

echo 'echo "Please provide fan speeds and temperature pairs"' >> $configscript
echo 'echo' >> $configscript

echo 'loopflag=1' >> $configscript
echo 'paircounter=0' >> $configscript
echo 'while [ $loopflag -eq 1 ]' >> $configscript
echo 'do' >> $configscript
echo '	errortempflag=1' >> $configscript
echo '	errorfanflag=1' >> $configscript
echo '	while [ $errortempflag -eq 1 ]' >> $configscript
echo '	do' >> $configscript
echo '		echo -n "Provide minimum temperature (in Celsius) then [ENTER]:"' >> $configscript
echo '		curtemp=$( get_number )' >> $configscript
echo '		if [ $curtemp -ge 0 ]' >> $configscript
echo '		then' >> $configscript
echo '			errortempflag=0' >> $configscript
echo '		elif [ $curtemp -eq -2 ]' >> $configscript
echo '		then' >> $configscript
echo '			errortempflag=0' >> $configscript
echo '			errorfanflag=0' >> $configscript
echo '			loopflag=0' >> $configscript
echo '		fi' >> $configscript
echo '	done' >> $configscript
echo '	while [ $errorfanflag -eq 1 ]' >> $configscript
echo '	do' >> $configscript
echo '		echo -n "Provide fan speed for "$curtemp"C (0-100) then [ENTER]:"' >> $configscript
echo '		curfan=$( get_number )' >> $configscript
echo '		if [ $curfan -ge 0 ]' >> $configscript
echo '		then' >> $configscript
echo '			errorfanflag=0' >> $configscript
echo '		elif [ $curfan -eq -2 ]' >> $configscript
echo '		then' >> $configscript
echo '			errortempflag=0' >> $configscript
echo '			errorfanflag=0' >> $configscript
echo '			loopflag=0' >> $configscript
echo '		fi' >> $configscript
echo '	done' >> $configscript
echo '	if [ $loopflag -eq 1 ]' >> $configscript
echo '	then' >> $configscript
echo '		if [ $paircounter -eq 0 ]' >> $configscript
echo '		then' >> $configscript
echo '			echo "#" > $daemonconfigfile' >> $configscript
echo '			echo "# Argon One Fan Speed Configuration" >> $daemonconfigfile' >> $configscript
echo '			echo "#" >> $daemonconfigfile' >> $configscript
echo '			echo "# Min Temp=Fan Speed" >> $daemonconfigfile' >> $configscript
echo '		fi' >> $configscript
echo '		echo $curtemp"="$curfan >> $daemonconfigfile' >> $configscript
echo '		' >> $configscript
echo '		paircounter=$((paircounter+1))' >> $configscript
echo '		' >> $configscript
echo '		echo "* Fan speed will be set to "$curfan" once temperature reaches "$curtemp" C"' >> $configscript
echo '		echo' >> $configscript
echo '	fi' >> $configscript
echo 'done' >> $configscript
echo '' >> $configscript
echo 'echo' >> $configscript
echo 'if [ $paircounter -gt 0 ]' >> $configscript
echo 'then' >> $configscript
echo '	echo "Thank you!  We saved "$paircounter" pairs."' >> $configscript
echo '	sudo systemctl restart '$daemonname'.service' >> $configscript
echo '	echo "Changes should take effect now."' >> $configscript
echo 'else' >> $configscript
echo '	echo "Cancelled, no data saved."' >> $configscript
echo 'fi' >> $configscript

sudo chmod 755 $configscript


sudo systemctl daemon-reload
sudo systemctl enable $daemonname.service

sudo systemctl start $daemonname.service


shortcutfile="/home/pi/Desktop/argonone-config.desktop"
if [ "$CHECKPLATFORM" = "Raspbian" ] && [ -d "/home/pi/Desktop" ]
then
	terminalcmd="lxterminal --working-directory=/home/pi/ -t"
	if  [ -f "/home/pi/.twisteros.twid" ]
	then
		terminalcmd="xfce4-terminal --default-working-directory=/home/pi/ -T"
	fi
	sudo wget http://download.argon40.com/ar1config.png -O /usr/share/pixmaps/ar1config.png --quiet
	sudo wget http://download.argon40.com/ar1uninstall.png -O /usr/share/pixmaps/ar1uninstall.png --quiet
	# Create Shortcuts
	echo "[Desktop Entry]" > $shortcutfile
	echo "Name=Argon One Configuration" >> $shortcutfile
	echo "Comment=Argon One Configuration" >> $shortcutfile
	echo "Icon=/usr/share/pixmaps/ar1config.png" >> $shortcutfile
	echo 'Exec='$terminalcmd' "Argon One Configuration" -e '$configscript >> $shortcutfile
	echo "Type=Application" >> $shortcutfile
	echo "Encoding=UTF-8" >> $shortcutfile
	echo "Terminal=false" >> $shortcutfile
	echo "Categories=None;" >> $shortcutfile
	chmod 755 $shortcutfile
	
	shortcutfile="/home/pi/Desktop/argonone-uninstall.desktop"
	echo "[Desktop Entry]" > $shortcutfile
	echo "Name=Argon One Uninstall" >> $shortcutfile
	echo "Comment=Argon One Uninstall" >> $shortcutfile
	echo "Icon=/usr/share/pixmaps/ar1uninstall.png" >> $shortcutfile
	echo 'Exec='$terminalcmd' -t "Argon One Uninstall" --working-directory=/home/pi/ -e '$removescript >> $shortcutfile
	echo "Type=Application" >> $shortcutfile
	echo "Encoding=UTF-8" >> $shortcutfile
	echo "Terminal=false" >> $shortcutfile
	echo "Categories=None;" >> $shortcutfile
	chmod 755 $shortcutfile
fi

# IR config script
sudo wget https://download.argon40.com/argonone-irconfig.sh -O /usr/bin/argonone-ir --quiet
sudo chmod 755 /usr/bin/argonone-ir

echo "***************************"
echo "Argon One Setup Completed."
echo "***************************"
echo
if [ ! "$CHECKPLATFORM" = "Raspbian" ]
then
		echo "You may need to reboot for changes to take effect"
		echo
fi 
if [ -f $shortcutfile ]; then
	echo Shortcuts created in your desktop.
else
	echo Use 'argonone-config' to configure fan
	echo Use 'argonone-uninstall' to uninstall
fi
echo
A reboot is strongly recommended
josef@RasPi-Testsystem:~ $ nano setupBasic.sh 
josef@RasPi-Testsystem:~ $ nano setupBasic.sh 
josef@RasPi-Testsystem:~ $ 
josef@RasPi-Testsystem:~ $ nano setupBasic.sh 
josef@RasPi-Testsystem:~ $ sudo ./setupBasic.sh 
OK:1 http://deb.debian.org/debian bullseye InRelease
OK:2 http://security.debian.org/debian-security bullseye-security InRelease
OK:3 http://deb.debian.org/debian bullseye-updates InRelease
OK:4 http://archive.raspberrypi.org/debian bullseye InRelease
Paketlisten werden gelesen… Fertig
Abhängigkeitsbaum wird aufgebaut… Fertig
Statusinformationen werden eingelesen… Fertig
Alle Pakete sind aktuell.
Paketlisten werden gelesen… Fertig
Abhängigkeitsbaum wird aufgebaut… Fertig
Statusinformationen werden eingelesen… Fertig
Paketaktualisierung (Upgrade) wird berechnet… Fertig
0 aktualisiert, 0 neu installiert, 0 zu entfernen und 0 nicht aktualisiert.
Generating locales (this might take a while)...
  de_DE.UTF-8... done
  en_GB.UTF-8... done
  en_US.UTF-8... done
Generation complete.
Paketlisten werden gelesen… Fertig
Abhängigkeitsbaum wird aufgebaut… Fertig
Statusinformationen werden eingelesen… Fertig
ntpdate ist schon die neueste Version (1:4.2.8p15+dfsg-1).
0 aktualisiert, 0 neu installiert, 0 zu entfernen und 0 nicht aktualisiert.
Update Raspberry firmware ? (y/N):  
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100 21560  100 21560    0     0  23434      0 --:--:-- --:--:-- --:--:-- 23434
Paketlisten werden gelesen… Fertig
Abhängigkeitsbaum wird aufgebaut… Fertig
Statusinformationen werden eingelesen… Fertig
python3-rpi.gpio ist schon die neueste Version (0.7.0-0.2+b2).
0 aktualisiert, 0 neu installiert, 0 zu entfernen und 0 nicht aktualisiert.
Paketlisten werden gelesen… Fertig
Abhängigkeitsbaum wird aufgebaut… Fertig
Statusinformationen werden eingelesen… Fertig
python3-smbus ist schon die neueste Version (4.2-1+b1).
0 aktualisiert, 0 neu installiert, 0 zu entfernen und 0 nicht aktualisiert.
Paketlisten werden gelesen… Fertig
Abhängigkeitsbaum wird aufgebaut… Fertig
Statusinformationen werden eingelesen… Fertig
i2c-tools ist schon die neueste Version (4.2-1+b1).
0 aktualisiert, 0 neu installiert, 0 zu entfernen und 0 nicht aktualisiert.
***************************
Argon One Setup Completed.
***************************

You may need to reboot for changes to take effect

Use argonone-config to configure fan
Use argonone-uninstall to uninstall

A reboot is strongly recommended
josef@RasPi-Testsystem:~ $ nano setupBasic.sh 
josef@RasPi-Testsystem:~ $ nano setupBasic.sh 

  GNU nano 5.4                      setupBasic.sh *                             
    NEW_GPU_MEM=1
    set_config_var gpu_mem "$NEW_GPU_MEM" /boot/config.txt
fi

# as the RasPi doesn't have a system-clock let's install ntpdata
apt -y install ntpdate

# backup /etc/fstab
cp /etc/fstab /etc/fstab.ok

# create directories used at a later point in time
if [ ! -d "/mnt/M2Data" ]; then
   mkdir /mnt/M2Data
fi
if [ ! -d "/mnt/share" ]; then
   mkdir /mnt/share
fi
if [ ! -d "/mnt/SonosSpeak" ]; then
   mkdir /mnt/SonosSpeak
fi

# install support for Argon40 case
curl https://download.argon40.com/argon1.sh | bash


# rpi-update shouldn't be part of regular maintenance but may be part when re-installing a system
while true; do

read -p "Update Raspberry firmware ? (y/N): " yn
yn=${yn,,}
if [[ $yn = "" ]] ; then
   yn=n
fi
case $yn in 
        [yn] ) break;;
        * ) echo Unexpected input;;
esac

done

if [[ "$yn" = "y" ]]; then
   rpi-update;
fi

# Reboot
echo "A reboot is strongly recommended"

