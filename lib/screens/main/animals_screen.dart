import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dto/pet.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../styles/font.dart';
import '../../styles/spacings.dart';
import '../../widgets/services/firestore.dart';
import '../../widgets/card.dart' as my_card;
import '../animals/create_screen.dart';
import '../animals/profil_screen.dart';
import 'template_screen.dart';

class AnimalsPageScreen extends StatelessWidget {
  AnimalsPageScreen({super.key});

  static const String routeName = '/animals';

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final FirestoreService firestoreService = FirestoreService(_auth.currentUser!.uid);

    return HomePageTemplate(
      title: const Text(
        'Vos animaux',
        textAlign: TextAlign.center,
        style: kTitleStyleWhite,
      ),
      flexibleContent: Padding(
        padding: const EdgeInsets.all(kPadding),
        child: Column(
          children: [
            // stream of animals
            Expanded(
              child: StreamBuilder<QuerySnapshot<Pet>>(
                stream: firestoreService.getAnimals(),
                builder: (context, snapshot) {
                  // if I have data -> get all the documents
                  if (snapshot.hasData) {
                    List<DocumentSnapshot<Pet>> animalsList = snapshot.data!.docs;

                    // if I don't have data -> display a message
                    if (animalsList.isEmpty) {
                      return my_card.Card(
                        child: Column(
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: kHorizontalPaddingXL,
                                vertical: kVerticalPaddingL,
                              ),
                              child: Text(
                                'Vous n‘avez pas encore d‘animal.',
                                style: kTextDiverStyle,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const AnimalsPageScreenCreate(docID: '',),
                                  ),
                                );
                              },
                              child: const Text('Ajouter un animal'),
                            ),
                          ],
                        ),
                      );
                    }

                    // display as a grid
                    return GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: kHorizontalPadding,
                      mainAxisSpacing: kHorizontalPadding,
                      children: List.generate(animalsList.length, (index) {
                        DocumentSnapshot<Pet> document = animalsList[index];
                        String docID = document.id;
                        Pet? data = document.data();
                        String imageUrl = data!.imageUrl;
                        String name = data.name;

                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    PetProfileScreen(docID: docID),
                              ),
                            );
                          },
                          child: my_card.Card(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 50,
                                  backgroundImage: NetworkImage(imageUrl),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(kPaddingS),
                                  child: Text(
                                    name,
                                    style: kTitleStyle,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      ),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}