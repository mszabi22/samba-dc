#!/bin/bash
DOMAIN="domain"

for username in `samba-tool user list`; do
if [ ! -d /home/$username ]; then
    mkdir -p /home/$username;
fi
    chown -R "$username:$DOMAIN\domain users" /home/$username
done

