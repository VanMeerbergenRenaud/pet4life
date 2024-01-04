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
import '../animals/profil_screen.dart';

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
                  height: 200,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: kHorizontalPaddingS),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Mes animaux',
                              style: kSectionTitle,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const AnimalsPageScreenCreate(
                                            docID: ''),
                                  ),
                                );
                              },
                              child: const Icon(Icons.add),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: kVerticalPaddingS + 4),
                      Expanded(
                        child: StreamBuilder<QuerySnapshot<Pet>>(
                          stream: firestoreService.getAnimals(),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            }
                            if (snapshot.hasData) {
                              List<DocumentSnapshot<Pet>> petsList =
                                  snapshot.data!.docs;
                              if (petsList.isEmpty) {
                                return const Center(
                                    child: Text(
                                        'Ajouter un animal pour commencer'));
                              } else {
                                return ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: petsList.length,
                                  itemBuilder: (context, index) {
                                    Pet pet = petsList[index].data()!;
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                PetProfileScreen(
                                                    docID: petsList[index].id),
                                          ),
                                        );
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: kHorizontalPaddingS),
                                        child: Column(
                                          children: [
                                            CircleAvatar(
                                              radius: 44,
                                              backgroundImage: pet.imageUrl !=
                                                      ''
                                                  ? NetworkImage(pet.imageUrl)
                                                  : const AssetImage(
                                                          'assets/img/default.png')
                                                      as ImageProvider,
                                            ),
                                            const SizedBox(
                                                height: kVerticalPaddingS),
                                            Text(
                                              pet.name[0].toUpperCase() +
                                                  pet.name.substring(1),
                                              style: kLabelStyle,
                                            ),
                                          ],
                                        ),
                                      ),
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
