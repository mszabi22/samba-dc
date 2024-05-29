#!/bin/bash
DOMAIN="domain.com"

samba-tool dns query localhost $DOMAIN @ ALL -U administrator
