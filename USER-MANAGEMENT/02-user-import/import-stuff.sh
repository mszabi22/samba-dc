#!/bin/bash
while IFS=, read -r username password surname givenname
do
#	JELSZO=`pwgen 8 1`
    JELSZO=$password
clear
echo "$surname $givenname stuff hozzáadása..."
    samba-tool user create --must-change-at-next-login --script-path="stuff.cmd" --surname="$surname" --given-name="$givenname" --mail-address="$username@crnl.hu" $username $JELSZO
echo "Stuff csoporthoz adása..."
    samba-tool group addmembers stuff $username;
    samba-tool group addmembers "Domain Admins" $username;
    samba-tool group addmembers tanar $username;
    samba-tool group addmembers diak $username;
    samba-tool group addmembers gazdasagi $username;
    samba-tool group addmembers titkarsag $username;
    samba-tool group addmembers kollegium $username;
    samba-tool group addmembers konyvtar $username;
echo "Stuff szervezeti egységhez adása..."
    samba-tool user move $username "ou=Stuff,ou=Dolgozók"
echo "HOME létrehozása..."
    mkdir -p /home/$username; chmod -R 777 /home/$username;
    echo "$group,$username,$JELSZO" >> /home/pingvin/new-worker.csv
done < stuff.csv