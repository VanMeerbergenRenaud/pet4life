import "package:flutter/material.dart";
import 'package:firebase_auth/firebase_auth.dart';

import '../styles/font.dart';
import '../styles/spacings.dart';
import '../widgets/buttons/main_button.dart';
import '../widgets/form/text_input.dart';
import '../widgets/form/password_input.dart';
import '../widgets/form/validation.dart';

import 'main_screen.dart';
import 'register_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  static const String routeName = '/login';

  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> _signInWithEmailAndPassword(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      _showSnackBar(context, 'Connexion réussie !');
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const MainScreenPage(),
        ),
      );
    } on FirebaseAuthException catch (e) {
      String message = e.code == 'user-not-found'
          ? 'Aucun utilisateur trouvé pour cet email.'
          : 'Mot de passe incorrect.';
      _showSnackBar(context, message);
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

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
                        hintText: 'exemple@gmail.com',
                        labelText: 'Adresse mail',
                        validator: (value) {
                          return validateEmail(value!);
                        },
                        keyboardType: TextInputType.emailAddress,
                        controller: _emailController,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: kHorizontalPadding),
                      child: PasswordInput(
                        prefixIcon: Icons.lock,
                        hintText: '*******',
                        labelText: 'Password',
                        validator: (value) {
                          return validatePassword(value!);
                        },
                        controller: _passwordController,
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
                                  _signInWithEmailAndPassword(context);
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
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: kHorizontalPadding,
                  vertical: kVerticalPadding,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Google button with image
                    TextButton(
                      onPressed: () {
                        // AuthServices().signInWithGoogle();
                      },
                      child: Image.asset(
                        'assets/img/google.png',
                        width: 32,
                      ),
                    ),
                    // Apple button with image
                    TextButton(
                      onPressed: () {
                        // AuthServices().signInWithApple();
                      },
                      child: Image.asset(
                        'assets/img/apple.png',
                        width: 32,
                      ),
                    ),
                    // Facebook button with image
                    TextButton(
                      onPressed: () {
                        // AuthServices().signInWithFacebook();
                      },
                      child: Image.asset(
                        'assets/img/facebook.png',
                        width: 32,
                      ),
                    ),
                  ],
                ),
              ),
              // Not subscribe yet
              Padding(
                padding: const EdgeInsets.symmetric(vertical: kVerticalPadding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Pas encore de compte ?',
                      style: kText,
                    ),
                    TextButton(
                      child: const Text(
                        'Inscrivez-vous',
                        style: kButtonUnderline,
                      ),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const RegisterScreen(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              // Add a link to the home page as a guest
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Ou continuez en tant qu‘invité',
                      style: kText,
                    ),
                    TextButton(
                      child: const Text(
                        'Continuer',
                        style: kButtonUnderline,
                      ),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const MainScreenPage(),
                          ),
                        );
                      },
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
