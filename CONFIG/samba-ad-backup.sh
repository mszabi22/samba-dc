#!/bin/bash

samba-tool domain backup online --targetdir=/etc/scripts/DC/BACKUP/ --server=localhost -UAdministrator

