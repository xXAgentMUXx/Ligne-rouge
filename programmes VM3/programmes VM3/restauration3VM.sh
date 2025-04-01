#!/bin/bash

SOURCE1="vboxuser@192.168.56.101:/home/vboxuser/sauvegardes2/"
SOURCE2="vboxuser@192.168.56.102:/home/vboxuser/sauvegardes2/"
DEST="/home/vboxuser/Documents/"

echo "Restaurer depuis :"
echo "1) VM1"
echo "2) VM2"
read choix

if [ "$choix" == "1" ]; then
    rsync -avz --delete -e "ssh" "$SOURCE1" "$DEST"
    echo "Restauration depuis VM1 terminée."
elif [ "$choix" == "2" ]; then
    rsync -avz --delete -e "ssh" "$SOURCE2" "$DEST"
    echo "Restauration depuis VM2 terminée."
else
    echo "Choix invalide."
fi
