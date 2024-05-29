#!/bin/bash
while IFS=, read -r osztaly username password surname givenname
do
#	JELSZO=`pwgen 8 1`
    JELSZO=$password
clear
echo "Diák hozzáadása..."
    samba-tool user create --must-change-at-next-login --script-path="diak.cmd" --surname="$surname" --given-name="$givenname" --mail-address="$username@diak.crnl.hu" $username $JELSZO
echo "Diák csoporthoz adása..."
    samba-tool group addmembers diak $username;
echo "Diák szervezeti egységhez adása..."
    samba-tool user move $username "ou=$osztaly,ou=Diákok"
echo "HOME létrehozása..."
    mkdir -p /home/$username; chmod -R 777 /home/$username;
    echo "$group,$username,$JELSZO" >> /home/pingvin/new-worker.csv
done < diakok.csv