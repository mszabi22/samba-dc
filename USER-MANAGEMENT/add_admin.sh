#!/bin/bash

samba-tool group addmembers administrators $1
samba-tool group addmembers "Domain Admins" $1
