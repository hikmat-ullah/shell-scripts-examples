#!/bin/bash

cd profiles

scp *.profile root@worker-node01:/etc/apparmor.d 2> /dev/null

ssh root@worker-node01 apparmor_parser -q /etc/apparmor.d/* 2> /dev/null

echo "The following are the new loaded Profiles"

ssh root@worker-node01 head -n 2 /sys/kernel/security/apparmor/profiles 2> /dev/null
