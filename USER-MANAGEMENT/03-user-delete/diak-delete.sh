#!/bin/bash

samba-tool group listmembers 2020-12A > delete-users.csv
samba-tool group listmembers 2020-12B >> delete-users.csv
samba-tool group listmembers 2020-12C >> delete-users.csv
samba-tool group listmembers 2020-12D >> delete-users.csv
samba-tool group listmembers 2020-12E >> delete-users.csv


for i in `cat delete-users.csv`; do
    samba-tool user delete $i
    rm -rf /share/home/diak/$i
done