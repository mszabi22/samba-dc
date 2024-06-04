#!/bin/bash
QUOTA="0"

setquota -u $1 $QUOTA $QUOTA 0 0 /home
setquota -u $1 $QUOTA $QUOTA 0 0 /dev/mapper/ubuntu--vg-ubuntu--lv

echo "/home: "
sudo repquota -vs /home  | grep $1
echo ""
echo "/dev/mapper/ubuntu--vg-ubuntu--lv: "
sudo repquota -vs /dev/mapper/ubuntu--vg-ubuntu--lv  | grep $1
echo ""
