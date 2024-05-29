#!/bin/bash

#samba-tool group listmembers 2019-10D > delete-users.csv

for i in `cat delete-users.csv`; do
    samba-tool user delete $i
    rm -rf /share/home/tanar/$i
done