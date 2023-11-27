import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

import '../../styles/colors.dart';
import '../../styles/font.dart';
import '../../styles/spacings.dart';
import '../../widgets/buttons/main_button.dart';
import '../../widgets/form/select_option.dart';
import '../../widgets/form/text_input.dart';
import '../../widgets/services/firestore.dart';

class AnimalsPageScreenCreate extends StatefulWidget {
  const AnimalsPageScreenCreate({super.key});

  @override
  State<AnimalsPageScreenCreate> createState() =>
      _AnimalsPageScreenCreateState();
}

class _AnimalsPageScreenCreateState extends State<AnimalsPageScreenCreate> {
  String _gender = 'mâle';

  final FirestoreService firestoreService = FirestoreService();

  final TextEditingController _imageUrlController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();

  String? docID;

  /*Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _imageUrlController.text = image.path;
      });
    }
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Créer un animal'),
      ),
      body: SingleChildScrollView(
        // Data from the animal
        child: Padding(
          padding: const EdgeInsets.all(kPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Circle to add an image of the animal
              Padding(
                padding: const EdgeInsets.symmetric(vertical: kPadding),
                child: Column(
                  children: [
                    GestureDetector(
                      // onTap: _pickImage,
                      child: CircleAvatar(
                        radius: 65.0,
                        backgroundColor: kSecondaryColor,
                        backgroundImage: _imageUrlController.text.isEmpty
                            ? const NetworkImage(
                                'https://www.woolha.com/media/2020/03/eevee.png')
                            : FileImage(File(_imageUrlController.text))
                                as ImageProvider,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(kPaddingS),
                      child: Text(
                        'Ajouter un animal',
                        textAlign: TextAlign.center,
                        style: kLabelStyle,
                      ),
                    ),
                  ],
                ),
              ),

              // Input for the name
              TextInput(
                prefixIcon: Icons.person,
                hintText: 'Tommy',
                labelText: 'Nom de votre animal',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Veuillez entrer un nom';
                  }
                  return null;
                },
                controller: _nameController,
              ),

              // Input for the date of birth
              Padding(
                padding: const EdgeInsets.symmetric(vertical: kPadding),
                child: TextInput(
                  prefixIcon: Icons.calendar_today,
                  hintText: 'jj/mm/aaaa',
                  labelText: 'Date de naissance',
                  keyboardType: TextInputType.datetime,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Veuillez entrer une date de naissance';
                    }
                    return null;
                  },
                  controller: _dobController,
                ),
              ),

              // Input for the weight
              TextInput(
                prefixIcon: Icons.line_weight,
                hintText: '3.5',
                labelText: 'Poids (en kg)',
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Veuillez entrer un poids';
                  }
                  return null;
                },
              ),

              // Select the gender
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: kVerticalPaddingL),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Genre',
                      style: kLabelStyle,
                    ),
                    const SizedBox(height: 8.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SelectOption(
                          label: 'Mâle',
                          value: 'mâle',
                          optionValue: _gender,
                          onTap: () {
                            setState(() {
                              _gender = 'mâle';
                            });
                          },
                        ),
                        SelectOption(
                          label: 'Femelle',
                          value: 'femelle',
                          optionValue: _gender,
                          onTap: () {
                            setState(() {
                              _gender = 'femelle';
                            });
                          },
                        ),
                        SelectOption(
                          label: 'Inconnu',
                          value: 'inconnu',
                          optionValue: _gender,
                          onTap: () {
                            setState(() {
                              _gender = 'inconnu';
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Select the race

              // Select the vaccination - padding

              // Button to save
              Padding(
                padding: const EdgeInsets.symmetric(vertical: kPaddingS),
                child: MainButton(
                  onTap: () {
                    // call the create animal method
                    if (docID == null) {
                      firestoreService.createAnimal(
                        _imageUrlController.text,
                        _nameController.text,
                        Timestamp.now(),
                      );
                    } else {
                      firestoreService.updateAnimal(
                        docID!,
                        _imageUrlController.text,
                        _nameController.text,
                        Timestamp.now(),
                      );
                    }
                    // clear the text fields
                    _imageUrlController.clear();
                    _nameController.clear();

                    // go to previous page
                    Navigator.pop(context);
                  },
                  label: 'Créer l‘animal',
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
