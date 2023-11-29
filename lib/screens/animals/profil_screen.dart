import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../widgets/services/firestore.dart';
import '../main_screen.dart';
import 'create_screen.dart';

class PetProfileScreen extends StatefulWidget {
  final String docID;

  const PetProfileScreen({required this.docID, super.key});

  @override
  State<PetProfileScreen> createState() => _PetProfileScreenState();
}

class _PetProfileScreenState extends State<PetProfileScreen> {
  final FirestoreService firestoreService = FirestoreService();

  late Future<DocumentSnapshot> futureAnimal;

  @override
  void initState() {
    super.initState();
    futureAnimal = firestoreService.getAnimal(widget.docID);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: futureAnimal,
      builder: (context, snapshot) {
        var animalData = snapshot.data!.data() as Map<String, dynamic>;

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return const Center(child: Text('Il y a une erreur'));
        } else {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Profil de l‘animal'),
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Name: ${animalData['name']}'),
                    Text('Date of Birth: ${animalData['dob']}'),
                    Text('Weight: ${animalData['weight']} kg'),
                    Text('Gender: ${animalData['gender']}'),
                    Text('Race: ${animalData['race']}'),
                    Text('Vaccination: ${animalData['vaccinated']}'),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
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
                  onPressed: () async {
                    await firestoreService.deleteAnimal(widget.docID);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MainScreenPage(),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        }
      },
    );
  }
}