#!/bin/bash
DOMAIN="domain"

while IFS=, read -r username password surname givenname
do
#	JELSZO=`pwgen 8 1`
    JELSZO=$password
echo "$surname $givenname technikai dolgozó hozzáadása..."
    samba-tool user create --surname="$surname" --given-name="$givenname" --mail-address="$username@domain.hu" --department="Technikai" $username $JELSZO

    adduser --no-create-home --shell /usr/sbin/nologin $username
    usermod -g tanar -G technikai $username

echo "Technikai dolgozó csoporthoz adása..."
    samba-tool group addmembers technikai $username;

echo "Technikai dolgozó szervezeti egységhez adása..."
    samba-tool user move $username "ou=Technikai,ou=Dolgozók"

echo "HOME létrehozása..."
    mkdir -p /share/home/tanar/$username; chmod -R 777 /share/home/tanar/$username;
    chown -R "$username:tanar" /share/home/tanar/$username

    echo "$group,$username,$JELSZO" >> new-worker.csv
done < technikai.csv
