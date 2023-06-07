#!/bin/bash

# Set the network interface name (e.g., eth0, ens33)
interface="ens33"

# Set the desired IP address, subnet mask, and gateway
ip_address="192.168.232.170"
#The below command will get the current IP of the server & will set it as Static IP for Future use
#But this commented for now, if you want to use it, first comment out line number 7 

#ip_address=$(ip a | grep -w inet | cut -d " " -f6 | tail -n 1 | cut -d "/" -f
subnet_mask="255.255.255.0"
gateway="192.168.1.1"

# Set the DNS servers (optional)
dns_servers="8.8.8.8,8.8.4.4"

# Backup the original network configuration file
sudo cp /etc/netplan/00-installer-config.yaml /etc/netplan/00-installer-config.yaml.backup

# Create a new network configuration file
sudo tee /etc/netplan/00-installer-config.yaml > /dev/null <<EOT
network:
  version: 2
  renderer: networkd
  ethernets:
    $interface:
      dhcp4: no
      addresses: [$ip_address/24]
      #gateway: $gateway
      nameservers:
        addresses: [$dns_servers]
      routes:
        - to: default
          via: 192.168.1.1
EOT

# Apply the new network configuration
sudo netplan apply

# Restart the network service
sudo systemctl restart systemd-networkd

# Upon the script running successfull, it will terminate the current session, to verify the new static ip address login again and run ip a command 