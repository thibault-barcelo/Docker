# Job 01 — Installation de Docker

## Objectif

Le but de ce premier job est de préparer une machine virtuelle Debian et d'y installer Docker.

## Configuration de la machine

* Système : Debian 13 (Trixie)
* RAM : 1 Go
* CPU : 1 vCPU
* Disque : 8 Go

## Préparation de Debian

Avant d'installer Docker, les sources APT de Debian ont été vérifiées et corrigées afin de pouvoir installer les paquets depuis les dépôts Debian.

Les paquets nécessaires à l'installation de Docker ont ensuite été installés :

```bash
apt install -y ca-certificates curl gnupg
```

## Installation de Docker

Le dépôt officiel Docker a été ajouté à Debian avec sa clé de signature.

Les principaux composants installés sont :

* Docker Engine
* Docker CLI
* containerd
* Docker Compose
* Docker Buildx

Installation avec :

```bash
apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

## Vérification

Pour vérifier que Docker fonctionne correctement, le conteneur de test `hello-world` a été lancé :

```bash
docker run hello-world
```

Le message `Hello from Docker!` a confirmé que Docker était correctement installé et fonctionnel.

## Résultat

La machine Debian est maintenant prête à utiliser Docker pour les jobs suivants.
