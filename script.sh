#!/bin/bash

# made by Bram Suurd
# bram.suurd@student.nhlstenden.com
# 5371333

# set some colors
CNT="[\e[1;36mNOTE\e[0m]"
COK="[\e[1;32mOK\e[0m]"
CER="[\e[1;31mERROR\e[0m]"
CAT="[\e[1;37mATTENTION\e[0m]"
CWR="[\e[1;35mWARNING\e[0m]"
CAC="[\e[1;33mACTION\e[0m]"

clear

if [ "$EUID" -ne 0 ]
  then echo -e $CER "Please run as root"
  exit
fi

echo -e $CNT "This script is made to add a new user to samba and create a home folder for him."

sleep 2

echo -en $CAC "Please enter a username: " 
read username

echo -en $CAC "Please enter a password: "
read password

useradd $username  > /dev/null 2>&1

if [ $(getent passwd $username) ]; then
  echo -e $COK "User $username was added successfully"
else
  echo -e $CER "User $username could not be added... exiting"
  exit
fi

echo "$username:$password" | chpasswd

dir="/public/files/homefolder/$username"

if [ ! -d "$dir" ]; then
  echo -e $CNT "Directory does not exist, creating directory..."
  mkdir -p "$dir"
fi

echo "[$username]
   path = $dir
   read only = no
   browsable = yes" >> /etc/samba/smb.conf

(echo "$password"; echo "$password") | smbpasswd -s -a $username  > /dev/null 2>&1

smbpasswd -e $username  > /dev/null 2>&1

service smbd restart  > /dev/null 2>&1

if [ $(getent passwd $username) ]; then
  echo -e $COK "User $username was added successfully"
else
  echo -e $CER "User $username was not added"
fi