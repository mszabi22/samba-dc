#!/bin/bash
DOMAIN="domain.com"

samba-tool dns zonedelete localhost $DOMAIN -U administrator
samba-tool dns zonelist localhost -U administrator


