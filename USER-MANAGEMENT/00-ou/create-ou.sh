#!/bin/bash

samba-tool ou create OU=Diákok
samba-tool ou create OU=Dolgozók
samba-tool ou create OU=Tanárok,OU=Dolgozók
samba-tool ou create OU=Stuff,OU=Dolgozók
samba-tool ou create OU=Gazdasági,OU=Dolgozók
samba-tool ou create OU=Titkárság,OU=Dolgozók

echo "Osztály csoportok létrehozása az aktuális évre..."
for i in `cat osztalyok.csv`; do
    samba-tool ou create OU=2024-$i,OU=Diákok
done

samba-tool ou list | sort



