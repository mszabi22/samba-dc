#!/bin/bash
TORLESDATUMA=`date +%Y%m%d`

for i in `cat delete-users.csv`; do
    samba-tool user delete $i
echo "Mentés készítése..."
    tar czf /home/BACKUP/DOLGOZO-$TORLESDATUMA-$i.tar.gz /home/$i
echo "$i mappájának törlése..."
    rm -rf /home/$i
done