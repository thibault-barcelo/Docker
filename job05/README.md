# Job 05 — Création d'alias Docker

## Objectif

Le but de ce job est de créer des alias pour les commandes Docker les plus utilisées.

L'objectif est de pouvoir utiliser des commandes plus courtes dans le terminal.

## Fichier aliases.txt

Le fichier `aliases.txt` contient les alias suivants :

```text
alias d='docker'
alias dps='docker ps'
alias dpsa='docker ps -a'
alias di='docker images'
alias drm='docker rm'
alias drmi='docker rmi'
alias dstop='docker stop'
alias dstart='docker start'
alias dlogs='docker logs'
```

Par exemple :

```bash
dps
```

correspond à :

```bash
docker ps
```

De la même manière :

```bash
di
```

correspond à :

```bash
docker images
```

## Ajout dans le .bashrc

Les alias ont été ajoutés au fichier :

```text
~/.bashrc
```

Cela permet de les retrouver automatiquement lors de l'ouverture d'un nouveau terminal.

Après leur ajout, le fichier `.bashrc` a été rechargé avec :

```bash
source ~/.bashrc
```

## Vérification

Les alias ont ensuite été testés dans le terminal.

Par exemple :

```bash
dps
```

permet d'afficher les conteneurs Docker en cours d'exécution.

```bash
di
```

permet d'afficher les images Docker présentes sur la machine.

## À retenir

Un alias permet de donner un nom plus court à une commande.

Cela permet de gagner du temps lorsqu'une commande est utilisée régulièrement.

Dans ce job, les alias permettent donc d'utiliser plus rapidement les principales commandes Docker.

## Résultat

Les alias Docker ont été créés, ajoutés au `.bashrc` et testés avec succès.
