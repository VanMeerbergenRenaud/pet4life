import 'package:cloud_firestore/cloud_firestore.dart';
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

  final FirestoreService firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
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
              child: StreamBuilder<QuerySnapshot>(
                stream: firestoreService.getAnimals(),
                builder: (context, snapshot) {
                  // if I have data -> get all the documents
                  if (snapshot.hasData) {
                    List animalsList = snapshot.data!.docs;

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
                                    builder: (context) =>
                                        const AnimalsPageScreenCreate(),
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
                          DocumentSnapshot document = animalsList[index];
                          String docID = document.id;
                          Map<String, dynamic> data = document.data() as Map<String, dynamic>;

                          // String imageUrl = data['imageUrl'];
                          String name = data['name'];

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
                                  const CircleAvatar(
                                    radius: 50,
                                    backgroundImage: NetworkImage('https://www.woolha.com/media/2020/03/eevee.png'),
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
