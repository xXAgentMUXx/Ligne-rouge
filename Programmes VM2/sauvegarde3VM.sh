#!/bin/bash

SRC="/home/vboxuser/Documents/"
TMP_DIR="/tmp/backup_split"
PART1="$TMP_DIR/part1"
PART2="$TMP_DIR/part2"
DEST1="vboxuser@192.168.56.102:/home/vboxuser/sauvegardes2/"  # VM2
DEST2="vboxuser@192.168.56.101:/home/vboxuser/sauvegardes2/"  # VM1
DEST3="vboxuser@192.168.56.103:/home/vboxuser/sauvegarde_complet2/"  # VM3 (sauvegarde complète)

# Nettoyage
echo "[INFO] Préparation du dossier temporaire..."
rm -rf "$TMP_DIR"
mkdir -p "$PART1" "$PART2"

# Division des fichiers
i=0
for file in "$SRC"*; do
    if [ $((i % 2)) -eq 0 ]; then
        cp -r "$file" "$PART1/"
    else
        cp -r "$file" "$PART2/"
    fi
    i=$((i + 1))
done

# Sauvegardes réparties
rsync -avz "$PART1/" "$DEST1"
rsync -avz "$PART2/" "$DEST2"

# Sauvegarde complète sur VM3
rsync -avz "$SRC" "$DEST3"

# Nettoyage
rm -rf "$TMP_DIR"
echo "✅ Sauvegarde divisée sur VM1/VM2 et complète sur VM3."
