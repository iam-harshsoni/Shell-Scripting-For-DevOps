
#!/bin/bash
#
# This is the file where you get input from user
#

read -p "Enter username: " username

echo "you entered $username"

sudo useradd -m $username

echo "New User Added !!"

