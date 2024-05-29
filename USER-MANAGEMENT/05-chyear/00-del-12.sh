#!/bin/bash
OLDYEAR="2020"

samba-tool group listmembers $OLDYEAR-12A > delete-users.csv
samba-tool group listmembers $OLDYEAR-12B >> delete-users.csv
samba-tool group listmembers $OLDYEAR-12C >> delete-users.csv
samba-tool group listmembers $OLDYEAR-12D >> delete-users.csv
samba-tool group listmembers $OLDYEAR-12E >> delete-users.csv

for i in `cat delete-users.csv`; do
    samba-tool user delete $i
    rm -rf /share/home/diak/$i
done