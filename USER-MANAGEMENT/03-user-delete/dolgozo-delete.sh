#!/bin/bash
TORLESDATUMA=`date +%Y%m%d`

for i in `cat delete-users.csv`; do
    samba-tool user delete $i
echo "Mentés készítése..."
    tar czf /share/home/BACKUP/DOLGOZO-$TORLESDATUMA-$i.tar.gz /share/home/tanar/$i
echo "$i mappájának törlése..."
    rm -rf /share/home/tanar/$i
done