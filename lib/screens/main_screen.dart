import 'package:flutter/material.dart';

import '../styles/colors.dart';
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

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
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
                builder: (context) => const AnimalsPageScreenCreate(docID: '',),
              ),
            );
          } else if (_currentIndex == 2) {
            // new vet
          } else if (_currentIndex == 3) {
            // new reminder
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