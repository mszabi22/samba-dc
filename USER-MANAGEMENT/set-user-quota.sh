#!/bin/bash
QUOTA="0"

setquota -u $1 $QUOTA $QUOTA 0 0 /home

echo "/home: "
sudo quota -vs $1
echo ""
