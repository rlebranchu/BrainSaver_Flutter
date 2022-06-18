# TMDB_React

<img src="https://miro.medium.com/max/1400/1*jW1ecwjjyd12ji5YESl8RQ.png" width="300px"/>

## Contexte

Ce projet a pour but d'approfondir mes connaissances en Flutter.
J'ai eu l'occasion de décourvrir Flutter durant mes études. L'un des deux projets s'appuyer sur la persistence des données.

L'application reprend quatres idées basiques d'applications : Authentification, Todo List, Calendrier et Notes.
L'avantage d'intégrer ces quatres projets est de traiter plusieurs notions différentes spécifiques à Flutter.

## Pourquoi le framework :
Je suis actuellement en train d'apprendre et d'approfondir de nouvelles technologies web et mobiles.
Le choix de Flutter me permettera de pouvoir le comparer avec React JS.

## Description du projet :
J'ai utilisé le Design Pattern le plus conseillé sur les applications Flutter : Bloc.
La gestion de State, d'évènements via des streams apportent une structure dans le projet que Flutter n'apporte pas nativement.

Pour stocker les données, j'utilise Firebase (+Firestore).
Flutter et Firesbase sont tous deux développés par Google. 
C'est donc tout naturel que tout a été fait poru faciliter la connexion entre ces deux outils. 

## Fonctionnalités intégrées :
  - Authentifciation (+ Incription) via Firebase
  - Todo List : Ajout, Completion, Suppresion, Filtre
  - Calendrier : Ajout, Suppression, Affichage détails du jour
  - Notes : Ajout, Modification, Suppression, Sauvevarge automatique

## Particularités techniques de chaque fonctions :
### Authentification : Firebase
L'utilisation de firebase pour l'authentification permet de gérer globalement la connexion et la paramétrage des droits.
De plus, Firebase permet une réauthentification automatique via la reconnnaissance de l'appareil.
L'utilisateur encore connecté lors de la précédente fermeture de l'applicatione est automatique reconnecté sur l'application. 

### Todo List : 
Pour cette page, j'ai utilisé une particularité spécifique de Flutter : le changement de type de state de la page.
Cela permet d'avoir un state spécifique pour le différentes étapes de la page : dans notre cas, une phase de Laoding et une autre Loaded.
Une analyse du type de state permet donc dans le code de l'UI de définir l'interfae à afficher.
  
### Calendrier : Ouverture d'un Modal avec formulaire
Dans ce modal, un formualire de saisie permet de créer un nouvel événement en renseigant les informations suivante : titre, catégorie, date et heure (coche Journée entière).
Ce formulaire permet de manipuler plusieurs types d'input : TextFormField, DropDown, Checkbox, DateTimePicker, Button.

### Notes : Utilisation du composant TextFormField avec des valeurs par défaut
L'utilisation d'un TextField pour remplir un formulaire est plutot basique.
Sauf quand une valeur par défaut venant du state est attendue.
Cela demande de passer par un controller qui va analyser tous les évènements du state et du composant TextFormField afin de garder une cohérence entre l'UI et le state.
De plus, la perte de focus du titre ou du détails déclenche  automatiquement la sauvegarde des données de la page.
Ainsi, aucun bouton de sauvergade n'est nécessaire.




## Les différentes pages de l'application :
|                                                          Authentification                                                         | Todo List                                                                                                                         | Calendrier                                                                                                                        | Notes                                                                                                                             |
|:---------------------------------------------------------------------------------------------------------------------------------:|-----------------------------------------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------|
| <img src="https://user-images.githubusercontent.com/38243794/174459627-096e4b6f-b34d-4220-b1d7-778fe121e025.gif" height="500px"/> | <img src="https://user-images.githubusercontent.com/38243794/174459616-43c40e3d-7b99-4a3b-bc6e-0c8b204aa6fc.gif" height="500px"/> | <img src="https://user-images.githubusercontent.com/38243794/174459604-a5e2ccc5-1b1f-4867-bd10-b33ff17a757d.gif" height="500px"/> | <img src="https://user-images.githubusercontent.com/38243794/174459571-26f01a0a-879d-45d2-bde9-12630eed6e4e.gif" height="500px"/> |
