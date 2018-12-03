#!/bin/bash
# First release:20181127
# create by Albion
# ver 1.4 20181203

# Summary:
# Find  file exist over some days and compress with tar, then delete it.
# You can use this shell script with logrotate.

############ CHANGE ME ############
target="*.log"                 
days="5"                                                 
############ CHANGE ME ############

cd /var/log	

find -type f -name "$target" -mtime +$days -exec tar -cpzf $(date +%F).tar.gz {}  \;

find -type f -name "$target" -mtime +$days -exec rm -rf {} \;

if [ ! -e "/var/log/autobackup.log" ]; then
        touch /var/log/autobackup.log
fi

if [ ! -e "$(date +%F).tar.gz" ]; then
	echo "Backup target not found at $(date "+%Y-%m-%d %H:%M:%S")" >> /var/log/autobackup.log
else
        echo "Backup success at $(date "+%Y-%m-%d %H:%M:%S")" >> /var/log/autobackup.log
fi



