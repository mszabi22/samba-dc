#!/bin/bash
LASTYEAR="2023"
YEAR="2024"
clear
echo "Előző évi csoportok átnevezése..."
for j in `cat osztalyok1.csv`; do
EVFOLYAM=`echo "$YEAR-$j" | cut -c 6`
BETUJEL=`echo "$YEAR-$j" | cut -c 7`
    samba-tool group rename $LASTYEAR-$j --samaccountname=$YEAR-$(($EVFOLYAM + 1))$BETUJEL
done

for k in `cat osztalyok2.csv`; do
EVFOLYAM=`echo "$YEAR-$k" | cut -c 6-7`
BETUJEL=`echo "$YEAR-$k" | cut -c 8`
    samba-tool group rename $LASTYEAR-$k --samaccountname=$YEAR-$(($EVFOLYAM + 1))$BETUJEL
done


