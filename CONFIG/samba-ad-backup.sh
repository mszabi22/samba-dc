#!/bin/bash

samba-tool domain backup offline --targetdir=~/BACKUP/ --server=localhost -UAdministrator

