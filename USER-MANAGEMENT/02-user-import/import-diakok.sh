#!/bin/bash
DOMAIN="domain"

while IFS=, read -r osztaly username password surname givenname
do
#JELSZO=`pwgen 8 1`
JELSZO=$password

# Ellenőrzés + inkrementálás
    base_username="$username"
    i=0
    while true; do
        if samba-tool user show "$username" >/dev/null 2>&1 || id "$username" >/dev/null 2>&1; then
            i=$((i+1))
            username="${base_username}${i}"
        else
            break
        fi
    done
###

echo "$osztaly - $surname $givenname diák hozzáadása..."
    samba-tool user create --script-path="diak.cmd" --surname="$surname" --given-name="$givenname" --mail-address="$username@diak.domain.hu" --department="$osztaly" $username $JELSZO
    
    adduser --no-create-home --shell /usr/sbin/nologin $username
    usermod -g diak $username

echo "Diák csoporthoz adása..."
    samba-tool group addmembers diak $username;
    samba-tool group addmembers $osztaly $username;

echo "Diák szervezeti egységhez adása..."
    samba-tool user move $username "ou=$osztaly,ou=Diákok"

echo "HOME létrehozása..."
    mkdir -p /share/home/diak/$username; chmod -R 777 /share/home/diak/$username;
    chown -R "root:root" /share/home/diak/$username

    echo "$osztaly,$username,$JELSZO" >> new-worker.csv
    
(
echo "Kedves Diákunk!"
echo ""
echo "Számítógépes belépésekhez és wifi-hez használható jelszavad:"
echo ""
echo "Felhasználói név: $username"
echo "Új jelszó: $JELSZO"
echo ""
echo "Informatikai szabályzat a https://szabalyzat.domain.hu oldalon olvasható el."
echo ""
echo "Üdvözlettel:"
echo "rendszergazda"
echo ""
) | USER=root mail -s "Windows jelszó" $username@diak.domain.hu 

sleep 1     
    
done < diakok.csv
