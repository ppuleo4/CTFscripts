#!/bin/bash

read -p "Enter IP of box " IP
read -p "Enter the name of the box " Name
echo $Name
echo $IP
mkdir -p $Name
cd $Name
filename="nmap_$Name.txt"

nmap -sV -sC $IP -oN $filename

word_to_search="http"
found=false

if grep -q "$word_to_search" "$filename"; then
        found=true
  fi

if "$found" == true; then
  gobuster dir -u http://$IP -w /usr/share/dirb/wordlists/common.txt
else
  echo "There is not http server found"
fi
