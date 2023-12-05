import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dto/pet.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../widgets/services/firestore.dart';
import '../main_screen.dart';
import 'create_screen.dart';

class PetProfileScreen extends StatefulWidget {
  final String docID;

  const PetProfileScreen({
    required this.docID, super.key
  });

  @override
  State<PetProfileScreen> createState() => _PetProfileScreenState();
}

class _PetProfileScreenState extends State<PetProfileScreen> {
  final FirestoreService firestoreService = FirestoreService('G6vTQaoxMAOih0n9RjSHNRe3Ewv2');

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
        if (snapshot.hasData && snapshot.data != null) {
          Pet data = snapshot.data!.data() as Pet;
          String name = data.name;
          String dob = data.dob.toString().substring(0, 10);
          String weight = data.weight.toString();
          String gender = data.gender.toString();
          String race = data.race.toString();
          String vaccination = data.vaccination.toString();

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
                    Text('Name: $name'),
                    Text('Date of Birth: $dob'),
                    Text('Weight: $weight kg'),
                    Text('Gender: $gender'),
                    Text('Race: $race'),
                    Text('Vaccination: $vaccination'),
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
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
