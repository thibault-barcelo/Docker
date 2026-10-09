# Job 09 — Création d'un registre Docker local

## Objectif

Le but de ce job est de mettre en place un registre Docker local afin de pouvoir stocker des images Docker sur notre propre machine.

Une interface web a également été ajoutée pour consulter les images présentes dans le registre.

L'interface a ensuite été protégée par un mot de passe.

## Création du registre

Le registre Docker utilise l'image officielle `registry:2`.

Le fichier `docker-compose.yml` contient plusieurs services :

* le registre Docker ;
* l'interface web ;
* un serveur Nginx utilisé comme protection par mot de passe.

Le registre utilise le port `5000` :

```yaml
ports:
  - "5000:5000"
```

L'interface web est accessible sur le port `8082`.

## Interface web

L'interface utilisée est :

```text
joxit/docker-registry-ui
```

Elle permet de visualiser les images présentes dans le registre depuis un navigateur.

L'interface n'est pas directement exposée sur le port `8082`. Elle est accessible à travers un conteneur Nginx qui sert également de protection.

## Protection par mot de passe

Pour protéger l'interface, le paquet `apache2-utils` a été installé :

```bash
apt install -y apache2-utils
```

Un fichier d'authentification a ensuite été créé avec :

```bash
htpasswd -c ./auth admin
```

Le fichier contient le mot de passe sous forme de hash.

La configuration Nginx utilise ensuite ce fichier :

```nginx
location / {
    auth_basic "Registry UI";
    auth_basic_user_file /etc/nginx/auth;

    proxy_pass http://registry-ui:80;

    proxy_set_header Host $host;
    proxy_set_header X-Real-IP $remote_addr;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
}
```

L'utilisateur doit donc entrer ses identifiants pour accéder à l'interface web.

Le fichier `auth` n'est pas envoyé sur GitHub. Il est exclu grâce au fichier `.gitignore`.

## Persistance des données

Un volume Docker a été ajouté au registre :

```yaml
volumes:
  - registry-data:/var/lib/registry
```

Ce volume permet de conserver les images présentes dans le registre même lorsque les conteneurs sont arrêtés puis recréés.

Le volume est déclaré à la fin du fichier Compose :

```yaml
volumes:
  registry-data:
```

## Démarrage

Les services sont démarrés avec :

```bash
docker compose up -d
```

Pour vérifier leur état :

```bash
docker compose ps
```

L'API du registre peut être testée avec :

```bash
curl http://localhost:5000/v2/
```

Lorsque le registre fonctionne correctement, la commande retourne :

```text
{}
```

L'interface web est accessible depuis le navigateur avec :

```text
http://192.168.0.138:8082
```

Une authentification est demandée avant d'accéder à l'interface.

## Organisation des images

Les images ont été organisées dans le registre par numéro de job.

La structure utilisée est :

```text
Registry Docker
│
├── job02/
│   └── hello-world
├── job03/
│   └── helloworld
├── job04/
│   └── ssh-custom
├── job07/
│   ├── nginx
│   └── vsftpd
├── job08/
│   └── nginx-custom
└── job09/
    ├── registry
    └── registry-ui
```

Pour ajouter une image au registre local, elle doit d'abord être renommée avec l'adresse du registre.

Par exemple :

```bash
docker tag helloworld:latest localhost:5000/job03/helloworld:latest
```

Puis elle peut être envoyée avec :

```bash
docker push localhost:5000/job03/helloworld:latest
```

Le même principe a été utilisé pour les autres images.

## Vérification d'un push

Exemple :

```bash
docker push localhost:5000/job03/helloworld:latest
```

Docker envoie les différentes couches de l'image vers le registre.

Lorsque certaines couches sont déjà présentes, Docker peut les réutiliser au lieu de les envoyer à nouveau.

Cela permet d'éviter de transférer inutilement les mêmes données.

## Commandes principales

Démarrer les services :

```bash
docker compose up -d
```

Arrêter les services :

```bash
docker compose down
```

Afficher les conteneurs :

```bash
docker compose ps
```

Tester le registre :

```bash
curl http://localhost:5000/v2/
```

Créer un tag pour le registre :

```bash
docker tag image:latest localhost:5000/jobXX/image:latest
```

Envoyer une image :

```bash
docker push localhost:5000/jobXX/image:latest
```

## Résultat

Un registre Docker local fonctionnel a été créé.

Une interface web permet de consulter les images et son accès est protégé par un mot de passe.

Les données du registre sont conservées grâce à un volume Docker.

Plusieurs images créées pendant les jobs précédents ont également été envoyées dans le registre et organisées par numéro de job.
