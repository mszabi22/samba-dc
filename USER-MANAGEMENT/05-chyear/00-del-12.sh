#!/bin/bash
LASTYEAR="2020"

samba-tool group listmembers $LASTYEAR-12A > delete-users.csv
samba-tool group listmembers $LASTYEAR-12B >> delete-users.csv
samba-tool group listmembers $LASTYEAR-12C >> delete-users.csv
samba-tool group listmembers $LASTYEAR-12D >> delete-users.csv
samba-tool group listmembers $LASTYEAR-12E >> delete-users.csv

for i in `cat delete-users.csv`; do
    samba-tool user delete $i
echo "Mentés készítése..."
    tar czvf /home/BACKUP/DIAK-$DATUM-$i.tar.gz /home/$i
echo "$i mappájának törlése..."
    rm -rf /home/$i
done