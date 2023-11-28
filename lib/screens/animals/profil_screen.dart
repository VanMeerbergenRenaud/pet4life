import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pet4life/styles/font.dart';

import '../../widgets/services/firestore.dart';
import 'create_screen.dart';

class PetProfileScreen extends StatefulWidget {
  final DocumentSnapshot pet;

  const PetProfileScreen({super.key, required this.pet});

  @override
  State<PetProfileScreen> createState() => _PetProfileScreenState();
}

class _PetProfileScreenState extends State<PetProfileScreen> {
  final FirestoreService firestoreService = FirestoreService();

  late String docID;

  @override
  Widget build(BuildContext context) {
    // Build your pet profile screen here
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil de l‘animal'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Profil de ${widget.pet['name']}',
            style: kLabelStyle,
          ),
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              // return another page with the animal data (docID)
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AnimalsPageScreenCreate(),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              firestoreService.deleteAnimal(docID);
            },
          ),
        ],
      ),
    );
  }
}