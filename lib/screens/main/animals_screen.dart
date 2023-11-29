import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../styles/font.dart';
import '../../styles/spacings.dart';
import '../../widgets/services/firestore.dart';
import '../../widgets/card.dart' as my_card;
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

                    // display as a grid
                    return GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: kHorizontalPadding,
                      mainAxisSpacing: kHorizontalPadding,
                      children: List.generate(animalsList.length, (index) {
                          DocumentSnapshot document = animalsList[index];
                          String docID = document.id;
                          Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                          String imageUrl = data['imageUrl'];
                          String name = data['name'];

                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PetProfileScreen(pet: document),
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
                                  /*IconButton(
                                    icon: const Icon(Icons.delete),
                                    onPressed: () {
                                      firestoreService.deleteAnimal(docID);
                                    },
                                  ),*/
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                    // if I don't have data -> display a message
                  } else {
                    return const Text('no animals yet');
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
