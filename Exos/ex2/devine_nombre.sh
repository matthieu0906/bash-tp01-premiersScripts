#!/bin/bash

################################################################################
# Script : devine_nombre.sh
# Description : Jeu de devinette - trouver un nombre aléatoire
# Usage : ./devine_nombre.sh <min> <max> [difficile]
# Auteur : [Votre nom]
# Date : [Date]
################################################################################

# TODO: Vérifier que 2 paramètres sont fournis 
if [ $# -eq 2 ]; then
    min=$1
    max=$2
else
    echo "Rentrez le premier nombre (min) :"
    read min 
    echo "Rentrez le second nombre (max) :"
    read max 
fi

# TODO: Valider que les paramètres sont des nombres entiers
if ! [[ "$min" =~ ^-?[0-9]+$ ]] || ! [[ "$max" =~ ^-?[0-9]+$ ]]; then
    echo "Erreur : vous devez saisir deux nombres entiers valides." >&2
    exit 1
fi

# TODO: Valider que min < max
if [ $min -ge $max ]; then 
    echo "Erreur : min ($min) doit être strictement inférieur à max ($max)." >&2
    exit 1
fi    

echo "Nombre fixé entre $min et $max."

# TODO: Générer un nombre aléatoire entre min et max
nombre=$(( RANDOM % (max - min + 1) + min ))

# TODO: Initialiser le nombre d'essais
essaismax=5
i=1
victoire=0

# TODO: Boucle de jeu
while [ $i -le $essaismax ]; do 
    echo "Essai $i/$essaismax - Entrez votre nombre :"
    read nombrejoueur
    
    if ! [[ "$nombrejoueur" =~ ^-?[0-9]+$ ]]; then
        echo "Veuillez entrer un nombre entier valide."
        continue
    fi

    if [ $nombrejoueur -lt $nombre ]; then
        echo "Trop petit !"
    elif [ $nombrejoueur -gt $nombre ]; then
        echo "Trop grand !"
    else
        echo "Bravo ! Vous avez trouvé le nombre $nombre en $i essai(s) !"
        victoire=1
        break
    fi

    i=$((i + 1))
done

if [ $victoire -eq 0 ]; then
    echo "Dommage ! Vous avez épuisé vos $essaismax essais. Le nombre était : $nombre."
fi
