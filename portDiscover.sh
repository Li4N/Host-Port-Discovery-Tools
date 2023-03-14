#!/bin/bash
if [[ $# -gt 0 ]]
then
    for port in {1..65535}; do
      timeout 1 bash -c "echo '' > /dev/tcp/$1/$port" &>/dev/null && echo "[+] $1:$port - OPEN" &
    done; wait
else
  echo "Introduce una IP. (P.E.: XXX.XXX.XXX.XXX)"
  exit 0
fi
