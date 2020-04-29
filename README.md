# Déploiement d'une application sur un serveur distant

## Conception

Pour déployer l'application j'ai besoin :
- de récupérer le code source qui m'intéresse (ici je dois pouvoir choisir ma branche)
- de *build* le code correspondant, pour le packager sour forme d'une image docker
- le publier sur un registry (*push*)
- depuis le serveur, pouvoir récupérer (*pull*) et le lancer (*run*)

Techniquement, je pourrai build au niveau du serveur final, mais il n'y aurait alors peut être même plus besoin de docker. L'intêret de la techno ici est de pouvoir, pour n'importe quel serveur, *pull* notre image déjà build et la lancer facilement.

## Première méthode

Build et deploy depuis la machine EC2 `build_and_deploy.sh`.
On récupère la branche qui nous intéresse, on build le docker correspondant et on le lance. Simple mais la machine de production n'est pas forcément adapté au build (elle sert peut être déjà le site), et il faut se ssh dessus pour lancer le script, il faut le faire pour chaque machine si l'on a un reverse_proxy. Bref on peut faire un peu mieux.

## Image Registry

On va maintenant séparer la partie *release* de la partie *déploiement*. Lorsque que l'on fait une mise à jour du code source, le développeur (ou mieux une tâche de CI/CD lancée automatiquement) va lancer les tests, build le code et le publier sur le docker registry. Il ne restera alors plus qu'à indiquer au serveur de récupérer et lancer la nouvelle version (ici en ssh mais si l'on utilise kubernetes on peut également le faire automatiquement).

On a donc `build_and_release.sh` pour la CI/CD, et `deploy_from_registry.sh` pour le serveur. Il faut faire attention aux problèmes d'accès au registry, et la gestion des secrets.

## CI/CD avec GitHub actions

~~Quand les scripts précédents fonctionnent bien, il est alors facile de passer à une CI/CD automatisé, en lançant cette fois `build_and_release.sh` depuis le job Github (en lui donnant les secret du Docker Registry).~~
Les GitHub action aiment bien que l'on utilise les actions déjà constituées, réutiliser le script pose quelques problèmes. On écrit donc l'action dans `.github/workflows`.

## Commentaires

Sur la machine EC2, `docker` n'est pas installé par défaut. Normalement, on travaillera avec des systèmes supportant de base les containers, mais ici on rajoute un script dépendant de la plateforme pour installer `docker` sur l'instance **EC2 Ubuntu**.

Bien que le script final soit fonctionnel, on voit assez vite les limitations d'un système manuel et peu réfléchi. Utiliser des technos spécialisés et matures dans l'automatisation est essentiel (Helm, Ansible ?).