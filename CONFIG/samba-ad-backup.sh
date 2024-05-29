#!/bin/bash

samba-tool domain backup online --targetdir=~/BACKUP/ --server=localhost -UAdministrator

