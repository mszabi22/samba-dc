#!/bin/bash
DATUM=`+%Y%m%d-%H%M`
clear
mv /usr/local/samba/etc/samba/smb.conf /usr/local/samba/etc/samba/smb.conf-$DATUM
cp /etc/krb5.conf /etc/krb5.conf-$DATUM.bak

echo "SAMBA Domain Controller létrehozása..."
samba-tool domain provision --use-rfc2307 --interactive
cp /usr/local/samba/var/lib/samba/private/krb5.conf /etc/krb5.conf

systemctl stop samba;systemctl start samba

echo "SAMBA Domain Controller jelszóházirend beállítása..."
samba-tool domain passwordsettings set --history-length=1 --min-pwd-age=0 --min-pwd-length=8 --max-pwd-age=365 --account-lockout-duration=5 --complexity=off
#samba-tool domain passwordsettings show

echo "
Install RSAT for Windows via PowerShell: 
Add-WindowsCapability -Online -Name Rsat.ActiveDirectory.DS-LDS.Tools
Add-WindowsCapability -Online -Name Rsat.Dns.Tools~~~~0.0.1.0
"

