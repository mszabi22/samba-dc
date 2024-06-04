#!/bin/bash
QUOTA="0"

echo "Set quota: /etc/zentyal/samba.conf"

setquota -u $1 $QUOTA $QUOTA 0 0 /home

echo "/home: "
sudo repquota -vs /home  | grep $1
echo ""
