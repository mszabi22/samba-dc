#!/bin/bash
#samba-tool dns add localhost {localhost.hu} {name} A {IP}

samba-tool dns delete 10.0.0.253 domain.com $1 A $2 -U administrator
samba-tool dns query 10.0.0.253 domain.com @ ALL -U administrator

