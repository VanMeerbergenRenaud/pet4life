import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pet4life/screens/main/home_screen.dart';

import '../../styles/font.dart';
import '../../styles/spacings.dart';
import '../../widgets/buttons/main_button.dart';
import '../../widgets/form/password_input.dart';
import '../../widgets/form/text_input.dart';
import '../../widgets/form/validation.dart';
import '../main/settings_screen.dart';

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
                    'Photo ou memoji',
                    style: kLabelStyle,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: kPaddingS),
                    child: Text(
                      'Sélectionner un avatar parmi la liste',
                      style: kSmallTextGray,
                    ),
                  ),

                  const SizedBox(height: kVerticalPaddingL),

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

                        // Update the user's profile
                        await _auth.currentUser!
                            .updateProfile(displayName: _nameController.text);

                        // Update the user's email
                        await _auth.currentUser!
                            .updateEmail(_emailController.text);

                        // If you store additional user data in Firestore, update that data
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
