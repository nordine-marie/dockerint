# Fonctionnement de Docker 

## Sommaire   

1. Avantage de Docker et description
2. Versions et outils
3. Container 
    * Lancer
    * Rentrer dedans
    * Arreter
    * Supprimer
4. Serveur Nginx
5. Récupérer une image sans la lancer 
6. Afficher l'ensemble contauner existant 
7. Nettoyer système 
8. Créer sa propre image
9. Créer DockerFile
   * Dockerfile
   * Git
   * Construire
10. Créer image DockerHub
11. Docker compose

## Avantage de Docker et description
Le plus : code fonctionne partout, n'isole que ressources nécessaires, démarrage rapide, développement plus autonome, réduites cout, augmente densité de l'infrastructure et améliore cycle déploiement.
Conteneur : isole et le fige dans le temps un seul processus (donc un pour php un pour MySQL etc), on pourra récupérer cet état a tout moment depuis n'importe où et cela fonctionnera. 

## Versions et outils 
Versions Docker : 
Docker Desktop (windows ou mac) a installer et Docker CE gratuit (linux)
Docker entreprise (sous licence)
Les outils : 
Docker Hub : équivalent de github stock image 

## Container
### Lancer
docker run nom *(-d ou --detach si besoin multiple ou garder allumer jusqu'à fin service)*
Docker cherche si "nom" dispo en local sinon sur registry Docker
### Rentrer dedans
docker exec -ti ID_RUN_DONNE Bash
cd /use/share/nginx/hotml
Modif index.html 
### Arreter
docker stop ID_RUN 
### Supprimer
docker rm ID_RUN

## Serveur Nginx
Docker fun -d -p(utilisation des ports) 8080:80 ngix 
En allant sur http://127.0.0.1.8080 page défaut de nginx

## Récupérer une image sans la lancer 
docker pull nom

## Afficher l'ensemble container existant 
docker PS
Afficher l'ensemble des  images 
docker images -a

## Nettoyer système 
*après bcp tests par exemple (ensemble conteneur, réseau, images, cache suppr)*
docker system prune

## Créer sa propre image


## Créer Docker file
Dossier ds lequel la recette décrivant l'image dont on a besoin sera écrite avec les diverses dépendances 
Une instruction = un layer = une étape construction de l'image

### Dockerfile
Créer fichier "Dockerfile" 
FROM debian:9						//Modèle, Image de base
RUN apt-get update -yq \
&& apt-get install curl gnupg -yq \
&& curl -sL https://deb.nodesource.com/setup_10.x | bash \
&& apt-get install nodejs -yq \
&& apt-get clean -y
ADD . /app/							//télécharger des fichiers ici télécharge source de notre app locale ds /app/
WORKDIR /app						//cd
RUN npm install					//ici installer Node.js
EXPOSE 2368  						//indique port
VOLUME /app/logs    		//indique fichier à partager
CMD npm run start				//commande executer démarrage

### Git
Créer fichier .dockerignore à côté Dockerfile avec
node_modules
.git

### Construire
docker build -t ocr-docker-build .           //. car Dockerfile à la racine
docker run -d -p 2368:2368 ocr-docker-build  //accessible http://127.0.0.1:2368

## Créer image DockerHub
Aller sur  https://hub.docker.com/ et se co
Create Repository saisir nom+description

docker tag nom:latest ocr/nom:latest                // créer un lien
ou ➜ docker tag id_du_conteneur lieu/nom:latest    //l'id se  trouver avec docker build
docker push YOUR_USERNAME/nom:latest                //envoyer

## Docker compose
--> gestion infrastructure, déployer ensemble composant dans conteneurs 
Installation sur Linux sinon inclus 
