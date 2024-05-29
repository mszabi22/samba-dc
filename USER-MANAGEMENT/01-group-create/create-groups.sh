#!/bin/bash

echo "Osztály csoportok létrehozása az aktuális évre..."
for i in `cat osztalyok.csv`; do
#    samba-tool group add `date +%Y`-$i
    samba-tool group add 2023-$i
done

echo "Egyéb csoportok létrehozása..."
samba-tool group add diak
samba-tool group add dolgozo
samba-tool group add gazdasagi
samba-tool group add hallgato
samba-tool group add kollegium
samba-tool group add konyvtar
samba-tool group add stuff
samba-tool group add tanar
samba-tool group add titkarsag

samba-tool group list | sort
