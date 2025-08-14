#!/bin/bash
DOMAIN="domain"

while IFS=, read -r osztaly username password surname givenname
do
JELSZO=`pwgen 8 1`
#    JELSZO=$password
echo "$osztaly - $surname $givenname diák hozzáadása..."
    samba-tool user create --script-path="diak.cmd" --surname="$surname" --given-name="$givenname" --mail-address="$username@diak.crnl.hu" --department="$osztaly" $username $JELSZO
    
    adduser --no-create-home --shell /usr/sbin/nologin $username
    usermod -g diak $username

echo "Diák csoporthoz adása..."
    samba-tool group addmembers diak $username;
    samba-tool group addmembers $osztaly $username;

echo "Diák szervezeti egységhez adása..."
    samba-tool user move $username "ou=$osztaly,ou=Diákok"

echo "HOME létrehozása..."
    mkdir -p /share/home/diak/$username; chmod -R 777 /share/home/diak/$username;
    chown -R "$username:diak" /share/home/diak/$username

    echo "$group,$username,$JELSZO" >> bejovo_osztaly_jelszavak.csv

(
echo "Subject: [CRNL] Windows jelszó"
echo "From: noreply@crnl.hu"
echo ""
echo "Kedves Diákunk!"
echo ""
echo "Számítógépes belépésekhez és wifi-hez használható jelszavad:"
echo ""
echo "Felhasználói név: $username"
echo "Új jelszó: $JELSZO"
echo ""
echo "Üdvözlettel:"
echo "Major Szabolcs"
echo "rendszergazda"
echo ""
) | msmtp $username@diak.crnl.hu

sleep 5

done < diakok.csv
