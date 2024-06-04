#!/bin/bash
QUOTA="2G"
for username in `ls -1 /home/ | grep -v majorsza | grep -v pingvin | grep -v samba | grep -v BACKUP`; do
    setquota -u $username $QUOTA $QUOTA 0 0 /home
    quota -vs $username
done
