#!/bin/bash
DOMAIN="domain.com"

samba-tool dns zonecreate localhost $DOMAIN -U Administrator
samba-tool dns zonelist localhost -U Administrator

