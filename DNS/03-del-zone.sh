#!/bin/bash
#samba-tool dns zonecreate localhost {localhost.hu}

samba-tool dns zonedelete 10.0.0.253 $1 -U administrator
samba-tool dns zonelist 10.0.0.253 -U administrator


