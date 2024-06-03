#!/bin/bash
JELSZO=$1
DOMAIN="domain.com"

while IFS=, read -r domain name ip
do
    samba-tool dns add localhost $domain $name A $ip -U administrator --password=$JELSZO
done < dns.csv

samba-tool dns query localhost $DOMAIN @ ALL -U administrator --password=$JELSZO