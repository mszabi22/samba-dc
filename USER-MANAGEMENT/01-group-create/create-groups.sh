#!/bin/bash
YEAR="2024"
echo "Egyéb csoportok létrehozása..."
samba-tool group add diak
samba-tool group add dolgozo
samba-tool group add gazdasagi
samba-tool group add hallgato
samba-tool group add kollegium
samba-tool group add konyvtar
samba-tool group add staff
samba-tool group add tanar
samba-tool group add titkarsag


echo "Osztály csoportok létrehozása az aktuális évre..."
for i in `cat osztalyok.csv`; do
    samba-tool group add $YEAR-$i
done

samba-tool group list | sort
