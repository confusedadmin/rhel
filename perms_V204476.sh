#!/bin/bash
# V-204476

if [ $EUID != 0 ]; then
    echo "Please run as superuser."
    exit
fi

cd /home

for D in */; do

   find "/home/$D" -type f -iname ".*" -perm /027 -exec ls -l --time-style=long-iso {} \;  | \
   sed -e 's/ /\\ /g' | \
   awk '{print $8}'   | \
   while read line; do
     a=$(stat -c %a ${line});
     echo $a " " ${line}
     chmod o-rwx,g-wx ${line}
   done
   
done
