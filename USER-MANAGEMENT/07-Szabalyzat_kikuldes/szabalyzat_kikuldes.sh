#!/usr/bin/bash
DOMAIN="SAMBA"
while IFS=, read -r username surname givenname
do
(
echo "Kedves $givenname!"
echo ""
echo "Számítástechnikai – informatikai infrastruktúránk használati szabályzatát ezen a linken éred el:"
echo "https://szabalyzat.cnkpecs.hu/"
echo ""
echo "Üdvözlettel:"
echo "Major Szabolcs"
echo "rendszergazda"
echo "E-mail: major.szabolcs@szentmargitpecs.hu"
echo ""
) | mail -s "[CNK] Informatikai szabályzat" $username@szentmargitpecs.hu 

sleep 5
    
done < users.csv
