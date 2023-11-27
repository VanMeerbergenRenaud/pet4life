import 'package:flutter/material.dart';

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

  /*final ImagePicker _picker = ImagePicker();
  late File selectedImage;
  getImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);
  }

  if(image!= null) {
    selectedImage = File(image.path);
    setState(() {

    });*/

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
                      'Uploader une photo de type jpeg, jpg, png.',
                      style: kSmallTextGray,
                    ),
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          //
                        },
                        child: Container(
                          //
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: kVerticalPaddingL),

                  // --------- FORM ---------
                  // Name input
                  TextInput(
                    prefixIcon: Icons.person,
                    hintText: 'Dominique',
                    labelText: 'Nom d’utilisateur',
                    keyboardType: TextInputType.name,
                    validator: (value) {
                      return validateName(value!, 'Nom d’utilisateur');
                    },
                    initialValue: 'Renaud',
                  ),
                  // Email input
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: kVerticalPadding + 4),
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
                  PasswordInput(
                    prefixIcon: Icons.lock,
                    hintText: '*******',
                    labelText: 'Password',
                    onChanged: (value) {},
                    validator: (value) {
                      return validatePassword(value!);
                    },
                    initialValue: 'password123',
                    // controller: _password,
                  ),
                  // --------- END FORM ---------

                  const SizedBox(height: 48),
                  MainButton(
                    onTap: () {
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