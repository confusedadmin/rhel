#!/bin/bash
# V-204473

if [ $EUID != 0 ]; then
    echo "Please run as superuser."
    exit
fi

cd /home

for D in */; do

   find "/home/$D" -type d -perm /027 -not -iname .\* -exec ls -ld --time-style=long-iso {} \;  | \
   sed -e 's/ /\\ /g' | \
   awk '{print $8}'   | \
   while read line; do
      a=$(stat -c %a ${line});
      echo $a " " ${line}
      chmod o-rwx,g-w ${line}
   done

   find "/home/$D" -type f -perm /027 -not -iname .\* -exec ls -l --time-style=long-iso {} \;  | \
   sed -e 's/ /\\ /g' | \
   awk '{print $8}'   | \
   while read line; do
      a=$(stat -c %a ${line});
      echo $a " " ${line}
      chmod o-rwx,g-w ${line}
   done
done

echo -e "\nDone setting file permissions.\n\n"

