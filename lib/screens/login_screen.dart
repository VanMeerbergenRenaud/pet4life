import 'package:flutter/material.dart';

import '../styles/font.dart';
import '../styles/spacings.dart';
import '../widgets/buttons/main_button.dart';
import '../widgets/form/text_input.dart';
import '../widgets/form/password_input.dart';
import '../widgets/form/validation.dart';
import 'register_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  static const String routeName = '/login';

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
                padding: EdgeInsets.only(top: 50),
                child: Text(
                  'Connexion',
                  style: kTitleStyle,
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(kPadding),
                child: Text(
                  'Créer un compte ou connectez vous afin d‘ajouter vos animaux domestiques.',
                  textAlign: TextAlign.center,
                  style: kText,
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                      child: PasswordInput(
                        prefixIcon: Icons.password,
                        hintText: '*******',
                        labelText: 'Password',
                        validator: (value) {
                          return validatePassword(value!);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(kPaddingS),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {},
                          child: const Text(
                            'Mot de passe oublié ?',
                            style: kButtonUnderline,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: kHorizontalPadding,
                        vertical: kVerticalPadding,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: MainButton(
                              label: 'Je me connecte',
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
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(kPadding),
                child: Text(
                  'Ou connectez-vous avec',
                  textAlign: TextAlign.center,
                  style: kText,
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: kHorizontalPadding,
                  vertical: kVerticalPadding,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Logo Google
                    // Logo Apple
                    // Logo Facebook
                  ],
                ),
              ),

              // Not subscribe yet
              Padding(
                padding: const EdgeInsets.symmetric(vertical: kVerticalPaddingXL),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Pas encore de compte ?',
                      style: kText,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => RegisterScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        'Inscrivez-vous',
                        style: kButtonUnderline,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
