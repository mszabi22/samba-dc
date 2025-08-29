#!/usr/bin/bash
DOMAIN="SAMBA"
while IFS=, read -r username surname givenname
do
(
echo "Kedves $givenname!"
echo ""
echo "Számítástechnikai – informatikai infrastruktúránk használati szabályzatát ezen a linken éred el:"
echo "https://szabalyzat.domain.hu/"
echo ""
echo "Üdvözlettel:"
echo "rendszergazda"
echo ""
) | mail -s "Informatikai szabályzat" $username@domain.hu 

sleep 5
    
done < users.csv
