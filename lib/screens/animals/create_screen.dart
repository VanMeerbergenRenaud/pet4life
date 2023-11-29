import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
  final FirestoreService firestoreService = FirestoreService();

  final TextEditingController _imageUrlController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();

  DateTime date = DateTime(2016, 10, 26);

  void _showDialog(Widget child) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 250,
        padding: const EdgeInsets.only(top: 8.0),
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        color: kTertiaryColor,
        child: SafeArea(
          top: false,
          child: child,
        ),
      ),
    );
  }

  String? docID;
  String _gender = 'mâle';
  String _race = 'golden';
  String _vaccinated = 'vacciné';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Créer un animal'),
      ),
      body: SingleChildScrollView(
        // Data of the animal
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
                        radius: 55.0,
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
                        'Ajouter une photo',
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
                  onTap: () => {
                    _showDialog(
                      CupertinoDatePicker(
                        initialDateTime: date,
                        mode: CupertinoDatePickerMode.date,
                        use24hFormat: true,
                        onDateTimeChanged: (DateTime newTime) {
                          setState(() {
                            date = newTime;
                            _dobController.text = DateFormat('dd/MM/yyyy').format(date);
                          });
                        },
                      ),
                    ),
                  },
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
                hintText: '0.0',
                labelText: 'Poids (en kg)',
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Veuillez entrer un poids';
                  }
                  return null;
                },
                controller: _weightController,
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Race',
                    style: kLabelStyle,
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SelectOption(
                        label: 'Golden',
                        value: 'golden',
                        optionValue: _race,
                        onTap: () {
                          setState(() {
                            _race = 'golden';
                          });
                        },
                      ),
                      SelectOption(
                        label: 'Mixte',
                        value: 'mixte',
                        optionValue: _race,
                        onTap: () {
                          setState(() {
                            _race = 'mixte';
                          });
                        },
                      ),
                      SelectOption(
                        label: 'Inconnu',
                        value: 'inconnu',
                        optionValue: _race,
                        onTap: () {
                          setState(() {
                            _race = 'inconnu';
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),

              // Select the vaccination
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: kVerticalPaddingL),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Vaccination',
                      style: kLabelStyle,
                    ),
                    const SizedBox(height: 8.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SelectOption(
                          label: 'Vacciné',
                          value: 'vacciné',
                          optionValue: _vaccinated,
                          onTap: () {
                            setState(() {
                              _vaccinated = 'vacciné';
                            });
                          },
                        ),
                        SelectOption(
                          label: 'Non',
                          value: 'non vacciné',
                          optionValue: _vaccinated,
                          onTap: () {
                            setState(() {
                              _vaccinated = 'non vacciné';
                            });
                          },
                        ),
                        SelectOption(
                          label: 'Inconnu',
                          value: 'inconnu',
                          optionValue: _vaccinated,
                          onTap: () {
                            setState(() {
                              _vaccinated = 'inconnu';
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),

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
                        _dobController.text,
                        _weightController.text,
                        _gender,
                        _race,
                        _vaccinated,
                        Timestamp.now(),
                      );
                    } else {
                      firestoreService.updateAnimal(
                        docID!,
                        _imageUrlController.text,
                        _nameController.text,
                        _dobController.text,
                        _weightController.text,
                        _gender,
                        _race,
                        _vaccinated,
                        Timestamp.now(),
                      );
                    }
                    // clear the text fields
                    _imageUrlController.clear();
                    _nameController.clear();
                    _dobController.clear();
                    _weightController.clear();

                    // go to previous page
                    Navigator.pop(context);
                  },
                  label: 'Créer l‘animal',
                ),
              ),
              const SizedBox(
                height: kVerticalPaddingL,
              )
            ],
          ),
        ),
      ),
    );
  }
}
