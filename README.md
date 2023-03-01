# RasPi-Server
This Repository contains scripts and information to setup resp. re-store my RasPi-Server

Scripts for setup raspberryPi

Here are some short Scripts for setup a new raspberry und do some configuration inside. All scripts are designed more or less from the FHEM point of view. After download - the script should be executed with sudo.

`sudo ./<scriptname>`
or
`sudo bash <scriptname>`

Short description the Basic Script in sort of usage:

* Partitions will shrink the expanded rootfs to a user-defined size and create an ext4-partition named M2Data on the available space 
* Basic will setup all Basic things like software-update, GPU-memory, optional FW-update
* FHEMData will restore the most recent backup from remote backupsystem
