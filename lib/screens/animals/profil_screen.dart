import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PetProfileScreen extends StatelessWidget {
  final DocumentSnapshot pet;

  const PetProfileScreen({super.key, required this.pet});

  @override
  Widget build(BuildContext context) {
    // Build your pet profile screen here
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil de l‘animal'),
      ),
      body: Center(
        child: Text('Profil de ${pet['name']}'),
      ),
    );
  }
}