#!/bin/bash
DOMAIN="domain"

while IFS=, read -r username password surname givenname
do
#	JELSZO=`pwgen 8 1`
    JELSZO=$password
echo "$surname $givenname óraadó tanár hozzáadása..."
    samba-tool user create --must-change-at-next-login --script-path="tanar.cmd" --surname="$surname" --given-name="$givenname" --mail-address="$username@domain.hu" --department="Óraadó" $username $JELSZO

    adduser --no-create-home --shell /usr/sbin/nologin $username
    usermod -g tanar $username

echo "Tanár csoporthoz adása..."
    samba-tool group addmembers tanar $username;

echo "Tanár szervezeti egységhez adása..."
    samba-tool user move $username "ou=Óraadók,ou=Dolgozók"

echo "HOME létrehozása..."
    mkdir -p /share/home/tanar/$username; chmod -R 777 /share/home/tanar/$username;
    chown -R "$username:tanar" /share/home/tanar/$username

    echo "$group,$username,$JELSZO" >> new-worker.csv
done < oraadok.csv
