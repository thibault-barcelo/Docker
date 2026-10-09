# Job 06 — Partage d'un volume entre deux conteneurs

## Objectif

Le but de ce job est de comprendre le fonctionnement des volumes Docker et de voir comment un même volume peut être utilisé par plusieurs conteneurs.

Un volume permet de conserver des données indépendamment du conteneur qui les utilise.

## Création du volume

Un volume Docker a été créé avec :

```bash
docker volume create mon_volume
```

Pour vérifier qu'il existe :

```bash
docker volume ls
```

Le volume `mon_volume` apparaît dans la liste des volumes Docker.

## Utilisation du volume

Le même volume peut être monté dans plusieurs conteneurs.

Par exemple :

```bash
docker run -it --name conteneur1 -v mon_volume:/data debian:trixie-slim
```

Le volume est monté dans le conteneur dans le dossier :

```text
/data
```

Un deuxième conteneur peut utiliser le même volume :

```bash
docker run -it --name conteneur2 -v mon_volume:/data debian:trixie-slim
```

Les deux conteneurs utilisent donc le même espace de stockage.

## Vérification

Un fichier créé dans le volume depuis le premier conteneur peut être retrouvé depuis le deuxième conteneur.

Par exemple, depuis le premier conteneur :

```bash
echo "Bonjour depuis le conteneur 1" > /data/test.txt
```

Puis depuis le deuxième :

```bash
cat /data/test.txt
```

Le fichier est accessible car les deux conteneurs utilisent le même volume.

## Gestion du volume

Pour afficher les informations du volume :

```bash
docker volume inspect mon_volume
```

Pour supprimer le volume :

```bash
docker volume rm mon_volume
```

Le volume doit normalement être inutilisé avant sa suppression.

## À retenir

Un volume permet de stocker des données en dehors du système de fichiers propre au conteneur.

Plusieurs conteneurs peuvent monter le même volume afin de partager des fichiers.

```text
             ┌── Conteneur 1
             │
mon_volume ──┤
             │
             └── Conteneur 2
```

Cela permet notamment de conserver les données même lorsqu'un conteneur est supprimé.

## Résultat

Le fonctionnement des volumes Docker a été étudié et le partage d'un même volume entre plusieurs conteneurs a été compris.
