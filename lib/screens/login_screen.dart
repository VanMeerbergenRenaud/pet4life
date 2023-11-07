import 'package:flutter/material.dart';

import '../styles/spacings.dart';
import '../widgets/form/text_input.dart';
import '../widgets/form/password_input.dart';
import '../widgets/form/validation.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  static const String routeName = '/login';

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: kHorizontalPadding),
                    child: TextInput(
                      prefixIcon: Icons.email,
                      hintText: 'example@gmail.com',
                      labelText: 'Email',
                      validator: (value) {
                        return validateEmail(value!);
                      },
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
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
                  /*Padding(
                    padding: const EdgeInsets.all(16),
                    child: MainButton(
                      label: 'Je me connecte',
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content:
                              Text('Traitement des données en cours...'),
                            ),
                          );
                        }
                      },
                    ),
                  ),*/
                ],
              ),
            )
          ],
        ),
    );
  }
}