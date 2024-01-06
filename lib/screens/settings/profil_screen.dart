import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../styles/font.dart';
import '../../styles/spacings.dart';
import '../../widgets/buttons/main_button.dart';
import '../../widgets/form/text_input.dart';
import '../../widgets/form/validation.dart';

class ProfilScreen extends StatelessWidget {
  ProfilScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;

  // Add TextEditingController for each field
  final _nameController = TextEditingController(
      text: FirebaseAuth.instance.currentUser!.displayName);
  final _emailController =
      TextEditingController(text: FirebaseAuth.instance.currentUser!.email);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page de profil'),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(kPadding),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 24),
                  const Text(
                    'Vous pouvez modifier votre profil ici !',
                    style: kLabelStyle,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: kPaddingS),
                    child: Text(
                      'Seul le mot de passe n‘est pas modifiable pour des raisons de sécurité.',
                      style: kSmallTextGray,
                    ),
                  ),

                  const SizedBox(height: kVerticalPadding),

                  // Name input
                  TextInput(
                    controller: _nameController,
                    prefixIcon: Icons.person,
                    hintText: 'Dominique',
                    labelText: 'Nom d’utilisateur',
                    keyboardType: TextInputType.name,
                    validator: (value) {
                      return validateName(value!, 'Nom d’utilisateur');
                    },
                  ),

                  // Email input
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: kVerticalPadding + 4,
                    ),
                    child: TextInput(
                      controller: _emailController,
                      prefixIcon: Icons.email,
                      hintText: 'example@gmail.com',
                      labelText: 'Adresse mail',
                      validator: (value) {
                        return validateEmail(value!);
                      },
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),

                  const SizedBox(height: kVerticalPadding),

                  MainButton(
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();

                        await _auth.currentUser!
                            .updateDisplayName(_nameController.text);

                        // Send a verification email before updating the user's email
                        await _auth.currentUser!.sendEmailVerification();
                        await _auth.currentUser!
                            .updateEmail(_emailController.text);

                        await FirebaseFirestore.instance
                            .collection('users')
                            .doc(_auth.currentUser!.uid)
                            .update({
                          'name': _nameController.text,
                          'email': _emailController.text,
                        });

                        Navigator.pop(context);
                      }
                    },
                    label: 'Sauvegarder',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
