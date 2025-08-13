/usr/local/samba/bin/samba-tool domain backup restore \
    --backup-file=BACKUP/samba-backup-2025-08-13.tar.bz2 \
    --targetdir=/usr/local/samba \
    --newservername=samba-dc \
    --realm=SAMBA.DOMAIN.LAN \
    --domain=SAMBA

chown -R root:root /usr/local/samba