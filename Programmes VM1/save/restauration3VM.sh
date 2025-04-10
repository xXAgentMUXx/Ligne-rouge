#!/bin/bash

TMP_DIR="/tmp/restore_merge"
DEST="/home/vboxuser/Documents/"
SRC1="vboxuser@192.168.56.102:/home/vboxuser/sauvegardes/"
SRC2="vboxuser@192.168.56.103:/home/vboxuser/sauvegardes/"

# Nettoyage
echo "[INFO] Préparation du dossier temporaire de restauration..."
rm -rf "$TMP_DIR"
mkdir -p "$TMP_DIR"

# Récupération des deux dossiers de sauvegarde
rsync -avz "$SRC1" "$TMP_DIR/part1"
rsync -avz "$SRC2" "$TMP_DIR/part2"

# Fusion des fichiers restaurés dans le dossier Documents
cp -r "$TMP_DIR/part1/"* "$DEST"
cp -r "$TMP_DIR/part2/"* "$DEST"

# Nettoyage final
rm -rf "$TMP_DIR"
echo "✅ Restauration fusionnée terminée depuis VM2 et VM3."

