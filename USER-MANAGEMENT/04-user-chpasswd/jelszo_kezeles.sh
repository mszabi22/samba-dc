#!/bin/bash
	clear

# Menüpontok nevei, amik megjelennek a felhasználónak
menu_items=(
    "Diák jelszócsere"
    "Gazdasági jelszócsere"
    "Osztály jelszócsere"
    "Tanárok jelszócsere"
    "Technikai jelszócsere"
    "Titkárság jelszócsere"
)

# A hozzájuk tartozó fájlok (teljes útvonal is lehet)
files=(
    "/etc/scripts/USER-MANAGEMENT/04-user-chpasswd/diak_jelszocsere"
    "/etc/scripts/USER-MANAGEMENT/04-user-chpasswd/gazdasagi_jelszocsere"
    "/etc/scripts/USER-MANAGEMENT/04-user-chpasswd/osztaly_jelszocsere"
    "/etc/scripts/USER-MANAGEMENT/04-user-chpasswd/tanar_jelszocsere"
    "/etc/scripts/USER-MANAGEMENT/04-user-chpasswd/technikai_jelszocsere"
    "/etc/scripts/USER-MANAGEMENT/04-user-chpasswd/titkarsag_jelszocsere"
)

while true; do
echo "* * * Jelszó kezelő * * *"
    echo "Válassz egy menüpontot:"
    
    for i in "${!menu_items[@]}"; do
        echo "$((i+1)). ${menu_items[i]}"
    done
    echo "0. Kilépés"
    
    read -p "Szám: " choice
    
    if [[ "$choice" == "0" ]]; then
        echo "Kilépés..."
        exit 0
    fi
    
    if [[ "$choice" -ge 1 && "$choice" -le ${#files[@]} ]]; then
        echo "Indítás: ${menu_items[$((choice-1))]}"
        "${files[$((choice-1))]}"
    else
        echo "Érvénytelen választás, próbáld újra."
    fi
    
    echo ""
done
