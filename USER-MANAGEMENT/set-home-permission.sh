#!/bin/bash
DOMAIN="domain"

#for username in `ls -1 /home/ | grep -v majorsza | grep -v pingvin | grep -v samba | grep -v BACKUP`; do
for username in `samba-tool user list`; do
echo    chown -R "$username:$DOMAIN\domain users" /home/$username
done

