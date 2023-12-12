import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dto/pet.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../widgets/services/firestore.dart';
import '../main_screen.dart';
import 'create_screen.dart';

class PetProfileScreen extends StatefulWidget {
  const PetProfileScreen({required this.docID, super.key});

  final String docID;

  @override
  State<PetProfileScreen> createState() => _PetProfileScreenState();
}

class _PetProfileScreenState extends State<PetProfileScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late FirestoreService firestoreService;
  late Future<DocumentSnapshot> futureAnimal;

  @override
  void initState() {
    super.initState();
    firestoreService = FirestoreService(_auth.currentUser!.uid);
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
          String imageUrl = data.imageUrl.toString();
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
                // image of the pet
                imageUrl != ''
                    ? Image.network(
                        imageUrl,
                        height: 250,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        'assets/img/default.png',
                        height: 250,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.cover,
                      ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Nom: $name'),
                    Text('Date de naissance: $dob'),
                    Text('Poids: $weight kg'),
                    Text('Genre: $gender'),
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
                        builder: (context) =>
                            AnimalsPageScreenCreate(docID: widget.docID),
                      ),
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MainScreenPage(),
                      ),
                    );
                    await firestoreService.deleteAnimal(widget.docID);
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
