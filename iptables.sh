#!/bin/bash
#
# WARNING: IT DOES NOT WORK!
#

SERVER=1.2.3.4

iptables -t nat -N STUNNEL

iptables -t nat -A STUNNEL -p tcp -d $SERVER --dport 9080 -j RETURN

iptables -t nat -A STUNNEL -d 0.0.0.0/8 -j RETURN
iptables -t nat -A STUNNEL -d 10.0.0.0/8 -j RETURN
iptables -t nat -A STUNNEL -d 127.0.0.0/8 -j RETURN
iptables -t nat -A STUNNEL -d 169.254.0.0/16 -j RETURN
iptables -t nat -A STUNNEL -d 172.16.0.0/12 -j RETURN
iptables -t nat -A STUNNEL -d 192.168.0.0/16 -j RETURN
iptables -t nat -A STUNNEL -d 224.0.0.0/4 -j RETURN
iptables -t nat -A STUNNEL -d 240.0.0.0/4 -j RETURN

iptables -t nat -A STUNNEL -p tcp -j REDIRECT --to-ports 9051

iptables -t nat -A OUTPUT -p tcp -j STUNNEL
iptables -t nat -A PREROUTING -p tcp -j STUNNEL
