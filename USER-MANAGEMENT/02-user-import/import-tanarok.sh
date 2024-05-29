#!/bin/bash
while IFS=, read -r username password surname givenname
do
#	JELSZO=`pwgen 8 1`
    JELSZO=$password
clear
echo "Tanár hozzáadása..."
    samba-tool user create --must-change-at-next-login --script-path="tanar.cmd" --surname="$surname" --given-name="$givenname" --mail-address="$username@crnl.hu" $username $JELSZO
echo "Tanár csoporthoz adása..."
    samba-tool group addmembers tanar $username;
echo "Tanár szervezeti egységhez adása..."
    samba-tool user move $username "ou=Tanárok,ou=Dolgozók"
echo "HOME létrehozása..."
    mkdir -p /home/$username; chmod -R 777 /home/$username;
    echo "$group,$username,$JELSZO" >> /home/pingvin/new-worker.csv
done < tanarok.csv