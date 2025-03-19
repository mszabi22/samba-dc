#!/bin/bash
LASTYEAR="2024"
YEAR="2025"
clear
echo "Előző évi szervezeti egységek átnevezése..."
for j in `cat osztalyok1.csv`; do
    EVFOLYAM=`echo "$YEAR-$j" | cut -c 7`
    BETUJEL=`echo "$YEAR-$j" | cut -c 8`
    samba-tool ou rename "OU=$LASTYEAR-$j,OU=Diákok" OU="$YEAR-$(($EVFOLYAM + 1))$BETUJEL,OU=Diákok"
done

for k in `cat osztalyok2.csv`; do
    EVFOLYAM=`echo "$YEAR-$k" | cut -c 6-7`
    BETUJEL=`echo "$YEAR-$k" | cut -c 8`
    samba-tool ou rename "OU=$LASTYEAR-$k,OU=Diákok" OU="$YEAR-$(($EVFOLYAM + 1))$BETUJEL,OU=Diákok"
done


