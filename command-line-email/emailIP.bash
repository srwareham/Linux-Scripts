#!/bin/bash
toEmail="address@server.com"
IP=$(curl -s checkip.dyndns.org|sed -e 's/.*Current IP Address: //' -e 's/<.*$//')
echo "$IP" | mail -s "IP Address Update" "$toEmail"
