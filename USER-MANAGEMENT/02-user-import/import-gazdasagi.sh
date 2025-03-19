#!/bin/bash
DOMAIN="domain"

while IFS=, read -r username password surname givenname
do
#	JELSZO=`pwgen 8 1`
    JELSZO=$password
echo "$surname $givenname gazdasági dolgozó hozzáadása..."
    samba-tool user create --must-change-at-next-login --script-path="gazdasagi.cmd" --surname="$surname" --given-name="$givenname" --mail-address="$username@crnl.hu" $username $JELSZO

    adduser --no-create-home --shell /usr/sbin/nologin $username
    usermod -g tanar -G gazdasagi $username

echo "Gazdasági dolgozó csoporthoz adása..."
    samba-tool group addmembers gazdasagi $username;

echo "Gazdasági dolgozó szervezeti egységhez adása..."
    samba-tool user move $username "ou=Gazdasági,ou=Dolgozók"

echo "HOME létrehozása..."
    mkdir -p /share/home/tanar/$username; chmod -R 777 /share/home/tanar/$username;
    chown -R "$username:tanar" /share/home/tanar/$username
    
    echo "$group,$username,$JELSZO" >> /home/majorsza/new-worker.csv
done < gazdasagi.csv