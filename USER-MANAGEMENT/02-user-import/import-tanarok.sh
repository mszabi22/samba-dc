#!/bin/bash
DOMAIN="domain"

while IFS=, read -r username password surname givenname
do
#	JELSZO=`pwgen 8 1`
    JELSZO=$password
echo "$surname $givenname tanár hozzáadása..."
    samba-tool user create --script-path="tanar.cmd" --surname="$surname" --given-name="$givenname" --mail-address="$username@domain.hu" --department="Tanár" $username $JELSZO

    adduser --no-create-home --shell /usr/sbin/nologin $username
    usermod -g tanar $username

echo "Tanár csoporthoz adása..."
    samba-tool group addmembers tanar $username;

echo "Tanár szervezeti egységhez adása..."
    samba-tool user move $username "ou=Tanárok,ou=Dolgozók"

echo "HOME létrehozása..."
    mkdir -p /share/home/tanar/$username; chmod -R 777 /share/home/tanar/$username;
    chown -R "$username:tanar" /share/home/tanar/$username

    echo "$group,$username,$JELSZO" >> new-worker.csv
    
(
echo "Kedves $givenname!"
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
) | mail -s "Windows jelszó" $username@domain.hu 
    
sleep 1    
    
done < tanarok.csv
