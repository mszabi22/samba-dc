#!/bin/bash
QUOTA="2G"

setquota -u $1 $QUOTA $QUOTA 0 0 /home
quota -vs $1
