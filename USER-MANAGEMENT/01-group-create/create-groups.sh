#!/bin/bash

echo "Osztály csoportok létrehozása az aktuális évre..."
for i in `cat osztalyok.csv`; do
#    samba-tool group add `date +%Y`-$i
    samba-tool group add 2024-$i
done

echo "Egyéb csoportok létrehozása..."
samba-tool group add dolgozok
samba-tool group add tanarok
samba-tool group add diakok
samba-tool group add gazdasagi
samba-tool group add titkarsag
samba-tool group add stuff

samba-tool group list | sort
