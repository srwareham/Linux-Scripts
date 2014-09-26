#/bin/bash
# Written by Sean Wareham on 9/26/14
# To run this, type:
# cd {directory containing syncme.c and install.sh}
# sudo bash install.sh
# you're done!
gcc syncme.c -o syncme
sudo chown root:root syncme
sudo chmod 4755 update
sudo mv syncme /usr/local/bin/syncme
