# Job 02 — Découverte des commandes Docker

## Objectif

Le but de ce job est de découvrir les principales commandes Docker et de comprendre la différence entre une image, un conteneur, un volume et un réseau.

## Tester Docker

Pour commencer, l'image de test Docker a été lancée :

```bash
docker run hello-world
```

Cela permet de vérifier que Docker fonctionne correctement.

## Gestion des images

Quelques commandes utilisées :

```bash
docker pull nginx
docker images
docker build -t mon_app .
docker rmi mon_app
docker tag mon_app mon_compte/mon_app:latest
docker push mon_compte/mon_app:latest
```

Une image Docker sert de modèle pour créer des conteneurs.

## Gestion des conteneurs

Les principales commandes testées sont :

```bash
docker run nginx
docker run -d nginx
docker ps
docker ps -a
docker exec -it mon_nginx /bin/bash
docker stop mon_nginx
docker start mon_nginx
docker restart mon_nginx
docker logs mon_nginx
docker rm mon_nginx
```

Un conteneur est une instance créée à partir d'une image.

## Gestion des volumes

Les volumes permettent de conserver des données en dehors du conteneur.

Commandes découvertes :

```bash
docker volume create mon_volume
docker volume ls
docker volume inspect mon_volume
docker volume rm mon_volume
```

Exemple de montage d'un volume :

```bash
docker run -d --name mon_nginx -v mon_volume:/usr/share/nginx/html nginx
```

## Gestion des réseaux

Docker permet également de créer des réseaux pour faire communiquer les conteneurs entre eux.

Commandes utilisées :

```bash
docker network create mon_reseau
docker network ls
docker network inspect mon_reseau
docker network disconnect mon_reseau mon_nginx
docker network rm mon_reseau
```

## Nettoyage et événements

Quelques commandes supplémentaires ont été découvertes :

```bash
docker system prune
docker system prune -a
docker events
docker events --filter "type=container"
docker events --filter "event=start"
```

## À retenir

Le fonctionnement de base peut être résumé ainsi :

```text
Dockerfile
    ↓
docker build
    ↓
Image
    ↓
docker run
    ↓
Conteneur
```

Les images servent donc de base aux conteneurs, tandis que les volumes permettent de conserver les données et les réseaux permettent de faire communiquer les conteneurs.

## Résultat

Les principales commandes Docker ont été testées afin de comprendre la gestion des images, conteneurs, volumes et réseaux.
