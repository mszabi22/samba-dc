#!/bin/bash
JELSZO=$1
DOMAIN="domain.com"
NAME=""
IP=""

samba-tool dns delete localhost  $DOMAIN $NAME A $IP -U administrator --password=$JELSZO
samba-tool dns query localhost $DOMAIN @ ALL -U administrator --password=$JELSZO

