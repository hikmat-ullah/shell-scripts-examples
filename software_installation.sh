#!/bin/bash

curl -fsSL https://falco.org/repo/falcosecurity-packages.asc | \
  sudo gpg --dearmor -o /usr/share/keyrings/falco-archive-keyring.gpg

sudo cat >/etc/apt/sources.list.d/falcosecurity.list <<EOF
deb [signed-by=/usr/share/keyrings/falco-archive-keyring.gpg] https://download.falco.org/packages/deb stable main
EOF

sudo apt-get update -y
sudo apt-get install -y dkms make linux-headers-$(uname -r)
sudo apt-get install -y dialog
sudo apt-get install -y falco
sudo systemctl is-active falco
sudo systemctl start falco
sudo systemctl status falco
