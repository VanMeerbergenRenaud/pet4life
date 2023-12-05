/* Validation des inputs */
import 'package:intl/intl.dart';

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
    return 'Entrer un mot de passe svp.';
  } else if (value.length < 6) {
    return 'Password must be at least 6 characters';
  }
  return null;
}

/* Validation for a pet */
// birth date of a pet
String? validateBirthDate(String value) {
  if (value.isEmpty) {
    return 'Inscrivez la date de naissance de l‘animal.';
  }
  try {
    DateFormat('dd/MM/yyyy').parseStrict(value);
  } catch (e) {
    return 'Le format doit être ainsi jj/mm/aaaa.';
  }
  return null;
}

// weight of a pet
String? validateWeight(String value) {
  if (value.isEmpty) {
    return 'Inscrivez le poids de l‘animal.';
  }
  try {
    double.parse(value);
  } catch (e) {
    return 'Le poids doit être un nombre.';
  }
  return null;
}