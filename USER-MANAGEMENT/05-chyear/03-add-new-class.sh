#!/bin/bash
for FILES in `ls -1 osztalyok`; do
    CSOPORT=$(basename $FILES .csv)
    for USER in `cat osztalyok/$FILES`; do
	samba-tool group addmembers $CSOPORT $USER
	samba-tool user move $USER "ou=$CSOPORT,ou=Diákok"
    done
done


