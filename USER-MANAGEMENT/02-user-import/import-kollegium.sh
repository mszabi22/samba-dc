#!/bin/bash
DOMAIN="domain"

while IFS=, read -r username password surname givenname
do
#	JELSZO=`pwgen 8 1`
JELSZO=$password
echo "$surname $givenname kollégiumi dolgozó hozzáadása..."
    samba-tool user create --script-path="kollegium.cmd" --surname="$surname" --given-name="$givenname" --mail-address="$username@domain.hu" --department="Kollégium" $username $JELSZO

    adduser --no-create-home --shell /usr/sbin/nologin $username
    usermod -g tanar -G kollegium $username

echo "Kollégiumi dolgozó csoporthoz adása..."
    samba-tool group addmembers kollegium $username;

echo "Kollégiumi dolgozó szervezeti egységhez adása..."
    samba-tool user move $username "ou=Kollégium,ou=Dolgozók"

echo "HOME létrehozása..."
    mkdir -p /share/home/tanar/$username; chmod -R 777 /share/home/tanar/$username;
    chown -R "$username:tanar" /share/home/tanar/$username

    echo "$group,$username,$JELSZO" >> new-worker.csv
done < kollegium.csv
