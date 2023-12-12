import 'package:dto/pet.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../styles/font.dart';

import '../../styles/spacings.dart';
import '../../widgets/card.dart' as my_card;
import '../../widgets/services/firestore.dart';

import 'template_screen.dart';
import '../animals/create_screen.dart';

class HomePageScreen extends StatelessWidget {
  const HomePageScreen({super.key});

  static const String routeName = '/home';

  @override
  Widget build(BuildContext context) {
    late FirestoreService firestoreService;
    final FirebaseAuth auth = FirebaseAuth.instance;
    firestoreService = FirestoreService(auth.currentUser!.uid);

    final user = auth.currentUser?.displayName;
    final userName = user ?? '';

    return HomePageTemplate(
      title: Text(
        'Bienvenue $userName !',
        textAlign: TextAlign.left,
        style: kTitleStyleWhite,
      ),
      flexibleContent: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: kPadding,
          vertical: kVerticalPaddingL - 8,
        ),
        child: Column(
          children: [
            my_card.Card(
              child: Padding(
                padding: const EdgeInsets.all(kPaddingS),
                child: SizedBox(
                  height: 180,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Mes animaux',
                            style: kSectionTitle,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => const AnimalsPageScreenCreate(docID: ''),
                                ),
                              );
                            },
                            child: const Icon(Icons.add),
                          ),
                        ],
                      ),
                      Expanded(
                        child: StreamBuilder<QuerySnapshot<Pet>>(
                          stream: firestoreService.getAnimals(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              List<DocumentSnapshot<Pet>> petsList = snapshot.data!.docs;
                              if (petsList.isEmpty) {
                                return const Text('Ajouter un animal pour commencer');
                              } else {
                                return ListView.builder(
                                  itemCount: petsList.length,
                                  itemBuilder: (context, index) {
                                    Pet pet = petsList[index].data()!;
                                    return ListTile(
                                      title: Text(pet.name),
                                    );
                                  },
                                );
                              }
                            } else {
                              return const CircularProgressIndicator();
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
