import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dto/pet.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';

import '../../styles/colors.dart';
import '../../styles/font.dart';
import '../../styles/spacings.dart';
import '../../widgets/buttons/main_button.dart';
import '../../widgets/form/select_option.dart';
import '../../widgets/form/text_input.dart';
import '../../widgets/form/validation.dart';
import '../../widgets/image_picker.dart';
import '../../widgets/services/firestore.dart';

class AnimalsPageScreenCreate extends StatefulWidget {
  const AnimalsPageScreenCreate({
    super.key,
    required this.docID,
  });

  final String docID;

  @override
  State<AnimalsPageScreenCreate> createState() =>
      _AnimalsPageScreenCreateState();
}

class _AnimalsPageScreenCreateState extends State<AnimalsPageScreenCreate> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();

  DateTime date = DateTime(2023, 01, 01);

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

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Uint8List? _image;

  Future<void> selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }

  @override
  Widget build(BuildContext context) {
    final FirestoreService firestoreService =
        FirestoreService(_auth.currentUser!.uid);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Créer un animal'),
      ),
      body: SingleChildScrollView(
        // Data of the animal
        child: Padding(
          padding: const EdgeInsets.all(kPadding),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Circle to add an image of the animal
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: kPadding),
                  child: Column(
                    children: [
                      // Image upload
                      Stack(
                        children: [
                          _image != null
                              ? GestureDetector(
                                  onTap: () {
                                    selectImage();
                                  },
                                  child: CircleAvatar(
                                    radius: 55.0,
                                    backgroundColor: kSecondaryColor,
                                    backgroundImage: MemoryImage(_image!),
                                  ),
                                )
                              : GestureDetector(
                                  onTap: () {
                                    selectImage();
                                  },
                                  child: const CircleAvatar(
                                    radius: 55.0,
                                    backgroundColor: kSecondaryColor,
                                    backgroundImage: AssetImage(
                                      'assets/img/default.png',
                                    ),
                                  ),
                                ),

                          // si l'image est null, on affiche un bouton pour ajouter une image
                          _image == null
                              ? Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: GestureDetector(
                                    onTap: () {
                                      selectImage();
                                    },
                                    child: const CircleAvatar(
                                      radius: 18.0,
                                      child: Icon(
                                        Icons.add_a_photo,
                                        color: kTertiaryColor,
                                        size: 18,
                                      ),
                                    ),
                                  ),
                                )
                              : const SizedBox(),
                        ],
                      ),
                      // Text to say add an image
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
                    return validateName(value!, 'nom de votre animal');
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
                              _dobController.text =
                                  DateFormat('dd/MM/yyyy').format(date);
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
                      return validateBirthDate(value!);
                    },
                    controller: _dobController,
                  ),
                ),

                // Input for the weight
                TextInput(
                  prefixIcon: Icons.line_weight,
                  hintText: '0.0',
                  labelText: 'Poids (en kg)',
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  validator: (value) {
                    return validateWeight(value!);
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
                    onTap: () async {
                      // call the create animal method
                      if (docID == null && _formKey.currentState!.validate()) {
                        firestoreService.createAnimal(
                          Pet(
                            imageUrl: await firestoreService
                                .uploadImageToFirebase(_image!),
                            name: _nameController.text,
                            dob: DateFormat('dd/MM/yyyy')
                                .parse(_dobController.text),
                            weight: double.parse(_weightController.text),
                            gender: _gender,
                            race: _race,
                            vaccination: _vaccinated,
                            createdAt: DateTime.now(),
                          ),
                        );
                      } else {
                        firestoreService.updateAnimal(
                          docID!,
                          _image as String,
                          _nameController.text,
                          _dobController.text as DateTime,
                          _weightController.text as double,
                          _gender,
                          _race,
                          _vaccinated,
                          Timestamp.now(),
                        );
                      }
                      // go to previous page
                      Navigator.pop(context);
                    },
                    label: 'Créer l‘animal',
                  ),
                ),
                const SizedBox(height: kVerticalPaddingL),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
