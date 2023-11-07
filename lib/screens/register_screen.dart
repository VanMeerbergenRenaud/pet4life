import 'package:flutter/material.dart';

import '../styles/font.dart';
import '../styles/spacings.dart';
import '../widgets/buttons/main_button.dart';
import '../widgets/form/text_input.dart';
import '../widgets/form/password_input.dart';
import '../widgets/form/validation.dart';
import 'login_screen.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  static const String routeName = '/register';

  final _formKey = GlobalKey<FormState>();

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
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name input
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                      child: TextInput(
                        prefixIcon: Icons.person,
                        hintText: 'Renaud Vmb',
                        labelText: 'Nom d‘utilisateur',
                        validator: (value) {
                          return validateName(value!, 'prénom');
                        },
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
                      ),
                    ),
                    // Password input
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: kHorizontalPadding),
                      child: PasswordInput(
                        prefixIcon: Icons.password,
                        hintText: '*******',
                        labelText: 'Password',
                        validator: (value) {
                          return validatePassword(value!);
                        },
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
                              padding: const EdgeInsets.symmetric(
                                  vertical: kVerticalPaddingL),
                              child: MainButton(
                                label: 'S‘inscrire',
                                onTap: () {
                                  if (_formKey.currentState!.validate()) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                            'Traitement des données en cours...'),
                                      ),
                                    );
                                  }
                                },
                              ),
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
