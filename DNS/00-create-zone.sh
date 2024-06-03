#!/bin/bash
JELSZO=$1
DOMAIN="domain.com"

samba-tool dns zonecreate localhost $DOMAIN -U administrator --password=$JELSZO
samba-tool dns zonelist localhost -U administrator --password=$JELSZO

