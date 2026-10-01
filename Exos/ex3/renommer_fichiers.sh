#!/bin/bash

# 1. Vérification des arguments
if [ $# -ne 1 ]; then
    echo "Usage : $0 <dossier>"
    exit 1
fi

DOSSIER="$1"

# Vérification de l'existence du dossier
if [ ! -d "$DOSSIER" ]; then
    echo "Erreur : Le dossier '$DOSSIER' n'existe pas."
    exit 1
fi

# 2. Variables et compteurs
DATE=$(date +%Y%m%d)
TRAITES=0
IGNORES=0

echo "=== Traitement des fichiers dans : $DOSSIER ==="
echo ""

# Activation de nullglob pour éviter les faux positifs si aucun .txt n'est présent
shopt -s nullglob

# Comptage initial des fichiers .txt
FICHIERS_TXT=("$DOSSIER"/*.txt)
NB_TXT=${#FICHIERS_TXT[@]}

echo "Fichiers .txt trouvés : $NB_TXT"
echo ""
echo "Renommage en cours..."

# 3. Traitement des fichiers
for CHEMIN in "$DOSSIER"/*; do
    if [ -f "$CHEMIN" ]; then
        FICHIER=$(basename "$CHEMIN")

        # Filtrage strict sur l'extension .txt
        if [[ "$FICHIER" == *.txt ]]; then
            # Remplacement des espaces par des underscores
            NOM_CLEAN=$(echo "$FICHIER" | tr ' ' '_')

            # Conversion en minuscules
            NOM_LOWER=$(echo "$NOM_CLEAN" | tr '[:upper:]' '[:lower:]')

            # Ajout du préfixe backup_AAAAMMJJ_
            NOUVEAU_NOM="backup_${DATE}_${NOM_LOWER}"

            # Renommage du fichier
            mv "$DOSSIER/$FICHIER" "$DOSSIER/$NOUVEAU_NOM"
            
            echo "✓ \"$FICHIER\" → \"$NOUVEAU_NOM\""
            ((TRAITES++))
        else
            ((IGNORES++))
        fi
    fi
done

shopt -u nullglob

# 4. Affichage du rapport
echo ""
echo "Résumé :"
echo "- Fichiers traités : $TRAITES"
echo "- Fichiers ignorés : $IGNORES"
echo "- Opération terminée avec succès !"