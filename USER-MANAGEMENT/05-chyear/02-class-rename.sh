#!/bin/bash

OLDYEAR="2020"
NEWYEAR="2021"

for i in `ls -1 osztalyok`; do
case $i in
  $OLDYEAR-07A.csv)
    mv osztalyok/$OLDYEAR-07A.csv osztalyok/$NEWYEAR-08A.csv
    ;;
  $OLDYEAR-08A.csv)
    mv osztalyok/$OLDYEAR-08A.csv osztalyok/$NEWYEAR-09A.csv
    ;;
  $OLDYEAR-09A.csv)
    mv osztalyok/$OLDYEAR-09A.csv osztalyok/$NEWYEAR-10A.csv
    ;;
  $OLDYEAR-09B.csv)
    mv osztalyok/$OLDYEAR-09B.csv osztalyok/$NEWYEAR-10B.csv
    ;;
  $OLDYEAR-09C.csv)
    mv osztalyok/$OLDYEAR-09C.csv osztalyok/$NEWYEAR-10C.csv
    ;;
  $OLDYEAR-09D.csv)
    mv osztalyok/$OLDYEAR-09D.csv osztalyok/$NEWYEAR-10D.csv
    ;;
  $OLDYEAR-09E.csv)
    mv osztalyok/$OLDYEAR-09E.csv osztalyok/$NEWYEAR-10E.csv
    ;;
  $OLDYEAR-10A.csv)
    mv osztalyok/$OLDYEAR-10A.csv osztalyok/$NEWYEAR-11A.csv
    ;;
  $OLDYEAR-10B.csv)
    mv osztalyok/$OLDYEAR-10B.csv osztalyok/$NEWYEAR-11B.csv
    ;;
  $OLDYEAR-10C.csv)
    mv osztalyok/$OLDYEAR-10C.csv osztalyok/$NEWYEAR-11C.csv
    ;;
  $OLDYEAR-10D.csv)
    mv osztalyok/$OLDYEAR-10D.csv osztalyok/$NEWYEAR-11D.csv
    ;;
  $OLDYEAR-10E.csv)
    mv osztalyok/$OLDYEAR-10E.csv osztalyok/$NEWYEAR-11E.csv
    ;;
  $OLDYEAR-11A.csv)
    mv osztalyok/$OLDYEAR-11A.csv osztalyok/$NEWYEAR-12A.csv
    ;;
  $OLDYEAR-11B.csv)
    mv osztalyok/$OLDYEAR-11B.csv osztalyok/$NEWYEAR-12B.csv
    ;;
  $OLDYEAR-11C.csv)
    mv osztalyok/$OLDYEAR-11C.csv osztalyok/$NEWYEAR-12C.csv
    ;;
  $OLDYEAR-11D.csv)
    mv osztalyok/$OLDYEAR-11D.csv osztalyok/$NEWYEAR-12D.csv
    ;;
  $OLDYEAR-11E.csv)
    mv osztalyok/$OLDYEAR-11E.csv osztalyok/$NEWYEAR-12E.csv
    ;;
esac
done
















