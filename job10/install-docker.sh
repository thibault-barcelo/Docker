#!/bin/bash

# Arrête le script dès qu'une commande échoue
# ou qu'une variable utilisée n'existe pas
set -euo pipefail

# Vérifie que le script est lancé en root
[ "$EUID" -eq 0 ] || { echo "Lancer avec sudo"; exit 1; }

# Récupère les informations du système
. /etc/os-release

# Vérifie que le système utilisé est Debian
[ "$ID" = "debian" ] || { echo "Debian requis"; exit 1; }

# Met à jour la liste des paquets
# puis installe les outils nécessaires
apt-get update && apt-get install -y ca-certificates curl

# Crée le dossier qui contiendra la clé du dépôt Docker
install -m 0755 -d /etc/apt/keyrings

# Télécharge la clé officielle du dépôt Docker
# et la place dans le dossier des clés
curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc

# Ajoute le dépôt officiel Docker aux sources APT
# $VERSION_CODENAME permet d'utiliser automatiquement
# la version de Debian installée
echo "deb [signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian $VERSION_CODENAME stable" > /etc/apt/sources.list.d/docker.list

# Met à jour les dépôts pour prendre en compte Docker
apt-get update

# Installe Docker, Docker Compose et Docker Buildx
apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin docker-buildx-plugin

# Ajoute l'utilisateur à la liste du groupe Docker
# pour pouvoir utiliser Docker sans sudo après reconnexion
usermod -aG docker "${SUDO_USER:-root}"

# Vérifie que Docker fonctionne correctement
# en lançant le conteneur de test officiel
docker run --rm hello-world
