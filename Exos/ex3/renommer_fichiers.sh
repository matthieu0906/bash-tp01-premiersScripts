#!/bin/bash

################################################################################
# Script : renommer_fichiers.sh
# Description : Renomme les fichiers .txt d'un dossier
#               - Remplace les espaces par des underscores
#               - Convertit en minuscules
#               - Ajoute un préfixe avec la date
# Usage : ./renommer_fichiers.sh <dossier> [--dry-run]
# Auteur : [Votre nom]
# Date : [Date]
################################################################################

# Vérifier qu'un dossier est fourni en paramètre
if [ $# -ne 1 ]; then
    echo "Erreur : vous devez fournir un dossier en paramètre."
    echo "Usage : $0 <dossier>"
    exit 1
fi

DOSSIER="$1"

# Vérifier que le dossier existe
if [ ! -d "$DOSSIER" ]; then
    echo "Erreur : le dossier '$DOSSIER' n'existe pas."
    exit 1
fi

# Récupérer la date du jour au format AAAAMMJJ
DATE=$(date +%Y%m%d)

# Initialiser les compteurs
TRAITES=0
IGNORES=0

echo "=== Traitement des fichiers dans : $DOSSIER ==="
echo ""

# Activer nullglob pour gérer correctement le cas où aucun fichier .txt n'existe
shopt -s nullglob

# Compter le nombre de fichiers .txt
FICHIERS_TXT=("$DOSSIER"/*.txt)
NB_TXT=${#FICHIERS_TXT[@]}

echo "Fichiers .txt trouvés : $NB_TXT"
echo ""
echo "Renommage en cours..."

# Boubler sur tous les fichiers du dossier pour traiter les .txt et compter les ignorés
for CHEMIN in "$DOSSIER"/*; do
    if [ -f "$CHEMIN" ]; then
        FICHIER=$(basename "$CHEMIN")

        if [[ "$FICHIER" == *.txt ]]; then
            # Extraire le nom sans extension
            NOM_SANS_EXT="${FICHIER%.txt}"

            # Remplacer les espaces par des underscores
            NOM_CLEAN=$(echo "$NOM_SANS_EXT" | tr ' ' '_')

            # Convertir en minuscules
            NOM_LOWER=$(echo "$NOM_CLEAN" | tr '[:upper:]' '[:lower:]')

            # Créer le nouveau nom avec le préfixe
            NOUVEAU_NOM="backup_${DATE}_${NOM_LOWER}.txt"

            # Effectuer le renommage réel
            mv "$DOSSIER/$FICHIER" "$DOSSIER/$NOUVEAU_NOM"
            echo "✓ \"$FICHIER\" → \"$NOUVEAU_NOM\""

            ((TRAITES++))
        else
            ((IGNORES++))
        fi
    fi
done

shopt -u nullglob

# Afficher le résumé des opérations
echo ""
echo "Résumé :"
echo "- Fichiers traités : $TRAITES"
echo "- Fichiers ignorés : $IGNORES"
echo "- Opération terminée avec succès !"
