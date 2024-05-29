#!/bin/bash
DATUM=`date +%Y%m%d`
#samba-tool group listmembers 2019-10D > delete-users.csv

for i in `cat delete-users.csv`; do
    samba-tool user delete $i
echo "Mentés készítése..."
    tar czf /home/BACKUP/DOLGOZO-$DATUM-$i /home/$i
echo "$i mappájának törlése..."
    rm -rf /home/$i
done