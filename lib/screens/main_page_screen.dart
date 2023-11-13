import 'package:flutter/material.dart';
import '../styles/colors.dart';

import 'principals/animals_screen.dart';
import 'principals/home_screen.dart';
import 'principals/reminders_screen.dart';
import 'principals/settings_screen.dart';
import 'principals/vets_screen.dart';

class MainScreenPage extends StatefulWidget {
  const MainScreenPage({super.key});

  @override
  _MainScreenPageState createState() => _MainScreenPageState();
}

class _MainScreenPageState extends State<MainScreenPage> {
  int _currentIndex = 0;

  final List _pages = [
     const HomePageScreen(),
     const AnimalsPageScreen(),
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
