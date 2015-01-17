#!/bin/bash
toEmail="address@server.com"
IP=$(curl -s checkip.dyndns.org|sed -e 's/.*Current IP Address: //' -e 's/<.*$//')
# NOTE: most modern email services will prohibit the mail implementation used, special settings will likely need to be made to recieve them
echo "$IP" | mail -s "IP Address Update" "$toEmail"
