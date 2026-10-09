# Job 10 — Installation et nettoyage automatique de Docker

## Objectif

Le but de ce job est de créer deux scripts Bash permettant d'automatiser la gestion de Docker :

* `install-docker.sh` pour installer Docker automatiquement ;
* `clean-docker.sh` pour supprimer Docker et ses ressources.

Les scripts permettent d'éviter de refaire manuellement toutes les commandes d'installation ou de nettoyage.

## Script install-docker.sh

Le script commence par vérifier qu'il est exécuté avec les droits root :

```bash
[ "$EUID" -eq 0 ] || { echo "Lancer avec sudo"; exit 1; }
```

Il vérifie ensuite que le système utilisé est bien Debian :

```bash
. /etc/os-release
[ "$ID" = "debian" ] || { echo "Debian requis"; exit 1; }
```

Les paquets nécessaires sont ensuite installés :

```bash
apt-get update && apt-get install -y ca-certificates curl
```

Le dépôt officiel Docker est ajouté avec sa clé de signature.

Docker est ensuite installé avec :

```bash
apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin docker-buildx-plugin
```

Enfin, le script lance un conteneur `hello-world` afin de vérifier que Docker fonctionne :

```bash
docker run --rm hello-world
```

### Sécurité du script

Le script utilise :

```bash
set -euo pipefail
```

Cela permet notamment d'arrêter le script lorsqu'une commande rencontre une erreur.

## Script clean-docker.sh

Le deuxième script permet de supprimer Docker et les ressources associées.

Il commence également par vérifier les droits root :

```bash
[ "$EUID" -eq 0 ] || exit 1
```

### Suppression des conteneurs

Tous les conteneurs présents sont supprimés :

```bash
docker ps -aq | xargs -r docker rm -f
```

### Suppression des images

Toutes les images Docker sont ensuite supprimées :

```bash
docker images -aq | xargs -r docker rmi -f
```

### Suppression des volumes

Les volumes Docker sont également supprimés :

```bash
docker volume ls -q | xargs -r docker volume rm -f
```

### Nettoyage des réseaux

Les réseaux Docker inutilisés sont supprimés :

```bash
docker network prune -f
```

### Suppression du service Docker

Docker, Docker Socket et containerd sont arrêtés et désactivés :

```bash
systemctl disable --now docker docker.socket containerd
```

Les paquets Docker sont ensuite supprimés :

```bash
apt-get purge -y docker-ce docker-ce-cli containerd.io docker-compose-plugin docker-buildx-plugin
```

Les dépendances devenues inutiles sont également supprimées :

```bash
apt-get autoremove -y --purge
```

Enfin, les fichiers et données Docker sont supprimés :

```bash
rm -rf /var/lib/docker /etc/docker
rm -rf /var/lib/containerd*
rm -rf /etc/apt/sources.list.d/docker.list
```

## Vérification des scripts

Avant leur utilisation, la syntaxe des deux scripts a été vérifiée avec :

```bash
bash -n install-docker.sh
bash -n clean-docker.sh
```

Aucune erreur de syntaxe n'a été retournée.

Les scripts ont également été rendus exécutables :

```bash
chmod +x install-docker.sh clean-docker.sh
```

Le script d'installation a ensuite été exécuté et l'installation de Docker a été vérifiée avec `hello-world`.

## Résultat

Deux scripts Bash permettent maintenant d'automatiser l'installation et la suppression de Docker.

Le script d'installation permet de retrouver rapidement un environnement Docker fonctionnel.

Le script de nettoyage permet de supprimer Docker ainsi que les conteneurs, images, volumes et fichiers associés.
