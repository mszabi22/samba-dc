#!/bin/bash

#### NINCS KÉSZ!!! ####

OLDYEAR="2020"

echo "Előző évi osztályok exportálása..."
for j in `cat osztalyok.csv`; do
    samba-tool group listmembers $OLDYEAR-$j > osztalyok/$OLDYEAR-$j.csv
done



