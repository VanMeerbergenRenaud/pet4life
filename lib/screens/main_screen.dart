import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../styles/colors.dart';
import '../widgets/services/firestore.dart';
import 'animals/create_screen.dart';
import 'main/animals_screen.dart';
import 'main/home_screen.dart';
import 'main/reminders_screen.dart';
import 'main/settings_screen.dart';
import 'main/vets_screen.dart';

class MainScreenPage extends StatefulWidget {
  const MainScreenPage({super.key});

  @override
  State<MainScreenPage> createState() => _MainScreenPageState();
}

class _MainScreenPageState extends State<MainScreenPage> {
  int _currentIndex = 0;

  final List _pages = [
     const HomePageScreen(),
     AnimalsPageScreen(),
     const VetsPageScreen(),
     const RemindersPageScreen(),
     const SettingsPageScreen(),
  ];

  final FirestoreService firestoreService = FirestoreService();

  final TextEditingController _imageUrlController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  // final TextEditingController _dobController = TextEditingController();
  // final TextEditingController _weightController = TextEditingController();
  // final TextEditingController _genderController = TextEditingController();
  // final TextEditingController _raceController = TextEditingController();
  // final TextEditingController _vaccinationController = TextEditingController();

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void openAnimalModal(String? docID) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Ajouter un animal'),

            TextField(
              controller: _imageUrlController,
              decoration: const InputDecoration(
                labelText: 'Choisissez une image',
              ),
            ),

            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Nom de votre animal',
              ),
            ),
          ],
        ),
        // action to save
        actions: [
          TextButton(
            onPressed: () {
              if(docID == null) {
                // call the create animal method
                firestoreService.createAnimal(
                  _imageUrlController.text,
                  _nameController.text,
                  DateTime.now() as Timestamp,
                );
              } else {
                firestoreService.updateAnimal(
                  docID,
                  _imageUrlController.text,
                  _nameController.text,
                  DateTime.now() as Timestamp,
                );
              }
              // clear the text fields
              _imageUrlController.clear();
              _nameController.clear();

              // close the modal
              Navigator.pop(context);
            },
            child: const Text('Ajouter'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_currentIndex == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AnimalsPageScreenCreate(),
              ),
            );
          } else if (_currentIndex == 2) {
            // open a modal to create a new vet

          } else if (_currentIndex == 3) {
            // open a modal to create a new reminder

          } else {
            // redirect to home page
            setState(() {
              _currentIndex = 0;
            });
          }
        },
        backgroundColor: kMainColor,
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        // type: BottomNavigationBarType.fixed,
        selectedItemColor: kMainColor,
        unselectedItemColor: kGrey,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        onTap: _onItemTapped,
        currentIndex: _currentIndex,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Accueil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pets),
            label: 'Animaux',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_hospital_outlined),
            label: 'Vétérinaire',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Rappels',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}