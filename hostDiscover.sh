#!/bin/bash
if [[ $# -gt 0 ]]
then
  rangeIp=$1
    for i in {1..256}; do
      ping -c1 $1.$i &> /dev/null && echo "[+] HOST $1.$i - ACTIVE" &
    done; wait
else
  echo "introduce la primera parte del rango como XX.XX.XX" 
  exit 0
fi
