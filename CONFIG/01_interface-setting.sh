# Ellenőrizzük, hogy root jogokkal fut-e a script
if [[ $EUID -ne 0 ]]; then
   echo "Ezt a scriptet root jogokkal kell futtatni!"
   exit 1
fi

# Hálózati interfészek megadása
#nmcli device connect ens18
INTIF="enp0s3"

# LAN interfész beállítása
if ! nmcli connection modify $INTIF IPv4.address 10.0.0.240/16; then
   echo "Hiba: Nem sikerült beállítani az IPv4 címet a $INTIF interfészen!" >&2
   exit 1
fi
nmcli connection modify $INTIF IPv4.gateway "10.0.0.254"
nmcli connection modify $INTIF IPv4.dns "1.1.1.1 9.9.9.9"
nmcli connection modify $INTIF IPv4.method manual
nmcli con down $INTIF
nmcli con up $INTIF
