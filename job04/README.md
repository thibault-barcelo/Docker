# Job 04 — Création d'une image Docker avec SSH

## Objectif

Le but de ce job est de créer une image Docker contenant un serveur SSH.

L'image doit être créée à partir de Debian, sans utiliser directement une image Docker déjà préparée pour SSH.

## Dockerfile

Le fichier `Dockerfile` commence avec une image Debian légère :

```dockerfile
FROM debian:trixie-slim
```

Le serveur OpenSSH est ensuite installé :

```dockerfile
RUN apt-get update && \
    apt-get install -y openssh-server && \
    rm -rf /var/lib/apt/lists/*
```

Un mot de passe est configuré pour l'utilisateur root :

```dockerfile
RUN echo 'root:root123' | chpasswd
```

La configuration SSH est ensuite modifiée afin d'autoriser la connexion root avec un mot de passe.

Enfin, le dossier nécessaire au fonctionnement de SSH est créé et le port 22 est exposé :

```dockerfile
RUN mkdir -p /run/sshd

EXPOSE 22
```

Le serveur SSH est lancé au démarrage du conteneur :

```dockerfile
CMD ["/usr/sbin/sshd", "-D"]
```

## Construction de l'image

L'image a été construite avec :

```bash
docker build -t ssh-custom .
```

## Lancement du conteneur

Le conteneur a été lancé avec une redirection de port :

```bash
docker run -d --name ssh-container -p 2222:22 ssh-custom
```

Le port `2222` de la machine est donc relié au port `22` du conteneur.

```text
Machine Debian : 2222
        ↓
Conteneur Docker : 22
        ↓
Serveur SSH
```

## Test de connexion

La connexion SSH a été testée avec :

```bash
ssh root@localhost -p 2222
```

La connexion a fonctionné correctement.

## Résultat

Une image Docker contenant un serveur SSH a été créée et testée avec succès.

Le principe de redirection de ports Docker a également été utilisé pour accéder au service SSH depuis la machine hôte.
