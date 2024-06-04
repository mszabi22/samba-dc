#!/bin/bash
DOMAIN="domain"

while IFS=, read -r username password surname givenname
do
#	JELSZO=`pwgen 8 1`
    JELSZO=$password
clear
echo "$surname $givenname gazdasági dolgozó hozzáadása..."
    samba-tool user create --must-change-at-next-login --script-path="gazdasagi.cmd" --surname="$surname" --given-name="$givenname" --mail-address="$username@crnl.hu" $username $JELSZO
echo "Gazdasági dolgozó csoporthoz adása..."
    samba-tool group addmembers gazdasagi $username;
echo "Gazdasági dolgozó szervezeti egységhez adása..."
    samba-tool user move $username "ou=Gazdasági,ou=Dolgozók"
echo "HOME létrehozása..."
    mkdir -p /home/$username; chmod -R 777 /home/$username;
    chown -R "$username:$DOMAIN\domain users" /home/$username
    
    echo "$group,$username,$JELSZO" >> /home/pingvin/new-worker.csv
done < gazdasagi.csv