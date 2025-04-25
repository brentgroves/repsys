#!/bin/bash
sudo su
iptables -t nat -D POSTROUTING -s 192.168.0.0/24 -o enp0s25 -j MASQUERADE
iptables -t nat -A POSTROUTING -s 192.168.0.0/24 -o enp0s25 -j MASQUERADE
