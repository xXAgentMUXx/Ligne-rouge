#!/bin/bash

SRC="/home/vboxuser/Documents/"
TMP_DIR="/tmp/backup_split"
PART1="$TMP_DIR/part1"
PART2="$TMP_DIR/part2"
DEST1="vboxuser@192.168.56.102:/home/vboxuser/sauvegardes/"
DEST2="vboxuser@192.168.56.103:/home/vboxuser/sauvegardes/"

# Nettoyage et préparation
echo "[INFO] Préparation du dossier temporaire..."
rm -rf "$TMP_DIR"
mkdir -p "$PART1" "$PART2"

# Répartition des fichiers
i=0
for file in "$SRC"*; do
    if [ $((i % 2)) -eq 0 ]; then
        cp -r "$file" "$PART1/"
    else
        cp -r "$file" "$PART2/"
    fi
    i=$((i + 1))
done

# Envoi direct des fichiers vers les VMs
rsync -avz "$PART1/" "$DEST1"
rsync -avz "$PART2/" "$DEST2"

# Nettoyage final
rm -rf "$TMP_DIR"
echo "✅ Sauvegarde divisée envoyée sur VM2 et VM3."

