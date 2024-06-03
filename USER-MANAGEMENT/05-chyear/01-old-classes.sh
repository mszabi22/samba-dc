#!/bin/bash

#### NINCS KÉSZ!!! ####
#sudo samba-tool group rename rendszergazdik --samaccountname=stuff

LASTYEAR="2023"
YEAR="2024"

echo "Előző évi osztályok exportálása..."
for j in `cat osztalyok.csv`; do
    
    echo "samba-tool group rename $LASTYEAR-$j --samaccountname=$YEAR-$j"
done



