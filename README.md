# RasPi-Server
This Repository contains scripts and information to setup resp. re-store my RasPi-Server

Scripts for setup raspberryPi

Here are some short Scripts for setup a new raspberry und do some configuration inside. All scripts are designed more or less from the FHEM point of view. After download - the scripts should not be executed with sudo.

`<scriptname>`
or if not chmod 755
`bash <scriptname>`

Short description the Basic Script in sort of usage:

* setupPartitions will shrink the expanded rootfs to a user-defined size and create an ext4-partition named M2Data on the available space 
* setupBasic will setup all Basic things like software-update, GPU-memory, optional FW-update
* setupSamba will install samba and create smbusers for myself and cruella. Furthermore the script recovers the backup of the samba-configuration and copies it into /etc/samba/smb.conf. If no backup can be found a warning will be displayed.
* restoreFHEMData will restore FHEM's most recent configuration-backup from remote backupsystem and restore it to /opt/fhemdocker. If no backup can be found a warning will be displayed.
* restoreHASSData will restore Home Assistant's most recent configuration-backup from remote backupsystem and restore it to /opt/homeassistant. If no backup can be found a warning will be displayed.
* restoreMQConfig will restore mosquitto's most recent configuration-backup from remote backupsystem and restore it to /opt/mosquitto. If no backup can be found a warning will be displayed.
* setupDocker install the docker-software on our machine and add the current user to group docker
* portainer.yml holds the initial portainer configuration for portainer only
* mosquitto.yml holds configuration for mosquitto docker which is needed for communication FHEM <-> Home Assistant
* sonos2mqtt.yml holds configuration for sonos2mqtt docker which is provides communication platform FHEM -> Sonos Speaker
* fhem.yml holds configuration for FHEM docker
* HASS.yml holds configuration for Home Assistant docker
* deCONZ.yml holds configuration for my CONBEE II deCONZ docker
* alexa-fhem.yml holds configuration for FHEM-connection to Alexa
* miniDLNA.yml holds configuration for minidlna docker
# Download set of scripts
see within the script
