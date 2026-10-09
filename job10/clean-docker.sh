#!/bin/bash

# Évite qu'une variable non définie provoque une erreur
set -u

# Vérifie que le script est lancé en root
[ "$EUID" -eq 0 ] || exit 1

# Supprime tous les conteneurs Docker
# même ceux qui sont actuellement arrêtés
docker ps -aq | xargs -r docker rm -f

# Supprime toutes les images Docker
docker images -aq | xargs -r docker rmi -f

# Supprime tous les volumes Docker
docker volume ls -q | xargs -r docker volume rm -f

# Supprime les réseaux Docker qui ne sont plus utilisés
docker network prune -f

# Arrête et désactive les services Docker
systemctl disable --now docker docker.socket containerd

# Désinstalle les paquets Docker
apt-get purge -y docker-ce docker-ce-cli containerd.io docker-compose-plugin docker-buildx-plugin

# Supprime les dépendances devenues inutiles
apt-get autoremove -y --purge

# Supprime les données et la configuration de Docker
rm -rf /var/lib/docker /etc/docker

# Supprime les données de containerd
rm -rf /var/lib/containerd*

# Supprime le dépôt Docker des sources APT
rm -rf /etc/apt/sources.list.d/docker.list
