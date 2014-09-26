#/bin/bash
# Written by Sean Wareham on 9/26/14
# To run this, type:
# cd {directory containing update.c and install.sh}
# sudo bash install.sh
# you're done!
gcc update.c -o update
sudo chown root:root update
sudo chmod 4755 update
sudo mv update /usr/local/bin/update
