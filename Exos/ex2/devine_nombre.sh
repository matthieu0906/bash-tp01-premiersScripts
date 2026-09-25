#!/bin/bash

################################################################################
# Script : devine_nombre.sh
# Description : Jeu de devinette - trouver un nombre aléatoire
# Usage : ./devine_nombre.sh <min> <max> [difficile]
# Auteur : [Votre nom]
# Date : [Date]
################################################################################

# TODO: Vérifier que 2 paramètres sont fournis


# TODO: Valider que les paramètres sont des nombres
if [[ "$nombre" =~ ^-?[0-9]+$ ]]; then
    echo "c'est un nombre entier"
else
    echo "Ce n'est pas un nombre"
fi

# TODO: Valider que min < max
min=$1
max=$2
echo "Rentrez le premier nombre"
read min 
echo "Rentrez le second nombre"
read max 


if [ $min -lt $max ]; then 
    echo "min est inférieur à max"


# TODO: Générer un nombre aléatoire entre min et max


# TODO: Initialiser le nombre d'essais (5 par défaut, 3 en mode difficile)


# TODO: Boucle de jeu avec 5 essais maximum


# TODO: Afficher le message de fin (victoire ou défaite)

