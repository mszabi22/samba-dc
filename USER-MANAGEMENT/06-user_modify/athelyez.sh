#!/bin/bash
clear
# Felhasználó mozgatása és csoportkezelése Samba-ban
clear
echo -n "Felhasználói név töredék? "
read FELHASZNALONEVT

if [ -z "$FELHASZNALONEVT" ]; then
    echo "Hiba: a felhasználói név nem lehet üres."
    exit 1
fi

# 1. Keresés és lista kiírás
echo "=== Találatok ==="
MATCHED_USERS=()
while read -r USER; do
    INFO=$(sudo /usr/local/samba/bin/samba-tool user show "$USER")

    DISPLAYNAME=$(echo "$INFO" | grep -i "^displayName:" | cut -d: -f2- | sed 's/^ //')
    DN=$(echo "$INFO" | grep -i "^dn:" | cut -d: -f2- | sed 's/^ //')

    OU="N/A"
    if echo "$DN" | grep -q "OU="; then
        OU=$(echo "$DN" | grep -o "OU=[^,]*" | head -n1 | cut -d= -f2)
    fi

    FULL_OU="N/A"
    if echo "$DN" | grep -q "OU="; then
        FULL_OU=$(echo "$DN" | sed 's/^[^,]*,//')
    fi

    PARENT_OU="N/A"
    if echo "$DN" | grep -q "OU="; then
        PARENT_OU=$(echo "$DN" | grep -o "OU=[^,]*" | sed -n '2p' | cut -d= -f2)
    fi

    echo "$PARENT_OU | $OU | $USER | ${DISPLAYNAME:-N/A} | $FULL_OU "
    MATCHED_USERS+=("$USER")
done < <(sudo /usr/local/samba/bin/samba-tool user list | grep -i "$FELHASZNALONEVT")

if [ ${#MATCHED_USERS[@]} -eq 0 ]; then
    echo "Nincs találat."
    exit 1
fi

# 2. Kérdés: melyik user?
echo
echo -n "Melyik felhasználó nevét választod? "
read SELECTED_USER

if ! printf '%s\n' "${MATCHED_USERS[@]}" | grep -qx "$SELECTED_USER"; then
    echo "Hiba: a választott felhasználó nincs a találatok között."
    exit 1
fi

###### felhasználó műveletek eztután a $SELECTED_USER-el ######

USERNAME=$SELECTED_USER

# Jelenlegi csoporttagság lekérdezése
echo
echo "Csoporttagságok:"
echo "Samba csoport:"
sudo /usr/local/samba/bin/samba-tool user show $USERNAME | grep "memberOf"
echo "Linux csoport:"
id $USERNAME

echo
echo "======================================="
echo " 3. Csoportból eltávolítás"
echo "======================================="

read -rp "Melyik csoportból vegyük ki a felhasználót? " REM_GROUP
if [ -n "$REM_GROUP" ]; then
	echo "Samba csoport eltávolításe: $REM_GROUP"
    sudo /usr/local/samba/bin/samba-tool group removemembers $REM_GROUP $USERNAME
    echo "Linux csoport eltávolításe: $REM_GROUP"
    gpasswd --delete $USERNAME "$REM_GROUP"
fi

echo
echo "======================================="
echo " 4. OU módosítás"
echo "======================================="

read -rp "Melyik OU-ba kerüljön áthelyezésre? (pl.: OU=Iskola,OU=Dolgozók,DC=samba,DC=crnl,DC=lan) " NEW_OU
if [ -n "$NEW_OU" ]; then
    sudo /usr/local/samba/bin/samba-tool user move $USERNAME $NEW_OU
fi

echo
echo "======================================="
echo " 5. Új csoporthoz adás"
echo "======================================="

sudo /usr/local/samba/bin/samba-tool group list | sort
read -rp "Melyik csoportba kerüljön hozzáadásra? " ADD_GROUP
if [ -n "$ADD_GROUP" ]; then
    sudo /usr/local/samba/bin/samba-tool group addmembers $ADD_GROUP $USERNAME
fi

echo
echo "======================================="
echo " 6. Felhasználó adatainak szerkesztése"
echo "======================================="
ls -1 /usr/local/samba/var/lib/samba/sysvol/samba.crnl.lan/scripts
sudo /usr/local/samba/bin/samba-tool user edit $USERNAME

echo
echo "======================================="
echo " 7. Végső állapot"
echo "======================================="

# Új OU megjelenítése
sudo /usr/local/samba/bin/samba-tool user show $USERNAME | grep "distinguishedName"

# Új csoporttagságok megjelenítése
echo
echo "Csoporttagságok:"
sudo /usr/local/samba/bin/samba-tool user show $USERNAME | grep "memberOf"
id $USERNAME

echo
echo "Kész!"
