import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../styles/font.dart';
import '../styles/spacings.dart';
import '../widgets/buttons/main_button.dart';
import '../widgets/form/text_input.dart';
import '../widgets/form/password_input.dart';
import '../widgets/form/validation.dart';

import 'home_screen.dart';
import 'login_screen.dart';

class RegisterScreen extends StatelessWidget {
  static const String routeName = '/register';
  final _registerFormKey = GlobalKey<FormState>();

  final String _name = "";
  final String _email = "";
  String _password = "";

  RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 85),
                child: Text(
                  'Inscription',
                  style: kTitleStyle,
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(kPadding),
                child: Text(
                  'Veuillez créer un compte afin d’ajouter vos animaux domestiques.',
                  textAlign: TextAlign.center,
                  style: kText,
                ),
              ),
              Form(
                key: _registerFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name input
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                      child: TextInput(
                        prefixIcon: Icons.person,
                        hintText: 'Dominique',
                        labelText: 'Prénom',
                        keyboardType: TextInputType.name,
                        initialValue: 'Renaud',
                        validator: (value) {
                          return validateName(value!, 'Prénom');
                        },
                        // controller: _name,
                      ),
                    ),
                    // Email input
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: kHorizontalPadding,
                        vertical: kVerticalPadding,
                      ),
                      child: TextInput(
                        prefixIcon: Icons.email,
                        hintText: 'example@gmail.com',
                        labelText: 'Adresse mail',
                        validator: (value) {
                          return validateEmail(value!);
                        },
                        keyboardType: TextInputType.emailAddress,
                        // controller: _email,
                      ),
                    ),
                    // Password input
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: kHorizontalPadding),
                      child: PasswordInput(
                        prefixIcon: Icons.lock,
                        hintText: '*******',
                        labelText: 'Password',
                        onChanged: (value) {
                          _password = value;
                        },
                        validator: (value) {
                          return validatePassword(value!);
                        },
                        // controller: _password,
                      ),
                    ),
                    // Password forgotten link
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: kHorizontalPadding,
                        vertical: kVerticalPadding,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: kVerticalPaddingL),
                              child: MainButton(
                                  onTap: () async {
                                    if (_registerFormKey.currentState != null &&
                                        _registerFormKey.currentState!.validate()) {
                                      try {
                                        // Connection vers Firebase et appel de la méthode createUserWithEmailAndPassword
                                        // Cette partie prend plusieurs secondes à s'exécuter donc on utilise le mot clé 'await' qui va de pair avec async()
                                        await FirebaseAuth.instance
                                            .createUserWithEmailAndPassword(
                                            email: _email, password: _password)
                                            .then((value) => {
                                          // Création de la navigation vers la route Home
                                          Navigator.pushNamed(
                                              context, HomePageScreen.routeName)
                                        });
                                        var collection = FirebaseFirestore.instance.collection('users');
                                        var querySnapshot = await collection.add({
                                          'name': _name,
                                          'email': _email,
                                        });
                                      } on FirebaseAuthException catch (e) {
                                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                          showCloseIcon: true,
                                          duration: const Duration(seconds: 10),
                                          content: Text(e.message ?? 'Erreur inconnue'),
                                        ));
                                      }
                                    }
                                  },
                                  label: 'Créer son compte'),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Inscription with Google, Facebook, Apple
                    const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Ou inscription avec',
                          textAlign: TextAlign.center,
                          style: kText,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Logo Google
                            // Logo Apple
                            // Logo Facebook
                          ],
                        ),
                      ],
                    ),
                  // Already have an account? Login
                  Padding(
                    padding: const EdgeInsets.all(kPadding),
                    child: Align(
                      alignment: Alignment.center,
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ),
                          );
                        },
                        // Already have an account? Login
                        child: const Column(
                          children: [
                            Text(
                              'Vous possédez déjà un compte ?',
                              style: kText,
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: kVerticalPaddingS),
                              child: Text(
                                'Connectez-vous',
                                style: kButtonUnderline,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}