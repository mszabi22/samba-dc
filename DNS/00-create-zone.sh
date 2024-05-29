#!/bin/bash
samba-tool dns zonecreate localhost {domain.hu} -U Administrator
samba-tool dns zonelist localhost -U Administrator

