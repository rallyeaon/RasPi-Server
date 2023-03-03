# RasPi-Server
This Repository contains scripts and information to setup resp. re-store my RasPi-Server

Scripts for setup raspberryPi

Here are some short Scripts for setup a new raspberry und do some configuration inside. All scripts are designed more or less from the FHEM point of view. After download - the script should be executed with sudo.

`<scriptname>`
or if not chmod 755
`bash <scriptname>`

Short description the Basic Script in sort of usage:

* setupPartitions will shrink the expanded rootfs to a user-defined size and create an ext4-partition named M2Data on the available space 
* setupBasic will setup all Basic things like software-update, GPU-memory, optional FW-update
* setupSamba will install samba and create smbusers for myself and cruella
* restoreFHEMData will restore FHEM's most recent configuration-backup from remote backupsystem and restore it to /opt/fhemdocker
* restoreHASSData will restore Home Assistant's most recent configuration-backup from remote backupsystem and restore it to /opt/homeassistant
* restoreMQConfig will restore mosquitto's most recent configuration-backup from remote backupsystem and restore it to /opt/mosquitto
* installDocker install the docker-software on our machine and add the current user to group docker
