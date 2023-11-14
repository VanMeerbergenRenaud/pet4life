import 'package:flutter/material.dart';

import '../../styles/spacings.dart';
import '../../widgets/form/password_input.dart';
import '../../widgets/form/text_input.dart';
import '../../widgets/form/validation.dart';
import '../main/settings_screen.dart';

class ProfilScreen extends StatefulWidget {
  const ProfilScreen({super.key});

  @override
  State<ProfilScreen> createState() => _ProfilScreenState();
}

class _ProfilScreenState extends State<ProfilScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Page'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                const CircleAvatar(
                  radius: 50,
                  backgroundImage:
                  NetworkImage('https://via.placeholder.com/150'),
                ),
                const SizedBox(height: kVerticalPaddingL),

                // --------- FORM ---------
                // Name input
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: kHorizontalPadding),
                  child: TextInput(
                    prefixIcon: Icons.person,
                    hintText: 'Dominique',
                    labelText: 'Prénom',
                    keyboardType: TextInputType.name,
                    validator: (value) {
                      return validateName(value!, 'Prénom');
                    },
                    initialValue: 'Renaud',
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
                    initialValue: 'john.doe@example.com',
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
                    },
                    validator: (value) {
                      return validatePassword(value!);
                    },
                    initialValue: 'password123',
                    // controller: _password,
                  ),
                ),
                // --------- END FORM ---------

                const SizedBox(height: kVerticalPaddingL),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SettingsPageScreen(),
                        ),
                      );
                    }
                  },
                  child: const Text('Save Changes'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
