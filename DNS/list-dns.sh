#!/bin/bash
JELSZO=$1
DOMAIN="domain.com"

samba-tool dns query localhost $DOMAIN @ ALL -U administrator --password=$JELSZO
