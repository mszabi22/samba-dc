#!/bin/bash
DOMAIN="domain"

while IFS=, read -r osztaly username password surname givenname
do
#	JELSZO=`pwgen 8 1`
    JELSZO=$password
echo "$osztaly - $surname $givenname diák hozzáadása..."
    samba-tool user create --script-path="diak.cmd" --surname="$surname" --given-name="$givenname" --mail-address="$username@diak.domain.hu" --department="$osztaly" $username $JELSZO
    
    adduser --no-create-home --shell /usr/sbin/nologin $username
    usermod -g diak $username

echo "Diák csoporthoz adása..."
    samba-tool group addmembers diak $username;
    samba-tool group addmembers $osztaly $username;

echo "Diák szervezeti egységhez adása..."
    samba-tool user move $username "ou=$osztaly,ou=Diákok"

echo "HOME létrehozása..."
    mkdir -p /share/home/diak/$username; chmod -R 777 /share/home/diak/$username;
    chown -R "$username:diak" /share/home/diak/$username

    echo "$group,$username,$JELSZO" >> new-worker.csv
done < diakok.csv
