#!/bin/bash
YEAR="2025"

echo "Bejövő osztály csoportok létrehozása az aktuális évre..."
for i in `cat osztalyok.csv`; do
    samba-tool ou create OU=$YEAR-$i,OU=Diákok
done

samba-tool ou list | sort



