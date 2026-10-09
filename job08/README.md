# Job 08 — Création d'une image Docker avec Nginx

## Objectif

Le but de ce job est de créer une image Docker contenant un serveur Nginx.

Contrairement au Job 07, l'image Nginx n'est pas utilisée directement. Elle est créée à partir d'une image Debian.

## Dockerfile

Le fichier `Dockerfile` utilisé est :

```dockerfile
FROM debian:trixie-slim

RUN apt-get update && \
    apt-get install -y nginx && \
    rm -rf /var/lib/apt/lists/*

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
```

### Explication

L'image de base utilisée est une version légère de Debian :

```dockerfile
FROM debian:trixie-slim
```

Nginx est ensuite installé directement dans l'image :

```dockerfile
RUN apt-get update && \
    apt-get install -y nginx && \
    rm -rf /var/lib/apt/lists/*
```

Le port `80` est ensuite déclaré :

```dockerfile
EXPOSE 80
```

Enfin, Nginx est lancé au démarrage du conteneur :

```dockerfile
CMD ["nginx", "-g", "daemon off;"]
```

L'option `daemon off;` permet de garder Nginx au premier plan afin que le conteneur reste actif.

## Construction de l'image

Depuis le dossier `job08`, l'image a été construite avec :

```bash
docker build -t nginx-custom .
```

L'image obtenue s'appelle :

```text
nginx-custom
```

## Lancement du conteneur

Le conteneur a été lancé avec :

```bash
docker run -d --name job08-nginx -p 8081:80 nginx-custom
```

Le port `8081` de la machine est donc redirigé vers le port `80` du conteneur.

```text
Machine Debian : 8081
        ↓
Conteneur Docker : 80
        ↓
Nginx
```

## Test

Le serveur Nginx a été testé avec :

```bash
curl http://localhost:8081
```

La page d'accueil Nginx a été retournée correctement.

Le serveur a également été testé depuis le navigateur avec :

```text
http://192.168.0.138:8081
```

## Résultat

Une image Docker personnalisée contenant Nginx a été créée à partir de Debian.

Le conteneur a ensuite été lancé et testé avec succès grâce à une redirection de port.
