#!/bin/bash
DOMAIN="domain.com"
NAME=""
IP=""

samba-tool dns delete localhost  $DOMAIN $NAME A $IP -U administrator
samba-tool dns query localhost $DOMAIN @ ALL -U administrator

