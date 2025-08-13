#!/bin/bash
echo "Backup..."
systemctl stop samba
tar -cvzf /root/samba-before-restore-$(date +%F).tar.gz /usr/local/samba


echo "Restore..."
/usr/local/samba/bin/samba-tool domain backup restore \
    --backup-file=BACKUP/samba-backup-2025-08-13.tar.bz2 \
    --targetdir=/usr/local/samba \
    --newservername=samba-dc \
    --realm=SAMBA.DOMAIN.LAN \
    --domain=SAMBA

chown -R root:root /usr/local/samba
systemctl start samba