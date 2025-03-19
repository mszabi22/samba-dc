**SAMBA Domain Controller telepítése Rocky Linux alatt:**

dnf install epel-release.noarch dnf-plugins-core -y
dnf -y groupinstall 'Development Tools'
dnf config-manager --set-enabled crb

**Függőségek telepítése:**
dnf install -y docbook-style-xsl gcc gdb gnutls-devel gpgme-devel jansson-devel \
      keyutils-libs-devel krb5-workstation libacl-devel libaio-devel \
      libarchive-devel libattr-devel libblkid-devel libtasn1 libtasn1-tools \
      libxml2-devel libxslt lmdb-devel openldap-devel pam-devel perl \
      perl-ExtUtils-MakeMaker perl-Parse-Yapp popt-devel python3-cryptography \
      python3-dns python3-gpg python3-devel readline-devel rpcgen systemd-devel \
      tar zlib-devel git dbus-devel krb5-devel krb5-server krb5-workstation \
      python3-pyasn1 python3-markdown

**SAMBA letöltése:**
cd /usr/src
wget https://download.samba.org/pub/samba/samba-latest.tar.gz
tar xvf samba-latest.tar.gz; rm samba-latest.tar.gz
cd samba-4.22.0/

**SAMBA konfigurálása:**
./configure --enable-debug --enable-selftest --enable-fhs --with-system-mitkrb5 --with-experimental-mit-ad-dc

**SAMBA lefordítása:**
make -j$(nproc)
make install

**SAMBA útvonalak beállítása:**
echo 'export PATH=/usr/local/samba/bin:/usr/local/samba/sbin:$PATH' >> ~/.bashrc

source ~/.bashrc
samba --version

**SAMBA beállítása, mint Domain Controller server:**
samba-tool domain provision --use-rfc2307 --interactive

cp /usr/local/samba/var/lib/samba/private/krb5.conf /etc/krb5.conf

**SAMBA szolgáltatás engedélyezése:**
echo "[Unit]
Description=Samba AD DC
After=network.target

[Service]
Type=forking
ExecStart=/usr/local/samba/sbin/samba
ExecReload=/bin/kill -HUP $MAINPID
LimitNOFILE=16384

[Install]
WantedBy=multi-user.target
" > /etc/systemd/system/samba.service
systemctl daemon-reload
systemctl enable --now samba


Ezután beléptethetjük a Windows-os/Linux-os klienseket a tartományba. DC kezeléséhez szükséges scriptek megtalálhatóak a repóba.

