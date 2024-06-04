#!/bin/bash
DOMAIN="domain"

while IFS=, read -r username password surname givenname
do
#	JELSZO=`pwgen 8 1`
    JELSZO=$password
clear
echo "$surname $givenname tanár hozzáadása..."
    samba-tool user create --must-change-at-next-login --script-path="staff.cmd" --surname="$surname" --given-name="$givenname" --mail-address="$username@crnl.hu" $username $JELSZO
echo "Staff csoporthoz adása..."
    samba-tool group addmembers staff $username;
    samba-tool group addmembers tanar $username;
    samba-tool group addmembers diak $username;
echo "Staff szervezeti egységhez adása..."
    samba-tool user move $username "ou=Staff,ou=Dolgozók"
echo "HOME létrehozása..."
    mkdir -p /home/$username; chmod -R 777 /home/$username;
    chown -R "$username:$DOMAIN\domain users" /home/$username

    echo "$group,$username,$JELSZO" >> /home/pingvin/new-worker.csv
done < tanarok.csv