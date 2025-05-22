#!/bin/bash

TMP_DIR="/tmp/restore_merge"
DEST="/home/vboxuser/Documents/"
SRC1="vboxuser@192.168.56.101:/home/vboxuser/sauvegardes/"
SRC2="vboxuser@192.168.56.102:/home/vboxuser/sauvegardes/"
SRC3="vboxuser@192.168.56.103:/home/vboxuser/sauvegarde_complet/"

rm -rf "$TMP_DIR"
mkdir -p "$TMP_DIR/part1" "$TMP_DIR/part2"

echo "[INFO] Tentative de restauration répartie (VM1 + VM2)..."

SUCCESS1=false
SUCCESS2=false

rsync -avz "$SRC1" "$TMP_DIR/part1" && SUCCESS1=true
rsync -avz "$SRC2" "$TMP_DIR/part2" && SUCCESS2=true

if $SUCCESS1 && $SUCCESS2; then
    cp -r "$TMP_DIR/part1/"* "$DEST"
    cp -r "$TMP_DIR/part2/"* "$DEST"
    echo "✅ Restauration fusionnée réussie depuis VM1 et VM2."
else
    echo "[WARNING] Échec de la restauration répartie. Tentative depuis VM3..."
    rm -rf "$DEST"/*
    rsync -avz "$SRC3" "$DEST" && echo "✅ Restauration complète réussie depuis VM3." || echo "❌ Échec de la restauration depuis VM3."
fi

rm -rf "$TMP_DIR"
