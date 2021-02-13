#!/bin/bash

#This script kills that Stubborn ass isc-dhcp-server that hates to admit its wrong
sudo systemctl stop isc-dhcp-server
sudo kill -9 `cat /var/run/dhcpd.pid`
sudo rm -rf /var/run/dhcpd.pid
sudo systemctl start isc-dhcp-server
