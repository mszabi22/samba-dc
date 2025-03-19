#!/bin/bash
DOMAIN="domain"

while IFS=, read -r username password surname givenname
do
#	JELSZO=`pwgen 8 1`
    JELSZO=$password
echo "$surname $givenname titkársági dolgozó hozzáadása..."
    samba-tool user create --must-change-at-next-login --script-path="titkarsag.cmd" --surname="$surname" --given-name="$givenname" --mail-address="$username@crnl.hu" --department="Titkárság" $username $JELSZO

    adduser --no-create-home --shell /usr/sbin/nologin $username
    usermod -g tanar -G titkarsag $username

echo "Titkársági dolgozó csoporthoz adása..."
    samba-tool group addmembers titkarsag $username;

echo "Titkársági dolgozó szervezeti egységhez adása..."
    samba-tool user move $username "ou=Titkárság,ou=Dolgozók"

echo "HOME létrehozása..."
    mkdir -p /share/home/tanar/$username; chmod -R 777 /share/home/tanar/$username;
    chown -R "$username:tanar" /share/home/tanar/$username

    echo "$group,$username,$JELSZO" >> /home/majorsza/new-worker.csv
done < titkarsag.csv
