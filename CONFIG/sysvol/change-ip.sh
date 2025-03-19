#!/bin/bash
cp *.cmd /usr/local/samba/var/lib/samba/sysvol/samba.crnl.lan/scripts
cd /usr/local/samba/var/lib/samba/sysvol/samba.crnl.lan/scripts
sed -i 's/IP/10.0.0.240/g' *.cmd
chmod 777 /usr/local/samba/var/lib/samba/sysvol/samba.crnl.lan/scripts/*
chmod +x /usr/local/samba/var/lib/samba/sysvol/samba.crnl.lan/scripts/*