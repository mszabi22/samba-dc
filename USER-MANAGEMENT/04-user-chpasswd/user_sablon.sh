#!/bin/bash
# Felhasználó keresés és jelszócsere Samba-tool-lal
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


