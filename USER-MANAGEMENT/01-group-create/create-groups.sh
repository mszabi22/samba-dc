#!/bin/bash
YEAR="2024"

echo "Csoportok létrehozása..."
samba-tool group add staff
groupadd staff

samba-tool group add diak
samba-tool group addmembers diak staff
groupadd diak

samba-tool group add dolgozo
samba-tool group addmembers dolgozo staff
groupadd dolgozo

samba-tool group add gazdasagi
samba-tool group addmembers gazdasagi staff
groupadd gazdasagi

samba-tool group add hallgato
samba-tool group addmembers hallgato staff
groupadd hallgato

samba-tool group add kollegium
samba-tool group addmembers kollegium staff
groupadd kollegium

samba-tool group add konyvtar
samba-tool group addmembers konyvtar staff
groupadd konvytar

samba-tool group add tanar
samba-tool group addmembers tanar staff
groupadd tanar

samba-tool group add titkarsag
samba-tool group addmembers titkarsag staff
groupadd titkarsag

samba-tool group add kulsosok
samba-tool group addmembers kulsosok staff
groupadd kulsosok

samba-tool group add oraadok
samba-tool group addmembers oraadok staff
groupadd oraadok

samba-tool group add eszkozok
samba-tool group addmembers eszkozok staff
groupadd eszkozok

samba-tool group add vezetoseg
samba-tool group addmembers vezetoseg staff
groupadd vezetoseg

samba-tool group add technikai
samba-tool group addmembers technikai staff
groupadd technikai

echo "Osztály csoportok létrehozása az aktuális évre..."
for i in `cat osztalyok.csv`; do
    samba-tool group add $YEAR-$i
done

samba-tool group list | sort
