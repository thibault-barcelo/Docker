# Job 07 — Docker Compose avec Nginx et FTP

## Objectif

Le but de ce job est de créer deux conteneurs avec Docker Compose :

* un serveur Nginx pour afficher une page web ;
* un serveur FTP pour envoyer des fichiers.

Les deux conteneurs utilisent le même dossier partagé.

## Fichier docker-compose.yml

Le fichier `docker-compose.yml` contient deux services :

```yaml
services:

  nginx:
    image: nginx:latest
    container_name: job07-nginx
    ports:
      - "8080:80"
    volumes:
      - ./site:/usr/share/nginx/html

  ftp:
    image: fauria/vsftpd
    container_name: job07-ftp
    ports:
      - "21:21"
      - "21100-21110:21100-21110"
    environment:
      FTP_USER: admin
      FTP_PASS: admin123
      PASV_ADDRESS: 192.168.0.138
      PASV_MIN_PORT: 21100
      PASV_MAX_PORT: 21110
    volumes:
      - ./site:/home/vsftpd/admin
```

## Volume partagé

Les deux services utilisent le même dossier :

```text
./site
```

Pour Nginx, il correspond à :

```text
/usr/share/nginx/html
```

Pour le serveur FTP, il correspond à :

```text
/home/vsftpd/admin
```

Cela permet de partager les fichiers entre les deux conteneurs.

```text
                 dossier ./site
                 /          \
                /            \
           Nginx              FTP
            │                  │
       affichage web       transfert de fichiers
```

## Page web

Une page `index.html` a été créée dans le dossier `site`.

Son contenu permet notamment d'afficher :

```html
<h1>Bonjour, je suis Jade Borel !</h1>
```

La page est donc directement accessible par Nginx grâce au volume partagé.

## Lancement avec Docker Compose

Les conteneurs ont été démarrés avec :

```bash
docker compose up -d
```

Pour vérifier les conteneurs :

```bash
docker compose ps
```

Les deux services doivent être démarrés.

## Test avec Nginx

Nginx est accessible sur le port `8080` de la machine :

```bash
curl http://localhost:8080
```

La page peut également être ouverte depuis le navigateur avec :

```text
http://192.168.0.138:8080
```

La page `index.html` est alors affichée.

## Test avec FileZilla

Le serveur FTP a été testé depuis la machine hôte avec FileZilla.

Les paramètres utilisés sont :

```text
Hôte : 192.168.0.138
Utilisateur : admin
Mot de passe : admin123
Port : 21
```

Le fichier `index.html` peut être envoyé dans le dossier FTP.

Comme le dossier FTP et le dossier Nginx sont partagés, le fichier envoyé par FTP est ensuite disponible pour Nginx.

## Ports utilisés

Les ports suivants ont été utilisés :

```text
21              → FTP
21100-21110     → FTP passif
8080            → Nginx
```

Le port `8080` de la machine est redirigé vers le port `80` du conteneur Nginx.

## Commandes principales

Pour démarrer les services :

```bash
docker compose up -d
```

Pour voir leur état :

```bash
docker compose ps
```

Pour arrêter les services :

```bash
docker compose down
```

## Résultat

Les deux conteneurs ont été configurés avec Docker Compose.

Le serveur FTP permet d'envoyer des fichiers dans le dossier partagé et Nginx permet ensuite de les afficher sur le site web.

Le fonctionnement du partage de fichiers entre plusieurs conteneurs avec Docker Compose a ainsi été mis en pratique.
