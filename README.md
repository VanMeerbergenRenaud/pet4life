# **Pet4Life 🐾** - L'application pour prendre soin de vos animaux de compagnie

Le projet **Pet4Life** est une application mobile réalisée pour le cours de Développement d’Application Mobile à l’HEPL.
Cette application vise principalement les particuliers, mais aussi les éleveurs qui souhaitent prendre soin de leurs
animaux de compagnie de manière organisée et efficace.

## 📋 Table des matières

- [Présentation de l'architecture du projet](#-présentation-de-larchitecture-du-projet)
- [Étude de l'existant](#-étude-de-lexistant)
- [Public cible](#-public-cible)
- [Fonctionnalités de base](#-fonctionnalités-de-base)
- [Pages de l'application](#-pages-de-lapplication)
- [Liens utiles pour le projet](#-liens-utiles-pour-le-projet)
- [Contact](#contact)

## 📁 Présentation de l'architecture du projet

Le répertoire `lib` est organisé de manière à séparer clairement les différentes composantes de l'application,
facilitant ainsi la compréhension et la maintenance du code. Chaque page a son rôle spécifique, créant une expérience
utilisateur cohérente et engageante.

- 🚪 **main.dart :** Fichier principal de l'application.
- 📱 **screens :** Dossier contenant toutes les pages de l'application.
    - **login_screen.dart :** Page de login.
    - **register_screen.dart :** Page d'inscription.
    - **home_screen.dart :** Page d'accueil.
    - **animals_screen.dart :** Page pour gérer et voir les animaux.
    - **vets_screen.dart :** Page pour gérer et voir les vétérinaires.
    - **reminders_screen.dart :** Page pour gérer et voir les rappels.
    - **settings_screen.dart :** Page pour gérer les paramètres.
    - etc.

- 🛠️ **services :** Dossier pour les services de l'application.
    - **firebase_options :** Fichier pour les options de connexion à Firebase.
    - **notification_service.dart :** Gestion des notifications.

- 📦 **widgets :** Dossier pour les widgets de l'application.
    - **form** : Dossier pour les formulaires.
    - **services** : Dossier pour les services.
    - etc.

- 🎨 **styles :** Dossier pour les styles souvent utilisé dans l'application.
    - **colors.dart :** Fichier pour les couleurs.
    - **fonts.dart :** Fichier pour les polices.
    - **spacing.dart :** Fichier pour les espacements.
    - etc.

## 🌐 Étude de l'existant

> La plupart des applications existantes sont des applications d’adoptions d’animaux, de services de tracker pour suivre
> son animal avec un traceur ou alors, on peut enregistrer ces animaux, mais rien n’est complet, sans parler du design
> qui
> est loin d’être réfléchi et pensé pour les utilisateurs ciblés.

- [**Great Pet Care**](https://greatpetcare.com/) 🏆
    - **Points Forts :** Great Pet Care est une application web bien établie qui offre une gamme complète de services
      pour
      les propriétaires d'animaux de compagnie. Elle se distingue par la variété des fonctionnalités qu'elle propose,
      notamment la gestion des rendez-vous, le suivi médical, les rappels, et même la possibilité de commander des
      produits pour animaux.
    - **Points Faibles :**
        - La complexité de l'application peut être un obstacle pour les utilisateurs qui préfèrent une solution plus
          simple.
          Les fonctionnalités avancées peuvent être inutiles pour les utilisateurs qui recherchent une approche plus
          légère.
        - Il n'y a pas encore de version mobile de l'application, ce qui peut être un inconvénient pour certains
          utilisateurs.

- [**Vitus Vet**](https://vitusvet.com/) 🏥
    - **Points Forts :** Vitus Vet se concentre principalement sur la gestion des soins de santé de l'animal. Il offre
      des fonctionnalités spécifiques aux vétérinaires, telles que la gestion des dossiers médicaux. Cela en fait un
      choix solide pour les professionnels de la santé animale.
    - **Points Faibles :** Pour les propriétaires d'animaux, il peut manquer certaines fonctionnalités plus
      générales, telles que la gestion d'événements et de réservations en ligne.

- [**Pet Noter**](https://petnoter.com/) 📝
    - **Points Forts :** Pet Noter semble se concentrer sur la simplicité et la prise de notes rapides concernant les
      animaux de compagnie. C'est une option légère pour les utilisateurs qui souhaitent enregistrer des informations de
      base sans être submergés par des fonctionnalités avancées.
    - **Points Faibles :** L'application peut être insuffisante pour les utilisateurs qui recherchent une solution plus
      complète. L'absence de fonctionnalités telles que la gestion des rendez-vous ou la centralisation des informations
      sur plusieurs animaux peut être un inconvénient pour certains propriétaires.

- **Applications de rappels et calendrier** 📆
    - L’application se distingue en proposant une solution complète, allant au-delà des simples rappels ou de la prise
      de rendez-vous.

## 🎯 Public cible

- **Age :** 18 - 70 ans
- **Particuliers** ou **éleveurs** qui adorent faire des activités avec leurs animaux de compagnie.
- Personnes qui aiment avoir une application tout-en-un sans avoir trop de fonctionnalités.
- Les gens qui ont beaucoup trop de sites à utiliser pour s’occuper de leurs animaux (vétérinaires, balades,
  nourriture, …)

## 📋 Fonctionnalités de base

1. **Gestion des vaccinations, rapports médicaux et notes de santé :**
   L'application offre un moyen pratique de ne pas oublier les rendez-vous médicaux et les vaccinations futures à faire.
   Vous pouvez ensuite stocker tous les rapports et
   notes de santé de vos animaux de compagnie pour vérifier s'ils sont en bonne santé.

2. **Informations complètes sur vos animaux :**
   Vous pouvez accéder à toutes les informations que vous aurez enregistrées
   au préalable, y compris les détails de chaque animal, y compris son historique médical, ses besoins alimentaires, ses
   vaccinations, son comportement habituel, etc. Ces informations sont utiles pour tous les propriétaires d'animaux qui
   souhaitent participer à des événements ou des activités avec leurs animaux.

3. **Centralisation des informations :**
   Toutes les informations relatives à vos animaux de compagnie se retrouvent en un
   seul endroit, simplifiant la gestion de plusieurs animaux et facilitant la consultation de leurs données
   essentielles,
   aussi bien pour vous que pour les vétérinaires.

4. **Consultation et réservation en ligne :**
   Vous pouvez prendre rendez-vous en ligne avec des vétérinaires ou d'autres
   services liés aux animaux via l'application. Vous pouvez également réserver des activités ou participer à des
   événements avec vos animaux de compagnie.

## 📱 Pages de l'application

### 1. Accueil 🏠

L’accueil sert de point central pour gérer ses animaux de compagnie et leurs besoins. Vous y trouverez :

- Accès à tous ces animaux, vétérinaires, évènements auxquels on compte participer.
- Accès à la liste de ces rappels.

### 2. Animaux 🐶

- Liste de tous les animaux de l'utilisateur.
- Possibilité d'ajouter un nouvel animal.
- Détails individuels de chaque animal, y compris son nom, type, race, âge, historique médical, et autres informations
  pertinentes.

### 3. Vétérinaires 🏥

- Liste de tous les vétérinaires de l'utilisateur.
- Possibilité d'ajouter un nouveau vétérinaire.
- Détails individuels de chaque vétérinaire, y compris son nom, coordonnées, spécialités, et informations de contact.
- Possibilité de rechercher un vétérinaire spécifique en fonction de son nom, sa spécialité, ou son emplacement.

### 4. Rappels 📅

- Liste de tous les rappels médicaux, événements et autres rappels associés aux animaux de l'utilisateur.
- Possibilité d'ajouter de nouveaux rappels.
- Détails individuels de chaque rappel, y compris le type, la date, la description, et les animaux associés.
- Options pour filtrer les rappels en fonction de leur type, de la date, ou d'autres critères pertinents.

### 5. Paramètres ⚙️

- Paramètres du Compte : Possibilité de modifier le nom d'utilisateur, l'adresse e-mail, le mot de passe, etc.
- Options de confidentialité et de sécurité du compte.
- Gestion des préférences de notification, y compris les rappels médicaux, les événements, etc.
- Se déconnecter ou supprimer le compte.

## 🔗 Liens utiles pour le projet

- [Accéder au rapport technique en _anglais_ (PDF)](./assets/readme/rapport_technique.pdf)
- [Accéder à la maquette de design](https://xd.adobe.com/view/dc136097-39f2-4032-adf4-922b0241ff0a-8940/?fullscreen)

## Contact

Si vous avez des questions, vous pouvez me contacter par mail à l'adresse
suivante : [renaud.vanmeerbergen@gmail.com](mailto:renaud.vanmeerbergen@gmail.com).
