#!/bin/bash
YEAR="2025"
echo "Bejövő osztály csoportok létrehozása az aktuális évre..."
for i in `cat bejovo_osztalyok.csv`; do
    samba-tool ou create OU=$YEAR-$i,OU=Diákok
done



