#!/bin/bash
DOMAIN="domain"

while IFS=, read -r username password surname givenname
do
#	JELSZO=`pwgen 8 1`
    JELSZO=$password
echo "$surname $givenname eszköz hozzáadása..."
    samba-tool user create --surname="$surname" --given-name="$givenname" $username $JELSZO

    adduser --no-create-home --shell /usr/sbin/nologin $username
    usermod -g eszkozok $username

echo "Eszkozök dolgozó csoporthoz adása..."
    samba-tool group addmembers eszkozok $username;

echo "Eszközök dolgozó szervezeti egységhez adása..."
    samba-tool user move $username "ou=Eszközök,ou=Dolgozók"
    echo "$group,$username,$JELSZO" >> /home/majorsza/new-worker.csv
done < eszkozok.csv