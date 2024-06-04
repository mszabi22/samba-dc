#!/bin/bash
QUOTA="2G"

#for username in `samba-tool user list`; do
for username in `ls -1 /home/ | grep -v majorsza | grep -v pingvin | grep -v samba | grep -v BACKUP`; do
    setquota -u $username $QUOTA $QUOTA 0 0 /home
done
repquota -vs /home