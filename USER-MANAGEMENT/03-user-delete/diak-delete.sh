#!/bin/bash
TORLESDATUMA=`date +%Y%m%d`
YEAR="2024"

clear
samba-tool group listmembers $YEAR-12A > delete-users.csv
samba-tool group listmembers $YEAR-12B >> delete-users.csv
samba-tool group listmembers $YEAR-12C >> delete-users.csv
samba-tool group listmembers $YEAR-12D >> delete-users.csv
samba-tool group listmembers $YEAR-12E >> delete-users.csv

for i in `cat delete-users.csv`; do
    samba-tool user delete $i
    userdel $i
echo "Mentés készítése..."
    tar czvf /share/home/BACKUP/DIAK-$TORLESDATUMA-$i.tar.gz /share/home/diak/$i
echo "$i mappájának törlése..."
    rm -rf /share/home/diak/$i
done