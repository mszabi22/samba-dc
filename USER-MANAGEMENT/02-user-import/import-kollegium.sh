#!/bin/bash
while IFS=, read -r username password surname givenname
do
#	JELSZO=`pwgen 8 1`
    JELSZO=$password
clear
echo "$surname $givenname kollégiumi dolgozó hozzáadása..."
    samba-tool user create --must-change-at-next-login --script-path="kollegium.cmd" --surname="$surname" --given-name="$givenname" --mail-address="$username@crnl.hu" $username $JELSZO
echo "Kollégiumi dolgozó csoporthoz adása..."
    samba-tool group addmembers titkarsag $username;
echo "Kollégiumi dolgozó szervezeti egységhez adása..."
    samba-tool user move $username "ou=Kollégium,ou=Dolgozók"
echo "HOME létrehozása..."
    mkdir -p /home/$username; chmod -R 777 /home/$username;
    echo "$group,$username,$JELSZO" >> /home/pingvin/new-worker.csv
done < kollegium.csv