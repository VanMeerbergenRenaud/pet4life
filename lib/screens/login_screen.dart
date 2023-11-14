import "package:flutter/material.dart";
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pet4life/screens/main_page_screen.dart';

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

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> _signInWithEmailAndPassword(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Connexion réussie !'),
        ),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Aucun utilisateur trouvé pour cet email.'),
          ),
        );
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Mot de passe incorrect.'),
          ),
        );
      }
    }
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
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => const MainScreenPage(),
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
                padding: const EdgeInsets.symmetric(vertical: kVerticalPaddingL),
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
                            builder: (context) => RegisterScreen(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              // Add a link to the home page as a guest
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
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
