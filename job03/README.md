# Job 03 — Création d'une image Docker

## Objectif

Le but de ce job est de créer une première image Docker personnalisée à partir d'une image Debian minimale.

L'objectif est simplement d'afficher un message `Hello World !` lorsque le conteneur est lancé.

## Dockerfile

Le fichier `Dockerfile` utilisé est :

```dockerfile
FROM debian:trixie-slim

CMD ["echo", "Hello World !"]
```

### Explication

`FROM` indique l'image de base utilisée pour construire notre image.

Ici, on utilise une version légère de Debian :

```text
debian:trixie-slim
```

`CMD` indique la commande qui sera exécutée au démarrage du conteneur.

Dans notre cas :

```text
echo "Hello World !"
```

## Construction de l'image

Depuis le dossier `job03`, l'image a été construite avec :

```bash
docker build -t helloworld .
```

Le nom donné à notre image est :

```text
helloworld
```

## Test

Le conteneur a ensuite été lancé avec :

```bash
docker run --rm helloworld
```

Le résultat obtenu est :

```text
Hello World !
```

L'option `--rm` permet de supprimer automatiquement le conteneur après son arrêt.

## Résultat

La première image Docker personnalisée a été créée avec succès à partir de Debian et testée avec un conteneur.
