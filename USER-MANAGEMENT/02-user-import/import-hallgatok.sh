#!/bin/bash
DOMAIN="domain"

while IFS=, read -r username password surname givenname
do
#	JELSZO=`pwgen 8 1`
    JELSZO=$password
echo "$surname $givenname hallgató hozzáadása..."
    samba-tool user create --script-path="tanar.cmd" --surname="$surname" --given-name="$givenname" --mail-address="$username@guest.domain.hu"  --department="Hallgató"  $username $JELSZO

    adduser --no-create-home --shell /usr/sbin/nologin $username
    usermod -g tanar -G hallgatok $username

echo "Hallgató csoporthoz adása..."
    samba-tool group addmembers tanar $username;
    samba-tool group addmembers hallgato $username;

echo "Hallgató szervezeti egységhez adása..."
    samba-tool user move $username "ou=Hallgatók,ou=Dolgozók"

echo "HOME létrehozása..."
    mkdir -p /share/home/tanar/$username; chmod -R 777 /share/home/tanar/$username;
    chown -R "$username:tanar" /share/home/tanar/$username

    echo "$group,$username,$JELSZO" >> new-worker.csv
done < hallgatok.csv
