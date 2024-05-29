#!/bin/bash

apt install mc samba smbclient krb5-user krb5-config winbind libpam-winbind libnss-winbind 
mv /etc/samba/smb.conf /etc/samba/smb.conf.bak
samba-tool domain provision

cp /var/lib/samba/private/krb5.conf /etc/
systemctl stop smbd nmbd winbind
systemctl disable smbd nmbd winbind
systemctl unmask samba-ad-dc
systemctl start samba-ad-dc
systemctl enable samba-ad-dc 
smbclient -L localhost -U%
samba-tool domain level show 

samba-tool domain passwordsettings set --history-length=3 --min-pwd-age=0 --min-pwd-length=8 --max-pwd-age=180 --account-lockout-duration=5 --complexity=off
samba-tool domain passwordsettings show

echo "Download RSAT for Windows: https://www.microsoft.com/hu-hu/download/details.aspx?id=45520"

