#!/bin/bash

# Flush existing iptables rules to start fresh
iptables -F

# Set default policy to DROP all incoming and outgoing traffic
iptables -P INPUT DROP
iptables -P FORWARD DROP
iptables -P OUTPUT ACCEPT

# Allow incoming connections on port 22 (SSH), 80 (HTTP), and 443 (HTTPS)
iptables -A INPUT -p tcp --dport 22 -j ACCEPT
iptables -A INPUT -p tcp --dport 80 -j ACCEPT
iptables -A INPUT -p tcp --dport 443 -j ACCEPT

# Allow outgoing connections
iptables -A OUTPUT -j ACCEPT

# Display the current iptables rules
iptables -L -v
