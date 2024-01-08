import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../styles/font.dart';
import '../styles/spacings.dart';
import '../widgets/buttons/main_button.dart';
import '../widgets/form/text_input.dart';
import '../widgets/form/password_input.dart';
import '../widgets/form/validation.dart';

import 'login_screen.dart';
import 'main_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  static const String routeName = '/register';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _registerFormKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String _password = '';

  Future<void> _registerUser(BuildContext context) async {
    if (_registerFormKey.currentState!.validate()) {
      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );
        // Update the displayName of the Firebase User
        await userCredential.user!.updateDisplayName(_nameController.text);

        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .set({
          'name': _nameController.text,
          'email': _emailController.text,
          'password': _passwordController.text,
        });

        if (context.mounted) {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const MainScreenPage()),
          );
        }
      } on FirebaseAuthException catch (e) {
        String message = e.code == 'weak-password'
            ? 'Le mot de passe est trop faible.'
            : 'Ce compte existe déjà avec cet email.';
        if (context.mounted) {
          _showSnackBar(context, message);
        }
      }
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
                      padding: const EdgeInsets.symmetric(
                        horizontal: kHorizontalPadding,
                      ),
                      child: TextInput(
                        prefixIcon: Icons.person,
                        hintText: 'Johnny',
                        labelText: 'Votre prénom',
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          return validateName(value!, 'prénom');
                        },
                        controller: _nameController,
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
                        controller: _emailController,
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
                        controller: _passwordController,
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
                                onTap: () => _registerUser(context),
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
                                padding:
                                    EdgeInsets.only(top: kVerticalPaddingS),
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
