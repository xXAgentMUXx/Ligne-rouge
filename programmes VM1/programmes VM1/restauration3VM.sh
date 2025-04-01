#!/bin/bash

SOURCE1="vboxuser@192.168.56.102:/home/vboxuser/sauvegardes/"
SOURCE2="vboxuser@192.168.56.103:/home/vboxuser/sauvegardes/"
DEST="/home/vboxuser/Documents/"

echo "Restaurer depuis :"
echo "1) VM2"
echo "2) VM3"
read choix

if [ "$choix" == "1" ]; then
    rsync -avz --delete -e "ssh" "$SOURCE1" "$DEST"
    echo "Restauration depuis VM2 terminée."
elif [ "$choix" == "2" ]; then
    rsync -avz --delete -e "ssh" "$SOURCE2" "$DEST"
    echo "Restauration depuis VM3 terminée."
else
    echo "Choix invalide."
fi
