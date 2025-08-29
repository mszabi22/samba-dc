#!/bin/bash
clear
# Felhasználó mozgatása és csoportkezelése Samba-ban

# 1. Bekéri a felhasználó nevét
read -rp "Add meg a felhasználó nevét: " USERNAME

echo
echo "======================================="
echo " 2. Jelenlegi adatok: $USERNAME"
echo "======================================="

# Jelenlegi OU lekérdezése
samba-tool user show $USERNAME | grep "distinguishedName"

# Jelenlegi csoporttagság lekérdezése
echo
echo "Csoporttagságok:"
echo "Samba csoport:"
samba-tool user show $USERNAME | grep "memberOf"
echo "Linux csoport:"
id $USERNAME

echo
echo "======================================="
echo " 3. Csoportból eltávolítás"
echo "======================================="

read -rp "Melyik csoportból vegyük ki a felhasználót? " REM_GROUP
if [ -n "$REM_GROUP" ]; then
	echo "Samba csoport eltávolításe: $REM_GROUP"
    samba-tool group removemembers $REM_GROUP $USERNAME
    echo "Linux csoport eltávolításe: $REM_GROUP"
    gpasswd --delete $USERNAME "$REM_GROUP"
fi

echo
echo "======================================="
echo " 4. OU módosítás"
echo "======================================="

read -rp "Melyik OU-ba kerüljön áthelyezésre? (pl.: OU=Iskola,OU=Dolgozók,DC=samba,DC=cnk,DC=lan) " NEW_OU
if [ -n "$NEW_OU" ]; then
    samba-tool user move $USERNAME $NEW_OU
fi

echo
echo "======================================="
echo " 5. Új csoporthoz adás"
echo "======================================="

samba-tool group list | sort
read -rp "Melyik csoportba kerüljön hozzáadásra? " ADD_GROUP
if [ -n "$ADD_GROUP" ]; then
    samba-tool group addmembers $ADD_GROUP $USERNAME
fi

echo
echo "======================================="
echo " 6. Felhasználó adatainak szerkesztése"
echo "======================================="
samba-tool user edit $USERNAME

echo
echo "======================================="
echo " 7. Végső állapot"
echo "======================================="

# Új OU megjelenítése
samba-tool user show $USERNAME | grep "distinguishedName"

# Új csoporttagságok megjelenítése
echo
echo "Csoporttagságok:"
samba-tool user show $USERNAME | grep "memberOf"
id $USERNAME

echo
echo "Kész!"
