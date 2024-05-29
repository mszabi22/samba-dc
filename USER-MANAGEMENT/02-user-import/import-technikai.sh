#!/bin/bash
while IFS=, read -r username password surname givenname
do
#	JELSZO=`pwgen 8 1`
    JELSZO=$password
clear
echo "Technikai dolgozó hozzáadása..."
    samba-tool user create --must-change-at-next-login --surname="$surname" --given-name="$givenname" --mail-address="$username@crnl.hu" $username $JELSZO
echo "Technikai dolgozó csoporthoz adása..."
    samba-tool group addmembers technikai $username;
echo "Technikai dolgozó szervezeti egységhez adása..."
    samba-tool user move $username "ou=Technikai,ou=Dolgozók"
echo "HOME létrehozása..."
    mkdir -p /home/$username; chmod -R 777 /home/$username;
    echo "$group,$username,$JELSZO" >> /home/pingvin/new-worker.csv
done < technikai.csv