import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../styles/font.dart';
import '../../styles/spacings.dart';
import '../../widgets/services/firestore.dart';
import '../animals/create_screen.dart';
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
                      // String docID = document.id;

                      // display as a list
                      return ListView.builder(
                        itemCount: animalsList.length,
                        itemBuilder: (context, index) {
                          // get each animal document
                          DocumentSnapshot document = animalsList[index];
                          String docID = document.id;

                          // get note from each document
                          Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                          String imageUrl = data['imageUrl'];
                          String name = data['name'];

                          // display as a list tile with name and image
                          return ListTile(
                            // leading: Image.network(imageUrl),
                            title: Text(name),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit),
                                  onPressed: () {
                                    // openAnimalModal(docID: docID);
                                    // return another page with the animal data
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
                            )
                          );
                        },
                      );
                    } else {
                      return const Text('no animals yet');
                    }
                  },
                ),
              )
            ],
          )
      ),
    );
  }
}