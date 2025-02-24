#!/bin/bash

# Variables
SRC="/home/backupuser/Documents/"
DEST="backupuser@10.0.2.15:/home/backupuser/sauvegardes/"

# Lancer la sauvegarde via Rsync
rsync -avz --delete -e "ssh" "$SRC" "$DEST"

echo "Sauvegarde terminée avec succès."
