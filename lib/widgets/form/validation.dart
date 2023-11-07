/* Validation des inputs */

/* Nom, Prénom */
String? validateName(String value, String fieldName) {
    if (value.isEmpty) {
      return 'Veuillez saisir votre $fieldName.';
    }
    if (value.length < 2) {
      return 'Le $fieldName doit contenir au moins 2 caractères.';
    }
    return null;
}

/* Adresse mail */
String? validateEmail(String value) {
    if (value.isEmpty) {
      return 'Veuillez saisir une adresse e-mail.';
    }
    final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Veuillez saisir une adresse e-mail valide.';
    }
    return null;
}

/* Mot de passe */
String? validatePassword(String value) {
    if (value.isEmpty) {
      return 'Veuillez saisir un mot de passe.';
    }
    if (value.length < 5) {
      return 'Le mot de passe doit contenir au moins 5 caractères.';
    }
    return null;
}