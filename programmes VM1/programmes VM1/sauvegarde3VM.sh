#!/bin/bash

SRC="/home/vboxuser/Documents/"
DEST1="vboxuser@192.168.56.102:/home/vboxuser/sauvegardes/"
DEST2="vboxuser@192.168.56.103:/home/vboxuser/sauvegardes/"

rsync -avz --delete -e "ssh" "$SRC" "$DEST1"
rsync -avz --delete -e "ssh" "$SRC" "$DEST2"

echo "Sauvegarde terminée avec succès sur VM2 et VM3."
