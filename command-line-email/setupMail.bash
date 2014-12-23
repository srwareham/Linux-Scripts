#!/bin/bash
# Written by Sean Wareham on December 23, 2014

# This script simplifies the process of permitting emails to be sent via the command line
# As parameters, this script requires a gmail address and password (
# eventually other email clients may be supported)
# Example run: ./setupMail.bash my_username@gmail.com my_password
# If needed, this script will request sudo privilege to install necessary components
# For gmail, one account setting needs to be changed before the underlying components will be
# granted access to your account.
# Visit https://www.google.com/settings/security/lesssecureapps and permit less secure login
# Note: this is less secure because your password is stored in plaintext in configuration files
# It is highly reccomended you use this with an account explicitly for your purpose; one that does
# not have a password valuable to you.

# Example use of underlying utilities: 
#  mail -s "Subject" address@example.com < message.txt
# Where message.txt is the body of your email

account="gmail"
hostAddress=""
emailAddress="$1"
password="$2"
#TODO: change to parse the email address
# setup account on the fly once multiple providers are supported
setHostDetails(){
    if [ "$account" == "gmail" ]; then
        hostAddress="smtp.gmail.com"
    fi
}

# Install only if not present
installPrerecs(){
    # If neither is installed, run update (yes, hard-encoded and ugly)
     ( ! command -v heirloom-mailx >/dev/null 2>&1 || !  command -v heirloom-mailx >/dev/null 2>&1 ) && sudo apt-get update
    command -v msmtp >/dev/null 2>&1 || sudo apt-get install msmtp-mta
    command -v h heirloom-mailx >/dev/null 2>&1 || sudo apt-get install heirloom-mailx
}

createMSMTPRC(){
    cd ~
    mv -f .msmtprc .msmtprc_old
    echo "#Gmail account" >> .msmtprc
    echo "defaults" >> .msmtprc
    echo "logfile ~/msmtp.log" >> .msmtprc
    echo "account gmail" >> .msmtprc
    echo "auth on" >> .msmtprc
    echo "host smtp.gmail.com" >> .msmtprc
    echo "from $emailAddress" >> .msmtprc
    echo "auth on" >> .msmtprc
    echo "tls on" >> .msmtprc
    echo "tls_trust_file /usr/share/ca-certificates/mozilla/Equifax_Secure_CA.crt" >> .msmtprc
    echo "user $emailAddress" >> .msmtprc
    echo "password $password" >> .msmtprc
    echo "port 587" >> .msmtprc
    echo >> .msmtprc
    echo "account default : gmail" >> .msmtprc
}

createMAILRC(){
    cd ~
    mv -f .mailrc .mailrc_copy
    echo "set sendmail=\"/usr/bin/msmtp\"" >> .mailrc
    echo "set sendmail-arguments=\"-a gmail\"" >> .mailrc
}

installPrerecs
setHostDetails
createMSMTPRC
createMAILRC
